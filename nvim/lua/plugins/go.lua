-- set efm^=%.%#\ expected\ %.%#\ at\ %f:%l\ %.%#,%A%f:%l:\ | lcd %:p:h | make %:p:h | copen
-- set efm^=%.%#\\ expected\\ %.%#\\ at\\ %f:%l\\ %.%#,%A%f:%l:\\ | lcd %:p:h | make %:p:h | copen

function runGo(cmd)
  vim.cmd(
    "wa | lcd %:p:h | compiler go | set efm^=%.%#\\ expected\\ %.%#\\ at\\ %f:%l\\ %.%#,%A%f:%l:\\ | set makeprg=go\\ " .. cmd .. "\\ \\-tags=unit  | silent Make %:p:h")
  vim.cmd("Gcd")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.keymap.set("n", "<space>tt", function()
      runGo("test")
    end, { desc = "test the current file" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.keymap.set("n", "<space>tb", function()
      runGo("build")
    end, { desc = "test the current file" })
  end,
})

return {}
