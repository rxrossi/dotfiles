return require('packer').startup(function(use)
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
    },
    commit = '5655cfa4c0316943c7da641f813e79a91bc0d87e'
  }
  use 'Raimondi/delimitMate'
  use 'jeetsukumaran/vim-indentwise'
  use 'Shougo/defx.nvim'

  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  use 'michaeljsmith/vim-indent-object'

  use 'mfussenegger/nvim-dap'
	use 'nvim-telescope/telescope-dap.nvim'
	use 'theHamsta/nvim-dap-virtual-text'
  use 'Pocco81/DAPInstall.nvim'

  use 'szw/vim-maximizer'
  use 'AndrewRadev/linediff.vim'

  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {}
    end
  }

  use "wellle/context.vim"

end)

