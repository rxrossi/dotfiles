call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'chrisbra/Colorizer'  
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mattn/emmet-vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'kamykn/spelunker.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-abolish'
Plug 'Raimondi/delimitMate'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'zacacollier/vim-javascript-sql', { 'branch': 'add-typescript-support' }
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'mzlogin/vim-markdown-toc'
Plug 'Asheq/close-buffers.vim'
Plug 'liuchengxu/vista.vim'
Plug 'mzlogin/vim-markdown-toc'
Plug 'shmup/vim-sql-syntax'

call plug#end()

source $HOME/.config/nvim/coc-default.vim
source $HOME/.config/nvim/coc-git.vim


let wiki = {}
let wiki.nested_syntaxes = { 'python': 'python', 'c++': 'cpp', 'sql': 'sql', 'javascript': 'javascript', 'typescript': 'typescript' }
let g:vimwiki_list = [wiki]

set foldmethod=indent
set foldlevelstart=1000
set mouse=a
set linebreak

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')
" Run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])
command! -nargs=0 Bdt :b#<bar>bd#<CR>
" Run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<CR>
" Run jest for current test file
nnoremap <leader>tf :call CocAction('runCommand', 'jest.fileTest', ['%'])<CR>
"
" statusline
set laststatus=2

" Snippets related
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Theme related
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-materia
hi Normal guibg=NONE ctermbg=NONE
set termguicolors
set number
set relativenumber

set splitbelow
set splitright
noremap <space>tv :vsplit\|terminal<CR>a
noremap <space>ts :split\|terminal<CR>a

noremap <space>f :GFiles --exclude-standard --others --cached<CR>
noremap <space>F :Rg<CR>
noremap <space>b :Buffers<CR>
noremap <space>h :History:<CR>
tnoremap <C-w> <C-\><C-n><C-w>

" Tab related config
" insert spaces instead of TAB
set expandtab
set shiftwidth=2

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

function! GetCurrentWorkspace() 
  lcd %:p:h
  lcd `upfind package.json` 
  CocRestart
  cd `git rev-parse --show-toplevel`
  redraw
endfunction

noremap <space>w :call GetCurrentWorkspace()<CR>
autocmd BufRead *.ts :call GetCurrentWorkspace()

" NERDTree
:let g:NERDTreeWinSize=60

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <space>n :NERDTreeFind<CR>

" COC Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

" Save with ctrl-s
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" spelunker
let g:enable_spelunker_vim = 1
let g:enable_spelunker_vim_on_readonly = 1
" Check spelling for words longer than set characters. (default: 4)
let g:spelunker_target_min_char_len = 1

" FZF
let $FZF_DEFAULT_OPTS="--preview '[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -500'"

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

"This is the default extra key bindings

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '10new' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
