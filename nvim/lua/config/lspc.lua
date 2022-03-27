local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
		-- { name = "vsnip" }, -- For vsnip users.
		-- { name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
	local keymaps_opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", keymaps_opts)
	vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", keymaps_opts)
	vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", keymaps_opts)
	vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", keymaps_opts)

	local opts = {}

	if server.name == "sumneko_lua" then
		opts = require("lua-dev").setup({})
	end

	opts.capabilities = capabilities
	opts.on_attach = function(client, bufnr)
		if server.name == "tsserver" then
			client.resolved_capabilities.document_formatting = false
		end

		local set_buf_n_keymap = function(from, to)
			vim.api.nvim_buf_set_keymap(bufnr, "n", from, to, keymaps_opts)
		end

		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		set_buf_n_keymap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
		set_buf_n_keymap("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
		set_buf_n_keymap("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
		set_buf_n_keymap("K", "<cmd>lua vim.lsp.buf.hover()<CR>")
		set_buf_n_keymap("gy", "<cmd>lua vim.lsp.buf.implementation()<CR>")
		set_buf_n_keymap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
		set_buf_n_keymap("<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
		set_buf_n_keymap("<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
		set_buf_n_keymap("<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
		set_buf_n_keymap("<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
		set_buf_n_keymap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
		set_buf_n_keymap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
		set_buf_n_keymap("<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
	end

	server:setup(opts)
end)
