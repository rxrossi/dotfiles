:lua require'init'

source  $HOME/.config/nvim/defx_settings.vim
source  $HOME/.config/nvim/coc.vim

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
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope command_history<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>

" Fugitive
nnoremap <leader>g <cmd>:G<cr>

" wiki
let wiki = {}
let wiki.nested_syntaxes = { 'python': 'python', 'c++': 'cpp', 'sql': 'sql', 'pgsql': 'pgsql',  'javascript': 'javascript', 'typescript': 'typescript' }
let g:vimwiki_list = [wiki]
let g:vimwiki_url_maxsave=0

" Spelling
set spell
set spelllang=en_gb
set spelloptions=camel
set spellcapcheck=

" Fugitive
let g:fugitive_pty = 0
autocmd FileType fugitive          nnoremap <buffer> cc :G commit -n <CR>
autocmd FileType fugitive          nnoremap <buffer> ca :G commit -n --amend<CR>

" ColorScheme
colorscheme base16-materia
function! TweakBase16()
    " Override the diff-mode highlights of base16.
    highlight DiffAdd    term=bold ctermfg=0 ctermbg=2 guifg=#2b2b2b guibg=#a5c261
    highlight DiffDelete term=bold ctermfg=0 ctermbg=1 gui=bold guifg=#2b2b2b guibg=#da4939
    highlight DiffChange term=bold ctermfg=0 ctermbg=4 guifg=#2b2b2b guibg=#6d9cbe
    highlight DiffText   term=reverse cterm=bold ctermfg=0 ctermbg=4 gui=bold guifg=#2b2b2b guibg=#6d9cbe
endfunction
autocmd BufEnter * if &diff |  call TweakBase16() | endif
