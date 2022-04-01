require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = { vertical = { width = 0.999, height = 0.999 } },
	},
	pickers = {
		builtin = {
			previewer = false,
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
			sort_mru = true,
			previewer = false,
		},
	},
})

vim.cmd([[
  nnoremap <leader><leader> <cmd>Telescope <cr>
  nnoremap <leader>ff <cmd>Telescope find_files find_command=rg,--hidden,--files<cr>
  nnoremap <leader>fg <cmd>:lua require("telescope").extensions.live_grep_raw.live_grep_raw({theme = "default"})<cr>
  nnoremap <leader>fq <cmd>Telescope quickfix<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope command_history<cr>
  nnoremap <leader>fc <cmd>Telescope commands<cr>
  nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
  nnoremap <leader>fw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>") }<CR>
]])
