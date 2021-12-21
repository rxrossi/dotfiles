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

let sourceCommit = ""
let targetCommit = ""
function CompareWithPrevious(sourceCommit)
  let sourceCommit = a:sourceCommit
  let targetCommit = sourceCommit . "~1"

  execute "Git difftool --name-status " . targetCommit . " " . sourceCommit . " ':!**/graphql.types*'"
  nnoremap dm <cmd>execute "Gvdiffsplit!"<cr>
endfunction

command! -nargs=* -range CompareWithPrevious call CompareWithPrevious(<f-args>)

command! -nargs=* -range -complete=custom,CodeReview_complete CodeReviewLocal call ReviewLocalBranches(<f-args>)

function ReviewRemoteBranch (sourceBranch, targetBranch = "main")
  execute "!git fetch"

  execute "!git checkout " . a:targetBranch
  execute "!git pull"
  execute "!git checkout " . a:sourceBranch
  execute "!git pull"

  call ReviewLocalBranches(a:sourceBranch, a:targetBranch)
endfunction

command! -nargs=* -range CodeReviewRemote call ReviewRemoteBranch(<f-args>)
