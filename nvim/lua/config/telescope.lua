require("telescope").load_extension("live_grep_args")
require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = { vertical = { width = 0.999, height = 0.999 } },
    file_ignore_patterns = {"node_modules", ".git"},
	},
	pickers = {
		builtin = {
			previewer = false,
			theme = "dropdown",
		},
		marks = {
			previewer = true,
			theme = "dropdown",
		},
		find_files = {
			previewer = false,
			theme = "ivy",
		},
		oldfiles = {
			theme = "ivy",
			previewer = false,
			sort_mru = true,
		},
		buffers = {
			theme = "ivy",
			ignore_current_buffer = true,
			sort_mru = true,
			previewer = false,
		},
	},
})

vim.cmd([[
  nnoremap <leader><leader> <cmd>Telescope <cr>
  nnoremap <leader>ff <cmd>Telescope find_files find_command=rg,--hidden,--files<cr>
  nnoremap <leader>fg <cmd>:lua require('telescope').extensions.live_grep_args.live_grep_args({ vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden" } })<cr>
  nnoremap <leader>fm <cmd>Telescope marks<cr>
  nnoremap <leader>fq <cmd>Telescope quickfix<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope command_history<cr>
  nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
  nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
]])

vim.keymap.set({ "n", "s" }, "<leader>fc", function() 
  local full_path = vim.api.nvim_exec([[echo FindRootDirectory()]], true)
  local cwd = vim.api.nvim_exec([[echo getcwd()]], true)
  local from_vim_root_path = string.sub(full_path, string.len(cwd) + 2)

  require('telescope.builtin').find_files( { cwd = from_vim_root_path })
end)
