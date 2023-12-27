return {
  'jose-elias-alvarez/null-ls.nvim',
  opts = function()
    local null_ls = require 'null-ls'

    local sources = {
      null_ls.builtins.diagnostics.cspell.with {
        extra_args = {
          -- To make pt-BR work, you also need to install this:
          -- https://www.npmjs.com/package/cspell-dict-pt-br
          '-c',
          vim.fn.expand '~/dotfiles/nvim/cspell.json',
          '--show-suggestions',
          '-u',
          '--locale',
          'en-GB,pt-BR',
        },
      },
      null_ls.builtins.code_actions.cspell.with {
        config = {
          find_json = function()
            return vim.fn.expand '~/dotfiles/nvim/cspell.json'
          end,
        },
      },

      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.eslint_d.with {
        condition = function(utils)
          return utils.root_has_file { '.eslintrc.js' } or utils.root_has_file { '.eslintrc.cjs' }
        end,
      },
      null_ls.builtins.code_actions.eslint_d,
    }

    return {
      sources = sources,
      debounce = 750,
    }
  end,
}
