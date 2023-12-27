function setup_alt()
  -- ----------------------------------------------
  -- Alternate File Switching
  -- ----------------------------------------------
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  local alternates_picker = function(alternates, opts)
    opts = opts or {}
    pickers
      .new(opts, {
        prompt_title = "alternates",
        finder = finders.new_table({
          results = alternates,
        }),
        sorter = conf.generic_sorter(opts),
      })
      :find()
  end

  function alt(path)
    local function isempty(s)
      return s == nil or s == ""
    end

    -- This is where you can configure it with CLI options so
    -- it behaves how you want it to.
    local alternates = vim.fn.system("alt " .. path)
    if isempty(alternates) then
      return nil
    else
      local alternates_table = {}
      for s in alternates:gmatch("[^\r\n]+") do
        table.insert(alternates_table, s)
      end
      return alternates_table
    end
  end

  function alt_command(path, alt_handler)
    local current_file_path = vim.fn.expand("%")
    local alternate_file_paths = alt(current_file_path)
    if alternate_file_paths == nil then
      print("No alternate files found for " .. current_file_path .. "!")
    else
      alt_handler(current_file_path, alternate_file_paths)
    end
  end

  function alt_handler(current_file_path, alternate_file_paths)
    alternates_picker(alternate_file_paths)
  end

  vim.keymap.set("n", "<leader>.", function()
    alt_command(vim.fn.expand("%"), alt_handler)
  end)
end

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.4",
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    pickers = {
      buffers = {
        ignore_current_buffer = true,
        sort_mru = true,
      },
    },
  },
  config = function()
    -- See `:help telescope.builtin`
    vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
    vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

    setup_alt()
  end,
}
