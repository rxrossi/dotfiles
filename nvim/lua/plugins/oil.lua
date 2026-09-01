return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    skip_confirm_for_simple_edits = true,
    win_options = {
      -- required for oil-git-status.nvim (2 sign columns for index + worktree)
      signcolumn = "yes:2",
    },
  },

  -- Optional dependencies
  dependencies = {
    { "echasnovski/mini.icons", opts = {} },
    "refractalize/oil-git-status.nvim",
  },
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,

  config = function (_, opts)
    require('oil').setup(opts)
    require('oil-git-status').setup()
    vim.keymap.set('n', '<space>o', function() vim.cmd([[Oil]]) end, { desc = "open Oil" })
  end,
}
