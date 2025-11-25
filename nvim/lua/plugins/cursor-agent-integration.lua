-- Configuration constants
local DEBUG = false  -- Set to false to disable debug output
local SOCKET_PREFIX = "/tmp/nvim-"
local MCP_CONFIG_PATH = "~/.cursor/mcp.json"
local CURSOR_COMMAND = "cursor-agent --approve-mcps --browser"

--- Print debug messages only if DEBUG is enabled
--- @param ... any Arguments to print
local function debug_print(...)
  if DEBUG then
    print(...)
  end
end

--- Get or create Neovim socket path
--- @return string socket_path The sanitized socket path
local function get_or_create_socket()
  local socket_path
  
  if vim.v.servername == "" or vim.v.servername == nil then
    socket_path = SOCKET_PREFIX .. vim.fn.getpid()
    vim.cmd("call serverstart('" .. socket_path .. "')")
    debug_print("Started Neovim socket at:", socket_path)
  else
    socket_path = vim.v.servername
    debug_print("Using existing Neovim socket at:", socket_path)
  end
  
  return socket_path:gsub("%s+", "")
end

--- Update MCP config file with new socket path
--- @param socket_path string The socket path to write to config
--- @return boolean success Whether the update succeeded
local function update_mcp_config(socket_path)
  local mcp_path = vim.fn.expand(MCP_CONFIG_PATH)
  local file = io.open(mcp_path, "r")
  
  if not file then
    print("Error: Could not read " .. MCP_CONFIG_PATH)
    return false
  end
  
  local content = file:read("*all")
  file:close()
  
  local updated_content = content:gsub(
    '"NVIM_SOCKET_PATH"%s*:%s*"[^"]*"',
    '"NVIM_SOCKET_PATH": "' .. socket_path .. '"'
  )
  
  file = io.open(mcp_path, "w")
  if not file then
    print("Error: Could not write to " .. MCP_CONFIG_PATH)
    return false
  end
  
  file:write(updated_content)
  file:close()
  debug_print("Updated " .. MCP_CONFIG_PATH .. " with socket path:", socket_path)
  return true
end

--- Launch Cursor in a new tmux pane
--- @param socket_path string The socket path for Cursor to connect to
--- @return string|nil pane The tmux pane identifier, or nil on failure
local function launch_cursor_tmux(socket_path)
  local pane = vim.fn.system({
    "tmux",
    "split-window",
    "-h",
    "-P",
    "-F",
    "#{session_name}:#{window_index}.#{pane_index}",
    CURSOR_COMMAND,
  }):gsub("%s+", "")
  
  if vim.v.shell_error ~= 0 then
    print("Error: Failed to launch tmux pane")
    return nil
  end
  
  return pane
end

--- Main function to launch Cursor connected to current Neovim instance
local function LaunchCursorWithNeovim()
  local socket_path = get_or_create_socket()
  
  local config_updated = update_mcp_config(socket_path)
  if not config_updated then
    print("Warning: Proceeding without config update")
  end
  
  local pane = launch_cursor_tmux(socket_path)
  if pane then
    debug_print("Launched Cursor in tmux pane:", pane)
    debug_print("Cursor will connect to Neovim via socket:", socket_path)
  end
end

vim.api.nvim_create_user_command('CursorHere', LaunchCursorWithNeovim, {
  desc = "Launch Cursor in new tmux pane connected to this Neovim instance"
})

return {}
