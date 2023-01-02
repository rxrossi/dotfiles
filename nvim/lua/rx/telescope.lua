require("telescope").load_extension("live_grep_args")

local telescope = require("telescope")
local builtin = require("telescope.builtin")

local live_grep_args = require("telescope").extensions.live_grep_args.live_grep_args


vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fw", function() builtin.grep_string { search = vim.fn.expand("<cword>") } end, {})
vim.keymap.set("n", "<leader>fg", function() live_grep_args({
	vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden" }
}) end, {})

telescope.setup {
	defaults = {
		layout_strategy = "vertical",
		layout_config = { vertical = { width = 0.999, height = 0.999 } },
		file_ignore_patterns = {"node_modules", ".git"},
	},
	pickers = {
		builtin = {
			theme = "dropdown",
		},
		oldfiles = {
			theme = "ivy",
			sort_mru = true,
		},
		buffers = {
			theme = "ivy",
			ignore_current_buffer = true,
			sort_mru = true,
		},
	},
}
