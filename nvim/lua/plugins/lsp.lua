return {
  { 'folke/neodev.nvim', opts = {} },
  { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
  -- Add Rust & related to treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'ron', 'rust', 'toml' })
      end
    end,
  },

  -- Ensure Rust debugger is installed
  {
    'williamboman/mason.nvim',
    optional = true,
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'codelldb' })
      end
    end,
  },

  {
    'simrat39/rust-tools.nvim',
    opts = function()
      local ok, mason_registry = pcall(require, 'mason-registry')
      local adapter ---@type any
      if ok then
        -- rust tools configuration for debugging support
        local codelldb = mason_registry.get_package 'codelldb'
        local extension_path = codelldb:get_install_path() .. '/extension/'
        local codelldb_path = extension_path .. 'adapter/codelldb'
        local liblldb_path = ''
        if vim.loop.os_uname().sysname:find 'Windows' then
          liblldb_path = extension_path .. 'lldb\\bin\\liblldb.dll'
        elseif vim.fn.has 'mac' == 1 then
          liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
        else
          liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
        end
        adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
      end
      return {
        dap = {
          adapter = adapter,
        },
        tools = {
          on_initialized = function()
            vim.cmd [[
                  augroup RustLSP
                    autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                    autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                    autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                  augroup END
                ]]
          end,
        },
      }
    end,
    config = function() end,
  },

  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = {
      'rouge8/neotest-rust',
    },
    opts = {
      adapters = {
        ['neotest-rust'] = {},
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = function()
      return {
        servers = {
          -- Ensure mason installs the server
          rust_analyzer = {
            keys = {
              { 'K', '<cmd>RustHoverActions<cr>', desc = 'Hover Actions (Rust)' },
              { '<leader>cR', '<cmd>RustCodeAction<cr>', desc = 'Code Action (Rust)' },
              { '<leader>dr', '<cmd>RustDebuggables<cr>', desc = 'Run Debuggables (Rust)' },
            },
            settings = {
              ['rust-analyzer'] = {
                cargo = {
                  allFeatures = true,
                  loadOutDirsFromCheck = true,
                  runBuildScripts = true,
                },
                -- Add clippy lints for Rust.
                checkOnSave = {
                  allFeatures = true,
                  command = 'clippy',
                  extraArgs = { '--no-deps' },
                },
                procMacro = {
                  enable = true,
                  ignored = {
                    ['async-trait'] = { 'async_trait' },
                    ['napi-derive'] = { 'napi' },
                    ['async-recursion'] = { 'async_recursion' },
                  },
                },
              },
            },
          },
          taplo = {
            keys = {
              {
                'K',
                function()
                  if vim.fn.expand '%:t' == 'Cargo.toml' and require('crates').popup_available() then
                    require('crates').show_popup()
                  else
                    vim.lsp.buf.hover()
                  end
                end,
                desc = 'Show Crate Documentation',
              },
            },
          },
        },
        -- setup = {
        --   rust_analyzer = function(_, opts)
        --     print 'here'
        --     local rust_tools_opts = require('lazyvim.util').opts 'rust-tools.nvim'
        --     require('rust-tools').setup(vim.tbl_deep_extend('force', rust_tools_opts or {}, { server = opts }))
        --     return true
        --   end,
        -- },
      }
    end,
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
            return vim.tbl_extend('force', opts, { desc = desc })
          end

          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts_with_desc 'Go to declaration')
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts_with_desc 'Go to definition')
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts_with_desc 'Hover')
          vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts_with_desc 'Go to implementation')
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts_with_desc 'Signature help')
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
            opts_with_desc 'Add folder to LSP workspace')
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
            opts_with_desc 'Remove folder to LSP workspace')
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts_with_desc 'List LSP workspaces folders')
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts_with_desc 'Go to type definition')
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts_with_desc 'Rename')
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts_with_desc 'Code action')
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts_with_desc 'Find references')
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format { async = true }
          end, opts_with_desc 'Format file')
        end,
      })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {},
    config = function()
      require('mason-lspconfig').setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function(server_name) -- default handler (optional)
          require('lspconfig')[server_name].setup {}
        end,
        -- Next, you can provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ['rust_analyzer'] = function()
        -- end,
      }
    end,
  },
}
