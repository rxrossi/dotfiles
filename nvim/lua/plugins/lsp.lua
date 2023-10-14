return {
  { "folke/neodev.nvim", opts = {} },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          local opts_with_desc = function(desc)
            return vim.tbl_extend("force", opts, { desc = desc })
          end

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts_with_desc("Go to declaration"))
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts_with_desc("Go to definition"))
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts_with_desc("Hover"))
          vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts_with_desc("Go to implementation"))
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts_with_desc("Signature help"))
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts_with_desc("Add folder to LSP workspace"))
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts_with_desc("Remove folder to LSP workspace"))
          vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts_with_desc("List LSP workspaces folders"))
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts_with_desc("Go to type definition"))
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts_with_desc("Rename"))
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts_with_desc("Code action"))
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts_with_desc("Find references"))
          vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts_with_desc("Format file"))
        end,
      })
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {},
    config = function()
      require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        --["rust_analyzer"] = function ()
        --  require("rust-tools").setup {}
        --end
      }
    end
  },
}
