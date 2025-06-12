return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<tab>",
        clear_suggestion = "<C-]>",
      },
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = false,          -- disables built in keymaps for more manual control
    })
  end,
}
