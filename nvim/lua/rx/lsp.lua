-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.set_preferences({
	set_lsp_keymaps = false
})

lsp.on_attach(function (client, buffer_nr)
	local keymap_opts = { buffer = buffer_nr }

	vim.keymap.set("n", "<space>e", function() vim.diagnostic.open_float({source = true}) end, keymap_opts)
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, keymap_opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, keymap_opts)

	vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, keymap_opts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, keymap_opts)


	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, keymap_opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, keymap_opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, keymap_opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, keymap_opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, keymap_opts)

	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, keymap_opts)

	if client.server_capabilities.documentHighlightProvider then
		print("hi from documentHighlightProvider")
		vim.api.nvim_exec(
		[[
		augroup lsp_document_highlight
		autocmd!
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
		hi! LspReferenceRead  gui=reverse guibg=reverse
		hi! LspReferenceText gui=NONE cterm=underline
		hi! LspReferenceWrite  gui=reverse guibg=reverse
		]],
		false
		)
	end


	if client.supports_method("textDocument/codeLens") then
		vim.api.nvim_exec(
		[[
		augroup codelens_refresh
		autocmd!
		autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
		augroup END
		]],
		false)
	end
end)

lsp.configure('tsserver', {
	flags = {
		debounce_text_changes = 150,
	},
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
	end
})

local on_references = vim.lsp.handlers["textDocument/references"]

vim.lsp.handlers["textDocument/references"] = vim.lsp.with(on_references, {
	-- Use location list instead of quickfix list
	loclist = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

lsp.setup()


