function! s:codeReview_complete(arg,line,pos)
  return ListBranches()
endfunction

function ListBranches()
  let l:commandOutputAsList = split(execute("!git branch -a --sort=-committerdate"), "\n")
  let l:branches = map(map(l:commandOutputAsList, 'trim(v:val)')[2:], 'trim(v:val, "* ")')

  return join(l:branches, "\n")
endfunction


let codeReviewTargetBranch = "main"

function CodeReview(newBranch, mainBranch = "main")
  let codeReviewTargetBranch = a:mainBranch

  silent execute "!git checkout " . a:newBranch
  execute "Git difftool --name-status " . a:mainBranch . "... ':!**/graphql.types*'"

  nnoremap dm <cmd>execute "Gvdiffsplit " . codeReviewTargetBranch . "..."<cr>
  map <leader>p <C-w>q[qdm
  map <leader>n <C-w>q]qdm
endfunction

command! -nargs=* -range -complete=custom,s:codeReview_complete CodeReview call CodeReview(<f-args>)
