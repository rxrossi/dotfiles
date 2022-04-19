-- local line =
-- 	"/Users/rxrossi/dotfiles/nvim/temp.js:3:4 - Unknown word (typot) Suggestions: [typos, typo, hypot, typo's, typeof]"
--
-- local pattern = [[.*:(%d+):(%d+)%s*-%s*(.*)]]
--
-- local results = { line:match(pattern) }
--
-- print(results)
-- print(vim.inspect(results))

local line = "Unknown word (typot) Suggestions: [typos, typo, hypot, typo's, typeof]"
-- local results = line:match("%[(.*)%]"):gmatch("[%a][%w']*[%w]+")
--
-- local suggestions = {}
--
-- for w in results do
-- 	table.insert(suggestions, w)
-- end
--
-- print(results)
-- print(vim.inspect(results))
-- print(vim.inspect(suggestions))

-- print(client.name)

local getNullLs = function()
	local clients = vim.lsp.get_active_clients()

	for index in ipairs(clients) do
		local client = clients[index]

		if client.name == "null-ls" then
			return client
		end
	end
end

local client = getNullLs()

client.notify("textDocument/didOpen", {
	textDocument = { uri = vim.uri_from_bufnr(0) },
})

vim.cmd([[
  autocmd! bufwritepost all.lua source %
]])
