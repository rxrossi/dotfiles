return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = "Obsidian",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "default",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main",
      },
    },
    ui = {
      enable = false, -- set to false to disable all additional syntax features
    },
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = false,
      -- Enables completion using blink.cmp
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
  },
}
