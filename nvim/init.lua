local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000, init = function () vim.cmd([[colorscheme catppuccin]]) end },
  "tpope/vim-unimpaired",
  "tpope/vim-sleuth",
  { "numToStr/Comment.nvim", opts = {} },
  "jeetsukumaran/vim-indentwise",
  "michaeljsmith/vim-indent-object",
  "nvim-treesitter/nvim-treesitter-context",
  { import = "plugins" },
}
require("lazy").setup(plugins, {})

vim.cmd([[ packadd cfilter ]])

vim.o.number = true
vim.o.relativenumber = true

vim.o.expandtab = true

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.o.signcolumn = "yes"

vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true

vim.cmd([[set foldmethod=indent]])

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.diagnostic.config({
  virtual_text = false,
})

vim.cmd([[
  augroup HighlightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('IncSearch', 'TODO', -1)
  augroup END
]])
