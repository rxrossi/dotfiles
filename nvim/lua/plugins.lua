local sep_os_replacer = require("utils").sep_os_replacer

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
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-dap.nvim'},
      {'nvim-telescope/telescope-live-grep-raw.nvim'}
    }
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
  }
  use 'Raimondi/delimitMate'
  use 'jeetsukumaran/vim-indentwise'
  use 'Shougo/defx.nvim'

  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }

  use 'michaeljsmith/vim-indent-object'

  use 'airblade/vim-rooter'

  -- debug
  use({ "jbyuki/one-small-step-for-vimkind" }) -- lua debug
  use({ "mfussenegger/nvim-dap-python", opt = true }) -- python debug
  use({
    "Pocco81/DAPInstall.nvim",
    cmd = { "DIInstall", "DIList" },
    config = function()
      local dap_install = require("dap-install")

      dap_install.setup({
        installation_path = sep_os_replacer(
          vim.fn.stdpath("data") .. "/dapinstall/"
        ),
      })
    end,
  }) -- install dap adapters
  use({
    "mfussenegger/nvim-dap",
  }) -- dap
  use({
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
  }) -- dap ui

  use 'danilamihailov/beacon.nvim'
  use 'tpope/vim-surround'
  use 'junegunn/goyo.vim'
  use 'AndrewRadev/linediff.vim'

  use 'dhruvasagar/vim-table-mode'

end)

