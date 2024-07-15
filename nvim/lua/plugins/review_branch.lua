vim.cmd([[
function! ReviewBranch_complete(arg,line,pos)
  return ListBranches()
endfunction

function! ListBranches()
  let l:commandOutputAsList = split(execute("!git branch -a --sort=-committerdate"), "\n")
  let l:branches = map(map(l:commandOutputAsList, 'trim(v:val)')[2:], 'trim(v:val, "* ")')

  return join(l:branches, "\n")
endfunction
]])

function ReviewBranch(base_branch)
  local merge_base = vim.fn.system("git merge-base " .. (base_branch or "main") .. " HEAD"):gsub("[\n\r]", " ")

  vim.cmd("Git difftool --name-status " .. merge_base)
  vim.cmd("Gitsigns change_base " .. merge_base .. "true")

  -- vim.cmd("Neotree git_base=" .. merge_base)
  -- vim.keymap.set("n", "<space>N", function()
  --   vim.cmd(":Neotree left git_status " .. merge_base)
  -- end, {})

  vim.keymap.set("n", "<space><space>", function()
    vim.cmd(":Gitsigns diffthis")
  end, {})
end

vim.cmd([[command! -nargs=* -range -complete=custom,ReviewBranch_complete ReviewBranch lua ReviewBranch(<f-args>)]])

return {}
