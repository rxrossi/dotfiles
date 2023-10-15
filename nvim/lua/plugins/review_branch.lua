function ReviewBranch()
  local merge_base = vim.fn.system('git merge-base development HEAD'):gsub('[\n\r]', ' ')

  vim.cmd('Git difftool --name-status ' .. merge_base)
  vim.cmd('Gitsigns change_base ' .. merge_base .. 'true')
  vim.cmd('Neotree git_base=' .. merge_base)

  vim.keymap.set('n', '<space>N', function()
    vim.cmd(':Neotree left git_status ' .. merge_base)
  end, {})
  vim.keymap.set('n', '<space><space>', function()
    vim.cmd ':Gitsigns diffthis'
  end, {})
end

vim.cmd [[ :command! ReviewBranch lua ReviewBranch() ]]

return {}
