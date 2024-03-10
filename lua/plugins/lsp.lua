return {
	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup({
				ui = {
					icons = {
						package_installed = '✓',
						package_pending = '➜',
						package_uninstalled = '✗'
					}
				}
			})
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require('mason-lspconfig').setup({
				ensure_installed = { 'lua_ls' },
				auto_install = true,
			})
		end
	},
	{
		'neovim/nvim-lspconfig',
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_cpapbilities
			local lspconfig = require('lspconfig')
			lspconfig.lua_ls.setup({
				capabilities = capabilities
			})
			lspconfig.pyright.setup({
				capabilities = capabilities
			})
		end
	},
	'folke/neodev.nvim',
}
