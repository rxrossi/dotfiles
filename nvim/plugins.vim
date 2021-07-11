call plug#begin('~/.local/share/nvim/plugged')

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'shmup/vim-sql-syntax'
Plug 'lifepillar/pgsql.vim'
Plug 'jparise/vim-graphql'
" Plug 'pangloss/vim-javascript'
Plug 'vim-airline/vim-airline'
" BLOCKSTART When treesitter gets stable for tsx, we could remove both
" Plug 'leafgarland/typescript-vim'
" Plug 'maxmellon/vim-jsx-pretty'
" BLOCKEND
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'chriskempson/base16-vim'
Plug 'norcalli/nvim-colorizer.lua'

Plug 'mbbill/undotree'
Plug 'simnalamburt/vim-mundo'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'

Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Raimondi/delimitMate'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'vimwiki/vimwiki'
Plug 'mzlogin/vim-markdown-toc'
Plug 'yysfire/vimwiki2markdown'
"Plug 'bronson/vim-trailing-whitespace'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }

call plug#end()

autocmd! bufwritepost .vim source %
