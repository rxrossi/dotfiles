return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "davidmh/cspell.nvim"
  },
  opts = function()
    local null_ls = require 'null-ls'

    local sources = {
      -- null_ls.builtins.diagnostics.cspell.with {
      --   extra_args = {
      --     -- To make pt-BR work, you also need to install this:
      --     -- https://www.npmjs.com/package/cspell-dict-pt-br
      --     '-c',
      --     vim.fn.expand '~/dotfiles/nvim/cspell.json',
      --     '--show-suggestions',
      --     '-u',
      --     '--locale',
      --     'en-GB,pt-BR',
      --   },
      -- },
      -- null_ls.builtins.code_actions.cspell.with {
      --   config = {
      --     find_json = function()
      --       return vim.fn.expand '~/dotfiles/nvim/cspell.json'
      --     end,
      --   },
      -- },

      null_ls.builtins.formatting.prettierd,
      -- null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.stylua,
      -- null_ls.builtins.diagnostics.eslint_d.with {
      --   condition = function(utils)
      --     return utils.root_has_file { '.eslintrc.js' } or utils.root_has_file { '.eslintrc.cjs' }
      --   end,
      -- },
      -- null_ls.builtins.code_actions.eslint_d,
    }

    local cspell = require("cspell")
    local cspell_config = {
      find_json = function(directory)
        return vim.fn.expand '~/dotfiles/nvim/cspell.json'
      end
    }
    table.insert(
      sources,
      cspell.diagnostics.with({
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity.HINT
        end,
        config = cspell_config
      })
    )
    table.insert(sources, cspell.code_actions.with({
      config = cspell_config
    }))

    return {
      sources = sources,
      debounce = 750,
    }
  end,
}
