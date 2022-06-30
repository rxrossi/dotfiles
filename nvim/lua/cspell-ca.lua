local null_ls = require("null-ls")

local cspell_ca = {}

local getNullLs = function()
	local clients = vim.lsp.get_active_clients()

	for index in ipairs(clients) do
		local client = clients[index]

		if client.name == "null-ls" then
			return client
		end
	end
end

cspell_ca.generator = {
	fn = function(params)
		getNullLs()

		local diagnostic = vim.diagnostic.get(params.bufnr, { lnum = params.row - 1 })[1]

		local actions = {}

		local word = diagnostic.message:match("%((.*)%)")

		table.insert(actions, {
			title = "Add " .. word .. " to dictionary",
			action = function()
				require("aw").addWord(word)

				local null_ls_client = getNullLs()

				null_ls_client.notify("textDocument/didOpen", {
					textDocument = { uri = vim.uri_from_bufnr(params.bufnr) },
				})
			end,
		})

		return actions
	end,
}
cspell_ca.filetypes = {}
cspell_ca.method = null_ls.methods.CODE_ACTION

local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local DIAGNOSTICS = methods.internal.DIAGNOSTICS

local cspell = h.make_builtin({
	name = "cspell",
	meta = {
		url = "https://github.com/streetsidesoftware/cspell",
		description = "cspell is a spell checker for code.",
	},
	method = DIAGNOSTICS,
	filetypes = {},
	generator_opts = {
		command = "cspell",
		args = function(params)
			return {
				"--language-id",
				params.ft,
				"stdin",
			}
		end,
		to_stdin = true,
		ignore_stderr = true,
		format = "line",
		check_exit_code = function(code)
			return code <= 1
		end,
		on_output = h.diagnostics.from_pattern([[.*:(%d+):(%d+)%s*-%s*(.*)]], { "row", "col", "message", "_quote" }, {
			adapters = { h.diagnostics.adapters.end_col.from_quote },
			offsets = { end_col = 1 },
		}),
	},
	factory = h.generator_factory,
})

null_ls.register({
	cspell_ca,
	cspell.with({
		-- https://www.npmjs.com/package/cspell-dict-pt-br
		extra_args = {
			"-c",
			vim.fn.expand("~/dotfiles/nvim/cspell.json"),
			"--show-suggestions",
			"-u",
			"--locale",
			"en-GB,pt-BR",
		},
	}),
})
