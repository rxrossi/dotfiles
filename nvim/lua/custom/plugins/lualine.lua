return {
  'nvim-lualine/lualine.nvim',
  opts = {
    sections = {
      lualine_c = { { 'filename', path = 1 } }
    },
    options = {
      icons_enabled = false,
      theme = 'onedark',
      component_separators = '|',
      section_separators = '',
    },
  },
}
