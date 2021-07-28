:lua require'init'

source  $HOME/.config/nvim/defx_settings.vim
source  $HOME/.config/nvim/coc.vim

set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300

set foldmethod=indent
set foldlevelstart=2

set tabstop=2 shiftwidth=2 expandtab
set hidden
set mouse=a
set smartcase
set laststatus=2
set cmdheight=2
set undofile
set completeopt=menuone,noselect

colorscheme base16-materia

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
