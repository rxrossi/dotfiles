return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod',                     lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
    end,
    config = function()
        vim.cmd [[
          autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })

          autocmd FileType dbui nmap <leader>s <Plug>(DBUI_ExecuteQuery)
          autocmd FileType dbui nmap <leader>e vap<Plug>(DBUI_ExecuteQuery)
          autocmd FileType dbui vmap <leader>s <Plug>(DBUI_ExecuteQuery)
          autocmd FileType dbui set foldlevelstart=999
          autocmd FileType dbui set foldlevel=999
        ]]

    end,
}
