return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = "[?] Find recently opened files" },
			{ "<leader>/", function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, desc = "[/] Fuzzily search in current buffer]" },
			{ "<leader>ff", function()
				require("telescope.builtin").find_files({ hidden = true })
			end, desc = "[F]ind [F]iles" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "[F]ind [H]elp" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "[F]ind current [W]ord" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "[F]ind by [G]rep" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "[F]ind [D]iagnostics" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[F]ind over [B]uffers" },
			{ "<leader>fS", "<cmd>Telescope git_status<cr>", desc = "[F]ind Git [S]tatus" },
			{ "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Find notifications" },
			{ "<leader>fc", function()
				require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
					preview = false,
				}))
			end, desc = "[F]ind [C]ommands" },
			{ "<leader>ss", function()
				require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
					preview = false,
				}))
			end, desc = "[S]pell [S]uggest" },
			{ "<c-r>", function()
				require("telescope.builtin").registers()
			end, mode = "i", desc = "Paste from selected register" },
		},
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = vim.fn.executable("make") == 1,
			},
			{
				"nvim-telescope/telescope-ui-select.nvim",
			},
		},
		config = function()
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
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

		-- Load extensions
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
	end,
	},
}