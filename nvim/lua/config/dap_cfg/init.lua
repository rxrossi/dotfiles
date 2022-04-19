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
]])
