return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
      },
      disable_inline_completion = false,
      disable_keymaps = false,
    })
  end,
}
