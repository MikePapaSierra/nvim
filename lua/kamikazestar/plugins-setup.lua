-- This script seems to be not loading plugins automatically after file save
-- Check this code: https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins-setup.lua

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  
  -- Lua functions that many plugins use
  use 'nvim-lua/plenary.nvim'

  -- Use Dracula colorscheme
  use 'Mofiqul/dracula.nvim'
  
  -- Tmux & split window navigator
  use 'christoomey/vim-tmux-navigator'
  use 'szw/vim-maximizer'

  -- File explorer
  use 'nvim-tree/nvim-tree.lua'

  -- Icons
  use 'kyazdani42/nvim-web-devicons'

  -- Status line
  use 'nvim-lualine/lualine.nvim'
  
  -- Fuzzy finding
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })

  -- Autocompletion
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")

  -- Snippets
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("rafamadriz/friendly-snippets")

  -- Managing and instaling LSP servers
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- Configuring LSP servers
  use("neovim/nvim-lspconfig")
  use("hrsh7th/cmp-nvim-lsp")
  use({ "glepnir/lspsaga.nvim", branch = "main" })
	use("onsails/lspkind.nvim")
  
  -- Goloang plugin
  use("fatih/vim-go")

  -- Essential plugins
  -- use 'tpope/vim-surround'
  -- use 'vim-scripts/ReplaceWithRegister'
  
  -- Commenting with gc
  -- use 'numToStr/Comment.nvim'


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

