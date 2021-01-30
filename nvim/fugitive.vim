let g:fugitive_pty = 0
autocmd FileType fugitive          nnoremap <buffer> cc :Gcommit <CR>
autocmd FileType fugitive          nnoremap <buffer> ca :Gcommit --amend<CR>
