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
		event = { "BufReadPost" },
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_cpapbilities
			local lspconfig = require('lspconfig')
			lspconfig.lua_ls.setup({
				capabilities = capabilities
			})
			lspconfig.pyright.setup({
				capabilities = capabilities
			})
			lspconfig.ansiblels.setup({
				capabilities = capabilities
			})
		end
	},
	{
		'nvimtools/none-ls.nvim',
		config = function()
		local null_ls = require('null-ls')

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.isort,
				-- TODO: [null-ls] failed to load builtin ansible_lint for method formatting; please check your config
				-- [lspconfig] Cannot access configuration for ansible. Ensure this server is listed in `server_configurations.md` or added as a custom server.
				null_ls.builtins.formatting.ansible_lint,
			}
		})
		vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
		end
	},
	{
		'folke/neodev.nvim',
		config = function()
			require('neodev').setup()
		end
	},
}
