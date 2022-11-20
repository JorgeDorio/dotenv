vim.cmd [[packadd packer.nvim]]

require('plugins.cfg')

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'agude/vim-eldar'
	use 'folke/tokyonight.nvim'
	use 'segeljakt/vim-silicon'
	use 'cseelus/vim-colors-clearance'
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
		ft = { "markdown" }, })
		use {
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v2.x",
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"MunifTanjim/nui.nvim",
			}
		}
		use {
			"williamboman/nvim-lsp-installer",
			"neovim/nvim-lspconfig",
		}
		use {
			'nvim-telescope/telescope.nvim', tag = '0.1.0',
			requires = { {'nvim-lua/plenary.nvim'} }
		}
		use {'jghauser/mkdir.nvim'}
		use {"windwp/nvim-autopairs"}
		use {'terrortylor/nvim-comment'}
		use {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
			'hrsh7th/vim-vsnip',
			'hrsh7th/vim-vsnip-integ'
		}
		use {"startup-nvim/startup.nvim"}
	end
)

