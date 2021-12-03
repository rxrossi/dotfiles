function! CodeReview_complete(arg,line,pos)
  return ListBranches()
endfunction

function! ListBranches()
  let l:commandOutputAsList = split(execute("!git branch -a --sort=-committerdate"), "\n")
  let l:branches = map(map(l:commandOutputAsList, 'trim(v:val)')[2:], 'trim(v:val, "* ")')

  return join(l:branches, "\n")
endfunction


let codeReviewTargetBranch = "main"

function ReviewLocalBranches(sourceBranch, targetBranch = "main")
  let codeReviewTargetBranch = a:targetBranch

  silent execute "!git checkout " . a:sourceBranch
  silent execute "Git difftool --name-status " . a:targetBranch . "... ':!**/graphql.types*'"
  silent execute "Gitsigns change_base " .  codeReviewTargetBranch . " true"

  nnoremap dm <cmd>execute "Gvdiffsplit " . codeReviewTargetBranch . "..."<cr>
  map <leader>p <C-w>q[qdm
  map <leader>n <C-w>q]qdm

  nnoremap dmq <enter> <c-w>o <cmd>copen<cr> <C-w>w <cmd>execute "Gvdiffsplit " . codeReviewTargetBranch . "..."<cr>
endfunction

command! -nargs=* -range -complete=custom,s:codeReview_complete CodeReviewLocal call ReviewLocalBranches(<f-args>)

function ReviewRemoteBranch (sourceBranch, targetBranch = "main")
  execute "!git fetch"

  execute "!git checkout " . a:targetBranch
  execute "!git pull"
  execute "!git checkout " . a:sourceBranch
  execute "!git pull"

  call ReviewLocalBranches(a:sourceBranch, a:targetBranch)
endfunction

command! -nargs=* -range CodeReviewRemote silent call ReviewRemoteBranch(<f-args>)
