return {
  "rouge8/neotest-rust",
  "haydenmeade/neotest-jest",
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>t"] = { name = "+test" },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "fredrikaverpil/neotest-golang",
      "antoinemadec/FixCursorHold.nvim",
    },
    opts = {
      -- Can be a list of adapters like what neotest expects,
      -- or a list of adapter names,
      -- or a table of adapter names, mapped to adapter configs.
      -- The adapter will then be automatically loaded with the config.
      adapters = {},
      status = { virtual_text = true },
      output = { open_on_run = true },
      -- consumers = {
      --   "quickfix"
      -- },
      quickfix = {
        open = true,
        enabled = true,
      },
    },
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      if opts.adapters then
        local adapters = {
          require("neotest-jest")({
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),

          require("neotest-rust")({
            args = { "--no-capture" },
          }),
          require("neotest-golang")({
            dap_go_enabled = true,
            testify_enabled = true,
            go_test_args = {
              "-v",
              "-race",
              "-count=1",
              '-tags="unit"',
              "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
            },
          }), -- Apply configuration
        }
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
    -- stylua: ignore
    keys = {
      {
        "<leader>tt",
        function() require("neotest").run.run(vim.fn.expand("%")) end,
        desc =
        "Run File"
      },
      {
        "<leader>tT",
        function() require("neotest").run.run(vim.loop.cwd()) end,
        desc =
        "Run All Test Files"
      },
      {
        "<leader>tr",
        function() require("neotest").run.run() end,
        desc =
        "Run Nearest"
      },
      {
        "<leader>tw",
        function() require('neotest').run.run({ jestCommand = 'npx jest --watch --verbose=false' }) end,
        desc = "Test watch"
      },
      {
        "<leader>ts",
        function() require("neotest").summary.toggle() end,
        desc =
        "Toggle Summary"
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open(
            { enter = true, auto_close = true }
          )
        end,
        desc =
        "Show Output"
      },
      {
        "<leader>tO",
        function() require("neotest").output_panel.toggle() end,
        desc =
        "Toggle Output Panel"
      },
      { "<leader>tS",  function() require("neotest").run.stop() end,                         desc = "Stop" },
      { "<leader>tdr", function() require("neotest").run.run({ strategy = "dap" }) end,      desc = "Debug Nearest" },
      { "<leader>tdl", function() require("neotest").run.run_last({ strategy = "dap" }) end, desc = "Debug last" },
      { "<leader>tl",  function() require("neotest").run.run_last() end,                     desc = "Run last" },
    },
  },
}
