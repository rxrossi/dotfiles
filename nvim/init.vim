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

let g:airline_powerline_fonts = 1                                                                                                         
let g:airline_section_b = '%{getcwd()}' " in section B of the status line display the CWD                                                 
                                                                                                                                          
"TABLINE:                                                                                                                                 
                                                                                                                                          
let g:airline#extensions#tabline#enabled = 1           
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline                                            
let g:airline#extensions#tabline#tabs_label = ''       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = ''    " can put text here like TABS to denote tabs (I clear it so nothing is shown)      
let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab                                                    
let g:airline#extensions#tabline#show_tab_count = 1    " show tab numbers on the right                                                           
let g:airline#extensions#tabline#show_buffers = 0      " don't show buffers in the tabline                                                 
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline                                  
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline               
let g:airline#extensions#tabline#show_tab_nr = 1       " disable tab numbers                                                              
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird orange arrow on the tabline

" Copy file name
" relative path
nmap <silent> <leader>y% :let @+ = expand("%")<cr>

" full path
:nmap <silent> <leader>yp :let @+ = expand("%:p")<cr>

" just filename
:nmap <silent> <leader>yt :let @+ = expand("%:t")<cr>

:nmap <silent> <leader>at :let @+ = expand("%:t")<cr><space>p

