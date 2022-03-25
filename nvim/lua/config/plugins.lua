return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-dispatch'
  use 'tpope/vim-obsession'

  use 'RRethy/nvim-base16'

  use 'nvim-treesitter/nvim-treesitter'

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-dap.nvim'},
      {'nvim-telescope/telescope-live-grep-raw.nvim'}
    }
  }

  use 'Raimondi/delimitMate'

  use 'jeetsukumaran/vim-indentwise'

  use 'michaeljsmith/vim-indent-object'

  use 'airblade/vim-rooter'

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }

  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use  { 'jose-elias-alvarez/null-ls.nvim', requires ={ {'nvim-lua/plenary.nvim'} } }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

end)
