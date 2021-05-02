source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/general.vim
source $HOME/.config/nvim/coc-default.vim
source $HOME/.config/nvim/coc-git.vim
source $HOME/.config/nvim/fzf.vim
source $HOME/.config/nvim/wiki.vim
source $HOME/.config/nvim/fugitive.vim
source $HOME/.config/nvim/defx.vim

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction

command! -register CopyMatches call CopyMatches(<q-reg>)

let g:vimwiki_url_maxsave=0

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "tsx" }
  },
}
EOF

set noswapfile
