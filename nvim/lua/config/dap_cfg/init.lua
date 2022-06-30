local dap = require("dap")

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/vscode-node-debug2/out/src/nodeDebug.js" },
}

function Debug_jest(o)
	local config_path = o.config_path -- E.g.:  "/packages/stacks/customer/delivery-promise-service/src/__api__/jest.config.js",
	local test_file = o.test_file

	local config = {
		name = "jest",
		type = "node2",
		request = "launch",
		cwd = vim.fn.getcwd(),
		runtimeArgs = {
			"--inspect-brk",
			vim.fn.getcwd() .. "/node_modules/.bin/jest",
			"--no-coverage",
			"--watch",
			"--runInBand",
			"--config",
			-- vim.fn.getcwd() .. "/packages/stacks/customer/delivery-promise-service/src/__api__/jest.config.js",
			vim.fn.getcwd() .. config_path,
			test_file,
		},
		protocol = "auto",
		skipFiles = { "<node_internals>/**/*.js" },
		console = "integratedTerminal",
		port = 9229,
		internalConsoleOptions = "neverOpen",
		disableOptimisticBPs = true,
		sourceMaps = "inline",
		args = { "--no-cache" },
	}

	dap.run(config)

	require("dapui").setup({
		icons = { expanded = "▾", collapsed = "▸" },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		-- Expand lines larger than the window
		-- Requires >= 0.7
		expand_lines = vim.fn.has("nvim-0.7"),
		-- Layouts define sections of the screen to place windows.
		-- The position can be "left", "right", "top" or "bottom".
		-- The size specifies the height/width depending on position.
		-- Elements are the elements shown in the layout (in order).
		-- Layouts are opened in order so that earlier layouts take priority in window sizing.
		layouts = {
			{
				elements = {
					-- Elements can be strings or table with id and size keys.
					{ id = "scopes", size = 0.25 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40,
				position = "left",
			},
			{
				elements = {
					"console",
				},
				size = 120,
				position = "right",
			},
		},
		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			border = "single", -- Border style. Can be "single", "double" or "rounded"
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil, -- Can be integer or nil.
		},
	})
end

-- lua Debug_jest({test_file = "customerPromisesCheckoutDeliveries/dtc-and-dc-different-carrier.spec.ts", config_path = "/packages/stacks/customer/delivery-promise-service/src/__api__/jest.config.js" })
--
--
vim.cmd([[ 
  nnoremap <Leader>df <Cmd>lua require("dapui").float_element("scopes", {enter = true})<CR>
  nnoremap <Leader>dw <Cmd>lua require("dapui").float_element("watches", {enter = true})<CR>
  nnoremap <Leader>dB <Cmd>lua require("dapui").float_element("breakpoints", {enter = true})<CR>
  nnoremap <Leader>dk <Cmd>lua require("dap.ui.widgets").hover()<CR>

  nnoremap <Leader>dh <Cmd>lua require'dap'.run_to_cursor()<CR>
  nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>
  nnoremap <silent> <leader>dc :lua require'dap'.continue()<CR>

  nnoremap <Leader>dt <Cmd>lua require'dapui'.toggle()<CR>
  nnoremap <Leader>dC <Cmd>lua require'dap'.clear_breakpoints()<CR>
  nnoremap <Leader>dr <Cmd>lua require'dap'.run_last()<CR>
  nnoremap <Leader>dx <Cmd>lua require'dap'.disconnect({terminateDebuggee = true})<CR>
]])
