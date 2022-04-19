local cSpellJsonFilePath = vim.fn.expand("~/dotfiles/nvim/cspell.json")

local function appendLineTo(filePath, bellowLineNr, text)
	local file = io.open(filePath, "r")
	local fileContent = {}
	for line in file:lines() do
		table.insert(fileContent, line)
	end
	io.close(file)

	local line = fileContent[bellowLineNr]
	local modifiedLine = line .. text
	fileContent[4] = modifiedLine

	file = io.open(filePath, "w")
	for _index, value in ipairs(fileContent) do
		file:write(value .. "\n")
	end
	io.close(file)
end

local function getFirstWord()
	local lnum, _ = unpack(vim.api.nvim_win_get_cursor(0))
	local diagnostics = vim.diagnostic.get(0, { lnum = lnum - 1 })

	if not diagnostics[1] then
		return nil
	end

	local firstMessage = diagnostics[1].message
	if firstMessage:find("^Unknown word ") ~= nil then
		local word = firstMessage:reverse():sub(2):reverse():sub(15)
		return word
	end
end

local function addWordToCSpell()
	local currentWord = getFirstWord()

	if not currentWord then
		return nil
	end

	local text = "\n\t\t" .. '"' .. currentWord .. '",'
	local wordsLineNr = 4
	appendLineTo(cSpellJsonFilePath, wordsLineNr, text)
end

local function addWord(word)
	local text = "\n\t\t" .. '"' .. word .. '",'
	local wordsLineNr = 4
	appendLineTo(cSpellJsonFilePath, wordsLineNr, text)
end

return {
	addWordToCSpell = addWordToCSpell,
	addWord = addWord,
}
