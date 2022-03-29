require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
	},
	pickers = {
		oldfiles = {
			sort_mru = true,
		},
		buffers = {
			sort_mru = true,
		},
	},
})

vim.cmd([[
  nnoremap <leader><leader> <cmd>Telescope <cr>
  nnoremap <leader>ff <cmd>Telescope find_files find_command=rg,--hidden,--files<cr>
  nnoremap <leader>fg <cmd>:lua require("telescope").extensions.live_grep_raw.live_grep_raw()<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr>
  nnoremap <leader>fh <cmd>Telescope command_history<cr>
  nnoremap <leader>fc <cmd>Telescope commands<cr>
  nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
]])
