local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    init = function()
      vim.cmd([[colorscheme catppuccin]])
    end,
  },
  "tpope/vim-unimpaired",
  "tpope/vim-sleuth",
  { "numToStr/Comment.nvim", opts = {} },
  "jeetsukumaran/vim-indentwise",
  "michaeljsmith/vim-indent-object",
  "nvim-treesitter/nvim-treesitter-context",
  { import = "plugins" },
}
require("lazy").setup(plugins, {})

vim.cmd([[ packadd cfilter ]])

vim.o.number = true
vim.o.relativenumber = true

vim.o.expandtab = true

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.o.signcolumn = "yes"

vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true

vim.keymap.set("n", "<space>f", vim.lsp.buf.format, { desc = "Format the file" })
vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Show signature help" })


vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.keymap.set(
      "n",
      "<space>tt",
      function()
        vim.cmd("wa | lcd %:p:h | compiler go | set makeprg=go\\ test | silent Make %:p:h")
        vim.cmd("Gcd")
      end,
      { desc = "test the current file" }
    )
  end,
})

-- ":lcd %:p:h | compiler go | set makeprg=go\\ test | silent make %:p:h | Gcd | copen<cr>",

vim.keymap.set("n", "<space>cc", ":cd %:p:h<CR>", { desc = "cd into current's file dir" })
vim.keymap.set("n", "<space>o", ":Oil<CR>", { desc = "Open Oil<>" })

vim.cmd([[ set linebreak ]])

vim.cmd([[
  set foldmethod=indent
  set foldlevelstart=999
  set foldlevel=999
  autocmd FileType git setlocal foldmethod=syntax
  autocmd FileType typescript setlocal foldmethod=indent
  autocmd FileType javascript setlocal foldmethod=indent
  autocmd FileType go setlocal foldmethod=indent | setlocal makeprg=go\ test
  autocmd FileType go compiler go
  autocmd FileType markdown setlocal conceallevel=2
]])

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.diagnostic.config({
  virtual_text = false,
})

vim.cmd([[
augroup HighlightTODO
autocmd!
autocmd WinEnter,VimEnter * :silent! call matchadd('@comment.todo', 'TODO', -1)
augroup END
]])

vim.cmd([[
augroup HighlightNOTE
autocmd!
autocmd WinEnter,VimEnter * :silent! call matchadd('IncSearch', 'NOTE', -1)
augroup END
]])

vim.cmd([[
augroup HighlightQUESTION
autocmd!
autocmd WinEnter,VimEnter * :silent! call matchadd('@comment.warning', 'Q:', -1)
augroup END
]])

local run_formatter = function(text)
  local split = vim.split(text, "\n")
  local result = table.concat(vim.list_slice(split, 2, #split - 1), "\n")

  -- Finds sql-format-via-python somewhere in your nvim config path
  local bin = vim.api.nvim_get_runtime_file("bin/sql-format-via-python.py", false)[1]

  local j = require("plenary.job"):new({
    command = "python3",
    args = { bin },
    writer = { result },
  })

  return j:sync()
end

local embedded_sql = vim.treesitter.query.parse(
  "rust",
  [[
(macro_invocation
(scoped_identifier
path: (identifier) @path (#eq? @path "sqlx")
name: (identifier) @name (#eq? @name "query"))

(token_tree
(raw_string_literal) @sql)
(#offset! @sql 1 0 -1 0))
]]
)

local get_root = function(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, "rust", {})
  local tree = parser:parse()[1]
  return tree:root()
end

local format_dat_sql = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if vim.bo[bufnr].filetype ~= "rust" then
    vim.notify("can only be used in rust")
    return
  end

  local root = get_root(bufnr)

  local changes = {}
  for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
    local name = embedded_sql.captures[id]
    if name == "sql" then
      -- { start row, start col, end row, end col }
      local range = { node:range() }
      local indentation = string.rep(" ", range[2])

      -- Run the formatter, based on the node text
      local formatted = run_formatter(vim.treesitter.get_node_text(node, bufnr))

      -- Add some indentation (can be anything you like!)
      for idx, line in ipairs(formatted) do
        formatted[idx] = indentation .. line
      end

      -- Keep track of changes
      --    But insert them in reverse order of the file,
      --    so that when we make modifications, we don't have
      --    any out of date line numbers
      table.insert(changes, 1, {
        start = range[1] + 1,
        final = range[3],
        formatted = formatted,
      })
    end
  end

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
  end
end

vim.api.nvim_create_user_command("SqlMagic", function()
  format_dat_sql()
end, {})
