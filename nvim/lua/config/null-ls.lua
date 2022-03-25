local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.diagnostics.write_good,
    null_ls.builtins.diagnostics.eslint,

    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.eslint,

}

null_ls.setup({ sources = sources })
