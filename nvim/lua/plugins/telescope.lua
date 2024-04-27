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
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-ui-select.nvim" },
  config = function()
    local opt = require("telescope.themes").get_ivy({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--multiline",
        },
        layout_strategy = "vertical",
        layout_config = { height = 0.99 },
      },
      layout_strategy = "vertical",
      layout_config = { height = 0.99 },
      pickers = {
        buffers = {
          ignore_current_buffer = true,
          sort_mru = true,
        },
      },
    })

    require("telescope").setup(opt)
    local builtin = require("telescope.builtin")

    -- See `:help telescope.builtin`
    vim.keymap.set("n", "<leader>?", function()
      builtin.oldfiles(opt)
    end, { desc = "[?] Find recently opened files" })

    vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>gf", function()
      builtin.git_files(opt)
    end, { desc = "Search [G]it [F]iles" })

    vim.keymap.set("n", "<leader>sf", function()
      builtin.find_files(opt)
    end, { desc = "[S]earch [F]iles" })

    vim.keymap.set("n", "<leader>sh", function()
      builtin.help_tags(opt)
    end, { desc = "[S]earch [H]elp" })

    vim.keymap.set("n", "<leader>sw", function()
      builtin.grep_string(opt)
    end, { desc = "[S]earch current [W]ord" })

    vim.keymap.set("n", "<leader>sg", function()
      builtin.live_grep(opt)
    end, { desc = "[S]earch by [G]rep" })

    vim.keymap.set("n", "<leader>sd", function()
      builtin.diagnostics(opt)
    end, { desc = "[S]earch [D]iagnostics" })

    vim.keymap.set("n", "<leader>sr", function()
      builtin.resume(opt)
    end, { desc = "[S]earch [R]esume" })

    vim.keymap.set("n", "<leader>ds", function()
      builtin.lsp_document_symbols(opt)
    end, { desc = "Document Symbols" })

    vim.keymap.set("n", "<leader>ws", function()
      builtin.lsp_dynamic_workspace_symbols(opt)
    end, { desc = "Workspace Symbols" })

    -- vim.keymap.set("n", "gr", function()
    --   builtin.lsp_references(opt)
    -- end, { desc = "Find references" })

    vim.keymap.set("n", "gy", function()
      builtin.lsp_implementations(opt)
    end, { desc = "Go to Implementation" })

    setup_alt()
    require("telescope").load_extension("ui-select")
  end,
}
