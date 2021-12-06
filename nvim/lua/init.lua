local remap = require("utils").map_global;

require'bootstrap_packer'
require'plugins'
require'treesitter_settings'
require'gitsigns_settings'
require'plugins_cfg.dap'

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
  pickers = {
    oldfiles = {
      sort_mru = true
    },
    buffers = {
      sort_mru = true
    },
  },
})

remap(
  "n",
  "<Leader>dc",
  [[ <Cmd>lua require("plugins_cfg.dap.attach"):addPlug(); require'dap'.continue()<CR>]]
);

remap(
  "n",
  "<Leader>db",
  [[ <Cmd>lua require("plugins_cfg.dap.attach"):addPlug(); require'dap'.toggle_breakpoint()<CR>]]
);
