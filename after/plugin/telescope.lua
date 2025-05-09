require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-q>"] = require("telescope.actions").send_selected_to_qflist
					+ require("telescope.actions").open_qflist,
			},
		},
	},
	extensions = {
		noice = {},
	},
})

pcall(require("telescope").local_extension, "fzf")

vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in curernt buffer]" })
vim.keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files({ hidden = true })
end, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[F]ind over [B]uffers" })
vim.keymap.set("n", "<leader>fS", require("telescope.builtin").git_status, { desc = "[F]ind Git [S]tatus" })
vim.keymap.set("n", "<Leader>fn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>", silent)
vim.keymap.set("n", "<leader>fc", function()
	require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
		preview = false,
	}))
end, { desc = "[F]ind [C]ommands" })
vim.keymap.set("n", "<leader>ss", function()
	require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
		preview = false,
	}))
end, { desc = "[S]pell [S]uggest" })
