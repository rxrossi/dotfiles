local dap = require("dap")

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = os.getenv('HOME') .. '/codelldb/extension/adapter/codelldb',
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}
dap.adapters.cpp = dap.adapters.codelldb
dap.adapters.lldb = dap.adapters.codelldb

dap.adapters.node2 = {
	type = "executable",
	command = "node",
    args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'}
}

cppCfg = {
  previousPath= "",
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      if cppCfg.previousPath == "" then
        cppCfg.previousPath = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end
      return cppCfg.previousPath
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
  {
      -- If you get an "Operation not permitted" error using this, try disabling YAMA:
      --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      name = "Attach to process",
      type = 'cpp',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
      request = 'attach',
      pid = require('dap.utils').pick_process,
      args = {},
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp


dap.configurations.typescript = {
  {
		name = "jest",
		type = "node2",
		request = "attach",
		cwd = vim.fn.getcwd(),
		protocol = "auto",
		skipFiles = { "<node_internals>/**/*.js" },
		console = "integratedTerminal",
		port = 9229,
		internalConsoleOptions = "neverOpen",
		disableOptimisticBPs = true,
		sourceMaps = "inline",
		args = { "--no-cache" },
  }
}

require("dapui").setup({
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        "breakpoints",
        "scopes"
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "watches",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
})

vim.cmd([[ 
  nnoremap <Leader>df <Cmd>lua require("dapui").float_element("scopes", {enter = true})<CR>
  nnoremap <Leader>dw <Cmd>lua require("dapui").float_element("watches", {enter = true})<CR>
  nnoremap <Leader>dB <Cmd>lua require("dapui").float_element("breakpoints", {enter = true})<CR>
  nnoremap <Leader>dd <Cmd>lua require("dap.ui.widgets").hover()<CR>

  nnoremap <Leader>dh <Cmd>lua require'dap'.run_to_cursor()<CR>
  nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>
  nnoremap <silent> <leader>dj :lua require'dap'.step_into()<CR>
  nnoremap <silent> <leader>dk :lua require'dap'.step_out()<CR>
  nnoremap <silent> <leader>du :lua require'dap'.step_over()<CR>


  nnoremap <Leader>dt <Cmd>lua require'dapui'.toggle()<CR>
  nnoremap <Leader>dC <Cmd>lua require'dap'.clear_breakpoints()<CR>
  nnoremap <Leader>dr <Cmd>lua require'dap'.run_last()<CR>
  nnoremap <Leader>dx <Cmd>lua require'dap'.disconnect({terminateDebuggee = true})<CR>
]])

