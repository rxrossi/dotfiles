local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
	null_ls.builtins.formatting.prettierd,
	null_ls.builtins.formatting.eslint_d,
	null_ls.builtins.formatting.stylua,

	-- null_ls.builtins.diagnostics.write_good,
	null_ls.builtins.diagnostics.eslint,
	null_ls.builtins.diagnostics.cspell.with({
		-- https://www.npmjs.com/package/cspell-dict-pt-br
		extra_args = { "-c", vim.fn.expand("~/dotfiles/nvim/cspell.json"), "--locale", "en-GB,pt-BR" },
	}),

	null_ls.builtins.code_actions.gitsigns,
	null_ls.builtins.code_actions.eslint,
}

null_ls.setup({
	sources = sources,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
		end
	end,
})
