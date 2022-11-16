require("config/plugins")
require("config/treesitter")
require("config/gitsigns")
require("config/telescope")
require("config/lspc")
require("config/null-ls")
require("config/nvim-tree")
require("aw")
require("cspell-ca")
require("config/luasnip")
require("config/dap_cfg")
require("config/rust_tools_lsp_config")

vim.cmd([[
  source  $HOME/.config/nvim/code-review.vim
]])

vim.diagnostic.config({
	virtual_text = {
		source = true,
	},
})

vim.cmd([[
  set termguicolors

  set splitright

  set number
  set relativenumber
  set noswapfile

  set wrap
  set linebreak

  set encoding=utf-8
  set hidden

  set nobackup
  set nowritebackup

  set updatetime=300

  set foldmethod=indent
  set foldlevelstart=999

  set tabstop=2 shiftwidth=2 expandtab

  set ignorecase
  set smartcase

  set mouse=a

  set laststatus=2

  set cmdheight=2

  set undofile


  set completeopt=menuone,noselect

  set fcs=eob:\ " replace tilde on empty lines with space

  noremap  <silent> <C-S>         :update<CR>
  vnoremap <silent> <C-S>         <C-C>:update<CR><ESC>
  inoremap <silent> <C-S>         <C-O>:update<CR><ESC>

  " colorscheme base16-gruvbox-dark-medium
  " colorscheme base16-dracula
  " colorscheme base16-outrun_dark
  " colorscheme base16-nord
  colorscheme base16-ocean

  " tsconfig.json is actually jsonc, help TypeScript set the correct filetype
  autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

  " rooter
  let g:rooter_manual_only = 1
  let g:rooter_patterns = ['.git', '.svn', 'package.json', '!node_modules']
  " cd into Package
  command! Pcd execute "cd " . FindRootDirectory()
  " cd into Git root by using Gcd provided by Fugitive

  noremap <silent> <Leader>p :lua print('use space f instead')<CR>

  autocmd! bufwritepost $MYVIMRC source $MYVIMRC

  augroup HighlightTODO
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
  augroup END

]])

function AddWordToCSpell()
	package.loaded["aw"] = nil
	require("aw").addWordToCSpell()
end

vim.cmd([[
  autocmd! bufwritepost aw.lua source $MYVIMRC
  command! AW lua AddWordToCSpell() <CR>
]])

require("nvim-autopairs").setup({})

vim.cmd([[
   nnoremap [q <cmd>cprev<CR>zz
   nnoremap ]q <cmd>cnext<CR>zz
   nnoremap [l <cmd>lprev<CR>zz
   nnoremap ]l <cmd>lnext<CR>zz
   set cursorline
]])

require("treesitter-context").setup({
	{
		enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
			-- For all filetypes
			-- Note that setting an entry here replaces all other patterns for this entry.
			-- By setting the 'default' entry below, you can control which nodes you want to
			-- appear in the context window.
			default = {
				"class",
				"function",
				"method",
				-- 'for', -- These won't appear in the context
				-- 'while',
				-- 'if',
				-- 'switch',
				-- 'case',
			},
			-- Example for a specific filetype.
			-- If a pattern is missing, *open a PR* so everyone can benefit.
			--   rust = {
			--       'impl_item',
			--   },
		},
		exact_patterns = {
			-- Example for a specific filetype with Lua patterns
			-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
			-- exactly match "impl_item" only)
			-- rust = true,
		},

		-- [!] The options below are exposed but shouldn't require your attention,
		--     you can safely ignore them.

		zindex = 20, -- The Z-index of the context window
		mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
	},
})

vim.cmd([[
  packadd cfilter
  let g:vim_markdown_no_extensions_in_markdown = 1
]])

vim.cmd([[
  command! S source $MYVIMRC
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
  hi QuickFixLine ctermfg=NONE cterm=bold guifg=#ea9560 gui=bold guibg=NONE
]])


function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        -- draw a line on H J K L keystrokes
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.cmd[[mapclear <buffer>]]
        vim.b.venn_enabled = nil
    end
end
-- toggle key mappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ":lua Toggle_venn()<CR>", { noremap = true})

vim.cmd([[
  let g:colors = getcompletion('', 'color')
  func! NextColors()
      let idx = index(g:colors, g:colors_name)
      return (idx + 1 >= len(g:colors) ? g:colors[0] : g:colors[idx + 1])
  endfunc
  func! PrevColors()
      let idx = index(g:colors, g:colors_name)
      return (idx - 1 < 0 ? g:colors[-1] : g:colors[idx - 1])
  endfunc
  nnoremap <C-n> :exe "colorscheme " .. NextColors()<CR>
  nnoremap <C-p> :exe "colorscheme " .. PrevColors()<CR>
]])


vim.api.nvim_set_keymap('v', '<leader>ca', '<ESC><cmd>lua vim.lsp.buf.range_code_action()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ca', '<ESC><cmd>lua vim.lsp.buf.code_action()<CR>', {noremap = true})

require('peek').setup({
  auto_load = true,         -- whether to automatically load preview when
                            -- entering another markdown buffer
  close_on_bdelete = true,  -- close preview window on buffer delete

  syntax = true,            -- enable syntax highlighting, affects performance

  theme = 'dark',           -- 'dark' or 'light'

  update_on_change = true,

  -- relevant if update_on_change is true
  throttle_at = 200000,     -- start throttling when file exceeds this
                            -- amount of bytes in size
  throttle_time = 'auto',   -- minimum amount of time in milliseconds
                            -- that has to pass before starting new render
})
