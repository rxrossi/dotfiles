local ls = require("luasnip")

-- ls.config.set_config({
-- 	-- history = true,
-- 	-- updateevents = "TextChanged,TextChangedI",
-- })

ls.snippets = {
	lua = {
		ls.parser.parse_snippet("expand", "--something"),
	},
}

-- vim.keymap.set({ "i", "s" }, "<C-k>", function()
-- 	if ls.expand_or_jumpable() then
-- 		ls.expand_or_jump()
-- 	end
-- end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<C-j>", function()
-- 	if ls.jumpable(-1) then
-- 		ls.jump(-1)
-- 	end
-- end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<C-l>", function()
-- 	if ls.choice_active(-1) then
-- 		ls.change_choice(1)
-- 	end
-- end, { silent = true })
--
-- vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")