return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- help lspconfig-all to get the list of configs
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath('config')
              and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using (most
              -- likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
              -- Tell the language server how to find Lua modules same way as Neovim
              -- (see `:h lua-module-load`)
              path = {
                'lua/?.lua',
                'lua/?/init.lua',
              },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths
                -- here.
                -- '${3rd}/luv/library'
                -- '${3rd}/busted/library'
              }
              -- Or pull in all of 'runtimepath'.
              -- NOTE: this is a lot slower and will cause issues when working on
              -- your own configuration.
              -- See https://github.com/neovim/nvim-lspconfig/issues/3189
              -- library = {
              --   vim.api.nvim_get_runtime_file('', true),
              -- }
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })

      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format() end)

      vim.lsp.enable('bashls')

      vim.lsp.enable('eslint')

      vim.lsp.enable('css_variables')

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      vim.lsp.config('cssls', {
        capabilities = capabilities,
      })

      vim.lsp.enable('cssls')

      vim.lsp.enable('cssmodules_ls')

      vim.lsp.enable('emmet_ls')

      vim.lsp.config('html', {
        capabilities = capabilities,
      })

      vim.lsp.enable('html')

      vim.lsp.config('jsonls', {
        capabilities = capabilities,
      })

      vim.lsp.enable('jsonls')

      vim.lsp.enable('terraformls')

      vim.lsp.enable('solidity_ls')

      vim.lsp.enable('biome')

      vim.lsp.config('dockerls', {
        settings = {
          docker = {
            languageserver = {
              formatter = {
                ignoreMultilineInstructions = true,
              },
            },
          }
        }
      })
      vim.lsp.enable('dockerls')

      vim.lsp.enable('marksman')

      local function detect_local_ts_version()
        local pkg_path = vim.fn.getcwd() .. "/node_modules/typescript/package.json"

        local ok, content = pcall(vim.fn.readfile, pkg_path)

        if ok and content and #content > 0 then
          local decoded = vim.json.decode(table.concat(content, "\n"))

          if decoded and decoded.version then
            return tonumber(decoded.version:match("^(%d+)"))
          end
        end
        return nil
      end

      local ts_version = detect_local_ts_version()

      if ts_version and ts_version >= 7 then
        vim.lsp.config("tsgo", {
          cmd = function(dispatchers, config)
            local cmd = "tsc"

            if config and config.root_dir then
              local local_cmd = vim.fs.joinpath(config.root_dir, "node_modules/.bin", cmd)

              if vim.fn.executable(local_cmd) == 1 then
                cmd = local_cmd
              end
            end

            return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
          end,
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
        })

        vim.lsp.enable("tsc")
      else
        vim.lsp.config("ts_ls", {})
        vim.lsp.enable("ts_ls")
      end

      vim.keymap.set('n', 'grt', function() vim.lsp.buf.type_definition() end)
      vim.keymap.set('n', '<leader>d', function()
        vim.diagnostic.setqflist({ open = true, title = "LSP Diagnostics" })
      end)
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
