require'bootstrap_packer'
require'plugins'
require'treesitter_settings'
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

require('telescope').setup({
  defaults = {
    layout_strategy = "vertical",
  },
})

-- mfussenegger/nvim-dap
-- local dap = require('dap')
-- dap.adapters.node2 = {
--   type = 'executable',
--   command = 'node',
--   args = {os.getenv('HOME') .. '/vscode-node-debug2/out/src/nodeDebug.js'},
-- }
-- local dap_install = require("dap-install")
-- local dbg_list = require("dap-install.debuggers_list").debuggers

-- for debugger, _ in pairs(dbg_list) do
-- 	dap_install.config(debugger, {})
-- end

-- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>dh', ':lua require"dap".toggle_breakpoint()<CR>')

