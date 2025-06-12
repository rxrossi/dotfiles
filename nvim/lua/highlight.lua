vim.cmd([[
  set grepprg=rg\ --vimgrep
  set grepformat^=%f:%l:%c:%m

  augroup HighlightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('@comment.todo', 'TODO:', -1)
  augroup END

  augroup HighlightNOTE
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('@comment.todo', 'NOTE:', -1)
  augroup END

  augroup HighlightQUESTION
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('@comment.todo', 'QUESTION:', -1)
  augroup END
]])

vim.keymap.set("n", "<space>h", vim.lsp.buf.document_highlight, { desc = "highlight symbol" })
vim.keymap.set("n", "<space>l", vim.lsp.buf.clear_references, { desc = "clear highlight symbol" })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highligh when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highligh-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

