-- all plugins are here 
-- check if packer is installed (~/local/share/nvim/site/pack)
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- using { } when using a different branch of the plugin or loading the plugin with certain commands
return require("packer").startup(
    function()
        use {"wbthomason/packer.nvim", opt = true}
        use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}

		use 'neovim/nvim-lspconfig'
  	    use "hrsh7th/vim-vsnip"
	    use "kosayoda/nvim-lightbulb"
  	    use "kstevens715/nvim-ruby-debugger"
	    use "nvim-lua/plenary.nvim"
	    use "nvim-lua/popup.nvim"
	    use "simrat39/rust-tools.nvim"
  	    use "stevearc/vim-arduino"
        use "907th/vim-auto-save"
        use "alvan/vim-closetag"
        use "hrsh7th/nvim-compe"
        use "karb94/neoscroll.nvim"
        use "kyazdani42/nvim-tree.lua"
        use "kyazdani42/nvim-web-devicons"
        use "lewis6991/gitsigns.nvim"
        use "nekonako/xresources-nvim"
        use "norcalli/nvim-base16.lua"
        use "norcalli/nvim-colorizer.lua"
        use "nvim-telescope/telescope-media-files.nvim"
        use "nvim-telescope/telescope.nvim"
        use "nvim-treesitter/nvim-treesitter"
        use "ryanoasis/vim-devicons"
        use "sbdchd/neoformat"
        use "tweekmonster/startuptime.vim"
        use "windwp/nvim-autopairs"
    end
)

