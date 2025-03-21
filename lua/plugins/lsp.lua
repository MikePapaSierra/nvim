return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost" },
		dependencies = {
			-- LSP management
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- Auto-install LSPs, linters, formatters, debbugers
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			-- Usefull status updates for LSP
			{ "j-hui/fidget.nvim", opts = {} },
		},
		-- :help lspconfig-all
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {},
			})
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = require("cmp_nvim_lsp").on_attach
			local util = require("lspconfig/util")
			lspconfig.lua_ls.setup({
				require("neodev").setup(),
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})
			lspconfig.bashls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "sh", "bash" },
			})
			lspconfig.pyright.setup({
				cmd = { "pyright-langserver", "--stdio" },
				capabilities = capabilities,
				filetypes = { "python" },
			})
			lspconfig.ansiblels.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "ansible-language-server", "--stdio" },
				filetype = { "yaml.ansible" },
				settings = {
					ansible = {
						ansible = {
							path = "ansible",
						},
						validation = {
							enabled = true,
							lint = {
								enabled = true,
								path = "ansible-lint",
							},
						},
					},
				},
			})
			lspconfig.terrformls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "terraform-ls", "serve" },
				filetypes = { "terraform", "terraform-vars" },
			})
			lspconfig.tflint.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "tflint", "--langserver" },
				filetypes = { "terraform" },
			})
			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.gofmt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.golines,
					-- TODO: [null-ls] failed to load builtin ansible_lint for method formatting; please check your config
					-- [lspconfig] Cannot access configuration for ansible. Ensure this server is listed in `server_configurations.md` or added as a custom server.
					--	null_ls.builtins.formatting.ansible_lint,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup()
		end,
	},
}
