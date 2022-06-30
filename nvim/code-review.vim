function! CodeReview_complete(arg,line,pos)
  return ListBranches()
endfunction

function! ListBranches()
  let l:commandOutputAsList = split(execute("!git branch -a --sort=-committerdate"), "\n")
  let l:branches = map(map(l:commandOutputAsList, 'trim(v:val)')[2:], 'trim(v:val, "* ")')

  return join(l:branches, "\n")
endfunction


let g:codeReviewTarget = "main"
function ReviewLocalBranches(source, targetCommit = "main")
  let g:codeReviewTarget = a:targetCommit

  silent execute "!git checkout " . a:source
  silent execute "Git difftool --name-status " . g:codeReviewTarget . "... ':!**/graphql.types*'"
  silent execute "Gitsigns change_base " .  g:codeReviewTarget . " true"

  nnoremap dm <cmd>execute "Gvdiffsplit " . g:codeReviewTarget . "..."<cr>
  map <leader>p <C-w>q[qdm
  map <leader>n <C-w>q]qdm

  nnoremap dmq <enter> <c-w>o <cmd>copen<cr> <C-w>w <cmd>execute "Gvdiffsplit " . g:codeReviewTarget . "..."<cr>
endfunction

function CompareWithPreviousCommit(sourceCommit)
  let sourceCommit = a:sourceCommit
  let targetCommit = sourceCommit . "~1"

  execute ReviewLocalBranches(sourceCommit, targetCommit)
endfunction

function CompareWithMain()
  let l:gitBranchOutput = split(execute("!git rev-parse --abbrev-ref HEAD"), "\n")
  let l:currentBranch = map(map(l:gitBranchOutput, 'trim(v:val)')[2:], 'trim(v:val, "* ")')[0]

  execute ReviewLocalBranches(l:currentBranch, "main")
endfunction

function CompareWith(targetBranch)
  echo "targetBranch" . a:targetBranch
  let l:gitBranchOutput = split(execute("!git rev-parse --abbrev-ref HEAD"), "\n")
  let l:currentBranch = map(map(l:gitBranchOutput, 'trim(v:val)')[2:], 'trim(v:val, "* ")')[0]

  execute ReviewLocalBranches(l:currentBranch, a:targetBranch)
endfunction

command! -nargs=* -range CompareWithPrevious call CompareWithPreviousCommit(<f-args>)

command! -nargs=* -range -complete=custom,CodeReview_complete CodeReviewLocal call ReviewLocalBranches(<f-args>)

command! -nargs=* -range CompareWithMain call CompareWithMain()
command! -nargs=* -range -complete=custom,CodeReview_complete CompareBranchWith call CompareWith(<f-args>)

function ReviewRemoteBranch (sourceBranch, targetBranch = "main")
  execute "!git fetch"

  execute "!git checkout " . a:targetBranch
  execute "!git pull"
  execute "!git checkout " . a:sourceBranch
  execute "!git pull"

  call ReviewLocalBranches(a:sourceBranch, a:targetBranch)
endfunction

command! -nargs=* -range CodeReviewRemote call ReviewRemoteBranch(<f-args>)

augroup git_au
    autocmd!
    autocmd FileType git setlocal foldmethod=syntax foldlevel=0
augroup END
