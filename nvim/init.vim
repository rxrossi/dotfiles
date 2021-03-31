source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/general.vim
source $HOME/.config/nvim/wiki.vim
source $HOME/.config/nvim/fugitive.vim

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction

command! -register CopyMatches call CopyMatches(<q-reg>)

" noremap <C-6> <C-^>

nmap <leader>s <Plug>(DBUI_SaveQuery)
let g:db_ui_auto_execute_table_helpers=1

autocmd! bufwritepost .vim source %

