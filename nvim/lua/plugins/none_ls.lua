return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
    "davidmh/cspell.nvim"
  },
  opts = function()
    local null_ls = require 'null-ls'

    local sources = {
      null_ls.builtins.formatting.prettierd,
    }

    local cspell = require("cspell")
    local cspell_config = {
      find_json = function(_)
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
