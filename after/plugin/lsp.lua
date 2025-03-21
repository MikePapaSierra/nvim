local on_attach = function(_, bufnr)
	---- TODO: Confilicting with Spectre keymapping
	----bufmap('<leader>s', require('telescope.builtin').lsp_document_symbols)
	----bufmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols)

	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = bufnr })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = bufnr })
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = bufnr })
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = bufnr })
	vim.keymap.set("n", "td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = bufnr })
	vim.keymap.set(
		"n",
		"gr",
		require("telescope.builtin").lsp_references,
		{ desc = "LSP: [G]oto [R]eferences", buffer = bufnr }
	)
	vim.keymap.set(
		"n",
		"gi",
		require("telescope.builtin").lsp_implementations,
		{ desc = "LSP: [G]oto [I]mplementations", buffer = bufnr }
	)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = bufnr })
	vim.keymap.set(
		"n",
		"<leader>k",
		vim.lsp.buf.signature_help,
		{ desc = "LSP: Signature documentation", buffer = bufnr }
	)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature documentation", buffer = bufnr })

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	require("mason").setup()
	require("mason-lspconfig").setup_handlers({

		function(server_name)
			require("lspconfig")[server_name].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,

		["lua_ls"] = function()
			require("neodev").setup()
			require("lspconfig").lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})
		end,

		["pyright"] = function()
			require("lspconfig").pyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetype = { "python" },
			})
		end,

		["ansiblels"] = function()
			require("lspconfig").ansible.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				filetype = { "yml", "yaml", "ansible" },
			})
		end,
	})
	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})
end
