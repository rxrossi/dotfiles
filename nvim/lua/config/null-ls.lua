local null_ls = require("null-ls")

local sources = {
	null_ls.builtins.formatting.prettierd,
	null_ls.builtins.formatting.eslint_d,
	null_ls.builtins.diagnostics.eslint.with({
	  only_local = true
	}),
  null_ls.builtins.diagnostics.cfn_lint
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	sources = sources,
	-- you can reuse a shared lspconfig on_attach callback here
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})
