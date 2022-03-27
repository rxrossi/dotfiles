require("config/plugins")
require("config/treesitter")
require("config/gitsigns")
require("config/telescope")
require("config/lspc")
require("config/null-ls")
require("config/nvim-tree")
require("aw")

-- vim.opt_local.suffixesadd:prepend('.lua')
-- vim.opt_local.suffixesadd:prepend('init.lua')
-- vim.opt_local.path:prepend(vim.fn.stdpath('config')..'/lua')

vim.cmd([[
  set termguicolors

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

  noremap <silent> <Leader>p :lua vim.lsp.buf.formatting()<CR>

  autocmd! bufwritepost $MYVIMRC source $MYVIMRC

]])

function AddWordToCSpell()
	package.loaded["aw"] = nil
	require("aw").addWordToCSpell()
end

vim.cmd([[
  autocmd! bufwritepost aw.lua source $MYVIMRC
  command! AW lua AddWordToCSpell() <CR>
]])
