return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = "ObsidianToday",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "default",
        path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Main",
      },
    },
    ui = {
      enable = false,            -- set to false to disable all additional syntax features
    },
  },
}
