-- Packer plugin manager config
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

require('packer').startup(function(use)
	-- Packer can install/manage itself
	use 'wbthomason/packer.nvim'

	-- Manage Mason
	use {
		'williamboman/mason.nvim'
	}

	--  Alpha-vim
	use {
		'goolord/alpha-nvim',
		requires = { 'nvim-tree/nvim-web-devicons' },
		config = function ()
			require'alpha'.setup(require'alpha.themes.startify'.config)
		end
	}

	-- Nvim-cmp
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	
	-- Git-gutter
	use 'airblade/vim-gitgutter'

	-- Lualine
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
	
	-- Nvim-visual-multi
	-- use 'mg979/vim-visual-multi'
	
	-- Nvim-tree
	use 'nvim-tree/nvim-tree.lua'
	
	-- Telescope
	use {
  		'nvim-telescope/telescope.nvim', tag = '0.1.3',
  		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Fzf
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	if packer_bootstrap then
		require('packer').sync()
	end
end)

require('mason').setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})

require('lualine').setup {
	options = {
		theme = 'dracula'
	}
}
require('nvim-tree').setup()

-- Set up nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--  capabilities = capabilities
--}

-- Load telescope and fzf
--local telescope_setup, telescope = pcall(require, 'telescope')
--if not telescope_setup then return end

--local actions_setup, actions = pcall(require, "telescope.actions")
--if not actions_setup then return end
 
--require('telescope').setup{}
--require('telescope').setup{}
--	defaults = {
--		mappings = {
--			i = {
--				["C-k"] = actions.move_selection_previous,
--				["C-j"] = actions.move_selection_next,
--				["C-q"] = actions.send_selected_to_qflist + actions.open_qflist
--			}
--		},
--		extensions = {
--			fzf = {
--				fuzzy = true,
--				override_generic_sorter = true,
--				override_file_sorter = true,
--				case_mode = "smart_case",
--			}
--		}
--	}
--}
--telescope.load_extension('fzf')
