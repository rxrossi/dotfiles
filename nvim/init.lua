vim.o.number = true
vim.o.relativenumber = true
vim.o.ic = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

require('config.lazy')

require('highlight')

require('persistent_undo')

vim.cmd([[packadd cfilter]])

vim.cmd([[ set linebreak ]])

vim.cmd([[
  set foldmethod=indent
  set foldlevelstart=999
  set foldlevel=999
]])

-- gra
-- grr
-- gri
-- grn
-- CTRL+S (signature help)

-- CTRL+X CTRL+O (omni complete)

-- vim.lsp.buf

-- CTRL+W CTRL+P (sort of a ctrl+^ but for windows)

-- fclose -> close floating windows

-- vimgrep term app/src/**, can change it to make it use rg
-- find file **

-- cdo -> cdo s:/text/new-txt/gc

-- CTRL+p in Oil opens preview and it is awesome

-- gO - outline

