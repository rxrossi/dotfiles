local dap = require("dap")

dap.adapters.node2 = {
	type = "executable",
	command = "node",
    args = {os.getenv('HOME') .. '/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js'}
}


dap.configurations.typescript = {
  {
		name = "jest",
		type = "node2",
		request = "attach",
		cwd = vim.fn.getcwd(),
		protocol = "auto",
		skipFiles = { "<node_internals>/**/*.js" },
		console = "integratedTerminal",
		port = 9229,
		internalConsoleOptions = "neverOpen",
		disableOptimisticBPs = true,
		sourceMaps = "inline",
		args = { "--no-cache" },
  }
}

require("dapui").setup()

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

