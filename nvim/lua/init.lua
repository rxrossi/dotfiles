require'bootstrap_packer'
require'plugins'
require'treesitter_settings'
require'lsp_settings'
require'compe_settings'
require'gitsigns_settings'

vim.wo.relativenumber = true
vim.wo.number = true

-- Highlight on yank
vim.api.nvim_exec(
[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)
