return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    skip_confirm_for_simple_edits = true
  },

  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,

  config = function ()
    require('oil').setup()
    vim.keymap.set('n', '<space>o', function() vim.cmd([[Oil]]) end, { desc = "open Oil" })
  end,
}
