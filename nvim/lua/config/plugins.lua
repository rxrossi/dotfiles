return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("tpope/vim-fugitive")
	use("tpope/vim-unimpaired")
	use("tpope/vim-dispatch")
	use("tpope/vim-obsession")

	use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" })
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use("RRethy/nvim-base16")

	use("nvim-treesitter/nvim-treesitter")

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-dap.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			{ "kyazdani42/nvim-web-devicons" },
		},
	})

	use("windwp/nvim-autopairs")

	use("jeetsukumaran/vim-indentwise")

	use("michaeljsmith/vim-indent-object")

	use("airblade/vim-rooter")

	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp-signature-help")

	use("folke/lua-dev.nvim")

	use("folke/lsp-colors.nvim")
	use("preservim/vim-markdown")
	use("godlygeek/tabular")

	use({
		"brymer-meneses/grammar-guard.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"williamboman/nvim-lsp-installer",
		},
	})

	use("~/nvim-tree.lua")

	use("nvim-treesitter/nvim-treesitter-context")

	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "L3MON4D3/LuaSnip" })
	use("onsails/lspkind-nvim")
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	use("junegunn/goyo.vim")

end)
