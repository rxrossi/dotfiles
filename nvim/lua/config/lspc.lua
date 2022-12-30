local cmp = require("cmp")

local luasnip = require("luasnip")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

luasnip.add_snippets("all", {
  luasnip.parser.parse_snippet("cljs", "console.log(JSON.stringify($0, null, 2))"),
  luasnip.parser.parse_snippet("desc", 'describe("$1", () => {\n\t$0\n})'),
  luasnip.parser.parse_snippet("it", 'it("$1", $2() => {\n\t$0\n})'),
  -- luasnip.parser.parse_snippet("al", '## ' .. os.date("%Y-%m-%d %H:%M:%S") .. '\n\n$0\n\n---'),
  luasnip.s("alo", {
    luasnip.t("## "),
    luasnip.function_node(function() return { os.date("%Y-%m-%d %H:%M:%S") } end, {}),
    luasnip.t({ "", "", "" }),
    luasnip.insert_node(0),
    luasnip.t({ "" }),
  })
})

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

vim.cmd([[
  " gray
  highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
  " blue
  highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
  highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
  " light blue
  highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
  highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
  " pink
  highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
  highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
  " front
  highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
  highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
]])

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-n>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      end
    end, { "i", "s" }),
    ["<C-p>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
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
  sources = {
    { name = "nvim_lua" },
    { name = "nvim_lsp", max_item_count = 500 },
    { name = "path", max_item_count = 5 },
    { name = "luasnip", max_item_count = 5 },
    {
      name = "buffer",
      max_item_count = 5,
      keyword_length = 2,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
  },
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_installer = require("nvim-lsp-installer")

require("grammar-guard").init()

require("neodev").setup({})

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
  local keymaps_opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float({ source = true })<CR>", keymaps_opts)
  vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", keymaps_opts)
  vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", keymaps_opts)
  vim.api.nvim_set_keymap("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", keymaps_opts)

  local opts = {}

  if server.name == "yamlls" then
    opts = {
      settings = {
        yaml = {
          customTags = { "!Ref", "!ImportValue", "!GetAtt", "!Sub" },
          schemas = {
            -- ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/sam.schema.json"] = {"**/template.yml", "**/template.yaml"},
            -- ["https://raw.githubusercontent.com/aws/serverless-application-model/develop/samtranslator/schema/schema.json"] = {"**/template.yml", "**/template.yaml"},
          },
        }
      }
    }
  end

  if server.name == "ltex" then
    opts = {
      settings = {
        ltex = {
          enabled = { "latex", "tex", "bib", "markdown" },
          language = "en",
          diagnosticSeverity = "information",
          sentenceCacheSize = 2000,
          additionalRules = {
            enablePickyRules = true,
            -- motherTongue = "pt-BR",
          },
          trace = { server = "verbose" },
          dictionary = {},
          disabledRules = {},
          hiddenFalsePositives = {},
        },
      },
    }
  end

  opts.capabilities = capabilities
  opts.on_attach = function(client, bufnr)
    if server.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
    end

    if client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_exec(
        [[
          augroup lsp_document_highlight
            autocmd!
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END


          hi! LspReferenceRead  gui=reverse guibg=reverse
          hi! LspReferenceText gui=NONE cterm=underline
          hi! LspReferenceWrite  gui=reverse guibg=reverse
        ]],
        false
      )
    end


    if client.supports_method("textDocument/codeLens") then
      vim.api.nvim_exec(
        [[
          augroup codelens_refresh
            autocmd!
            autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()
          augroup END
        ]],
        false
      )
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
    set_buf_n_keymap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    set_buf_n_keymap("<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
    set_buf_n_keymap("<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
    set_buf_n_keymap("<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
    set_buf_n_keymap("<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    set_buf_n_keymap("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    set_buf_n_keymap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    set_buf_n_keymap("<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>")
    vim.api.nvim_set_keymap('v', '<leader>ca', '<ESC><cmd>lua vim.lsp.buf.range_code_action()<CR>', { noremap = true })
    set_buf_n_keymap("<space>f", "<cmd>lua vim.lsp.buf.format()<CR>")
    set_buf_n_keymap("gY", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    set_buf_n_keymap("gI", "<cmd>lua vim.lsp.buf.implementation()<CR>")


    local on_references = vim.lsp.handlers["textDocument/references"]
    vim.lsp.handlers["textDocument/references"] = vim.lsp.with(on_references, {
      -- Use location list instead of quickfix list
      loclist = true,
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })


  end

  server:setup(opts)

end)
