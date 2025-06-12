vim.cmd([[
  if !isdirectory("/tmp/.vim-undo-dir")
      call mkdir("/tmp/.vim-undo-dir", "", 0700)
  endif
  set undodir=/tmp/.vim-undo-dir
  set undofile
]])
