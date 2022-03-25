:lua require'init'

set nocompatible
filetype plugin on
syntax on

source  $HOME/.config/nvim/defx_settings.vim
source  $HOME/.config/nvim/coc.vim
source  $HOME/.config/nvim/codereview.vim

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

" Find files using Telescope command-line sugar.
nnoremap <leader><leader> <cmd>Telescope <cr>
nnoremap <leader>ff <cmd>Telescope find_files find_command=rg,--hidden,--files<cr>
nnoremap <leader>fg <cmd>:lua require("telescope").extensions.live_grep_raw.live_grep_raw()<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope command_history<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>

let g:rooter_manual_only = 1
let g:rooter_patterns = ['.git', '.svn', 'package.json', '!node_modules']
" cd into Package
command Pcd execute "cd " . FindRootDirectory()
" cd into Git root by using Gcd

" wiki
let wiki = {}
let wiki.nested_syntaxes = { 'python': 'python', 'c++': 'cpp', 'sql': 'sql', 'pgsql': 'pgsql',  'javascript': 'javascript', 'typescript': 'typescript' }
let g:vimwiki_list = [wiki]
let g:vimwiki_url_maxsave=0

" Fugitive
let g:fugitive_pty = 0
autocmd FileType fugitive          nnoremap <buffer> cc :G commit -n <CR>
autocmd FileType fugitive          nnoremap <buffer> ca :G commit -n --amend<CR>

" ColorScheme
colorscheme base16-materia
" colorscheme base16-one-light

function! TweakBase16()
    " Override the diff-mode highlights of base16.
    highlight DiffAdd    term=bold ctermfg=0 ctermbg=2 guifg=#2b2b2b guibg=#a5c261
    highlight DiffDelete term=bold ctermfg=0 ctermbg=1 gui=bold guifg=#2b2b2b guibg=#da4939
    highlight DiffChange term=bold ctermfg=0 ctermbg=4 guifg=#2b2b2b guibg=#6d9cbe
    highlight DiffText   term=reverse cterm=bold ctermfg=0 ctermbg=4 gui=bold guifg=#2b2b2b guibg=#6d9cbe
endfunction
" autocmd BufEnter * if &diff |  call TweakBase16() | endif

nnoremap Y y$
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

nnoremap <leader>cn :tabnew ~/Box/bujo/index.md
nnoremap <leader>cs <cmd>source $MYVIMRC<cr>

nnoremap <leader>p <cmd>CocCommand prettier.formatFile<cr>

" tsconfig.json is actually jsonc, help TypeScript set the correct filetype
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

set noswapfile

nnoremap <Leader>df <Cmd>lua require("dapui").float_element("scopes", {enter = true})<CR>
nnoremap <Leader>dw <Cmd>lua require("dapui").float_element("watches", {enter = true})<CR>
nnoremap <Leader>dB <Cmd>lua require("dapui").float_element("breakpoints", {enter = true})<CR>
nnoremap <Leader>dk <Cmd>lua require("dap.ui.widgets").hover()<CR>
nnoremap <Leader>dh <Cmd>lua require'dap'.run_to_cursor()<CR>
nnoremap <Leader>dt <Cmd>lua require'dapui'.toggle()<CR>
nnoremap <Leader>dC <Cmd>lua require'dap'.clear_breakpoints()<CR>

let g:table_mode_corner='|'

" js timestamp milliseconds to date as comment
let @t = 'yiwea //ÄkbÄkbphhxxxh"mciw//i**i=kqÄkb'

noremap <space>h :lua require("harpoon.mark").add_file()<CR>
noremap <space>g :lua require("harpoon.ui").toggle_quick_menu()<CR>

nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>

nmap <space>e <Cmd>CocCommand explorer<CR>
