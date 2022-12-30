local rt = require("rust-tools")

rt.setup({
  server = {
    cmd = { os.getenv('HOME')  .. '/.local/share/nvim/lsp_servers/rust/rust-analyzer' },
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  dap = {
    adapter = {
      name = "rt_lldb",
      type = 'server',
      port = "${port}",
      executable = {
        command = os.getenv('HOME') .. '/codelldb/extension/adapter/codelldb',
        args = {"--port", "${port}"},

        -- On windows you may have to uncomment this:
        -- detached = false,
      }

    },
  },
})

rt.inlay_hints.enable()

