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

vim.cmd([[
  source  $HOME/.config/nvim/code-review.vim
]])

-- vim.opt_local.suffixesadd:prepend('.lua')
-- vim.opt_local.suffixesadd:prepend('init.lua')
-- vim.opt_local.path:prepend(vim.fn.stdpath('config')..'/lua')

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

  colorscheme base16-materia

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
