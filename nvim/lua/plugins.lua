return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-obsession'

  use 'ntpeters/vim-better-whitespace'

  use 'RRethy/nvim-base16'
  use 'nvim-treesitter/nvim-treesitter'
  use 'vimwiki/vimwiki'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use 'Raimondi/delimitMate'
  use 'jeetsukumaran/vim-indentwise'
  use 'Shougo/defx.nvim'
  use 'styled-components/vim-styled-components'

end)

