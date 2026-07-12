return {
	{
		"nvim-telescope/telescope.nvim",
		lazy = false, -- Load immediately for better performance
		priority = 900, -- Load after core plugins
		keys = {
			-- File navigation
			{ "<leader>ff", function()
				require("telescope.builtin").find_files({
					hidden = true,
					no_ignore = false,
					follow = false,
				})
			end, desc = "Find Files" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find Recent Files" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
			
			-- Search functionality
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Find Word Under Cursor" },
			{ "<leader>/", function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, desc = "Search in Current Buffer" },
			
			-- Help and documentation
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find Keymaps" },
			{ "<leader>fc", function()
				require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end, desc = "Find Commands" },
			
			-- Git integration
			{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
			
			-- LSP integration
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Find Diagnostics" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
			{ "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "LSP References" },
			{ "gi", "<cmd>Telescope lsp_implementations<cr>", desc = "LSP Implementations" },
			{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "LSP Type Definitions" },
			
			-- Plugin integrations
			{ "<leader>fn", "<cmd>Telescope notify<cr>", desc = "Find Notifications" },
			{ "<leader>fm", "<cmd>Telescope noice<cr>", desc = "Find Messages (Noice)" },
			{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
			
			-- Utility functions
			{ "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume Last Search" },
			{ "<leader>ss", function()
				require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
					previewer = false,
				}))
			end, desc = "Spell Suggest" },
			{ "<c-r>", function()
				require("telescope.builtin").registers()
			end, mode = "i", desc = "Paste from Register" },
			
			-- Advanced searches
			{ "<leader>fF", function()
				require("telescope.builtin").find_files({
					hidden = true,
					no_ignore = true,
					follow = true,
				})
			end, desc = "Find All Files (including ignored)" },
			{ "<leader>fG", function()
				require("telescope.builtin").live_grep({
					additional_args = {"--hidden"},
				})
			end, desc = "Live Grep (including hidden)" },
			
			-- Extension-based searches
			{ "<leader>fe", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
			{ "<leader>fE", function()
				require("telescope").extensions.file_browser.file_browser({
					path = "%:p:h",
					select_buffer = true,
				})
			end, desc = "File Browser (current dir)" },
			{ "<leader>fp", "<cmd>Telescope project<cr>", desc = "Find Projects" },
			
			-- Treesitter integration searches
			{ "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "Treesitter Symbols" },
			{ "<leader>fT", function()
				require("telescope.builtin").treesitter({
					symbols = { "function", "class", "method" },
				})
			end, desc = "Find Functions & Classes" },
			{ "<leader>fv", function()
				require("telescope.builtin").treesitter({
					symbols = { "variable", "property", "field" },
				})
			end, desc = "Find Variables & Properties" },
			{ "<leader>fC", function()
				require("telescope.builtin").treesitter({
					symbols = { "constant", "enum" },
				})
			end, desc = "Find Constants & Enums" },
		},
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{
				"nvim-telescope/telescope-ui-select.nvim",
			},
			{
				"nvim-telescope/telescope-file-browser.nvim",
			},
			{
				"nvim-telescope/telescope-project.nvim",
			},
			{
				-- Treesitter integration for enhanced symbol search
				"nvim-telescope/telescope-symbols.nvim",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			
			telescope.setup({
				defaults = {
					-- Enhanced visual appearance
					prompt_prefix = "  ",
					selection_caret = "  ",
					entry_prefix = "   ",
					multi_icon = " ",
					
					-- Layout configuration
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					
					-- Path display options
					path_display = { 
						"truncate",
						truncate = 3,
					},
					
					-- Performance optimizations
					cache_picker = {
						num_pickers = 10,
					},
					
					-- Enhanced file ignore patterns
					file_ignore_patterns = {
						-- Version control
						"%.git/",
						"%.svn/",
						"%.hg/",
						
						-- OS files
						"%.DS_Store",
						"Thumbs%.db",
						"desktop%.ini",
						
						-- Build artifacts
						"node_modules/",
						"target/",
						"build/",
						"dist/",
						"%.o",
						"%.a",
						"%.out",
						"%.class",
						"%.jar",
						"%.exe",
						"%.dll",
						"%.so",
						"%.dylib",
						
						-- Media files
						"%.pdf",
						"%.mkv",
						"%.mp4",
						"%.avi",
						"%.mov",
						"%.wmv",
						"%.mp3",
						"%.wav",
						"%.flac",
						"%.jpg",
						"%.jpeg",
						"%.png",
						"%.gif",
						"%.bmp",
						"%.tiff",
						
						-- Archives
						"%.zip",
						"%.tar",
						"%.tar%.gz",
						"%.tar%.bz2",
						"%.rar",
						"%.7z",
						
						-- IDE files
						"%.idea/",
						"%.vscode/",
						"%.eclipse/",
						
						-- Log files
						"%.log",
						"logs/",
					},
					
					-- Sorting strategy
					sorting_strategy = "ascending",
					
					-- Enhanced mappings
					mappings = {
						i = {
							-- Navigation
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							
							-- Preview scrolling
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							
							-- Selection actions
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,
							
							-- Utility
							["<C-l>"] = actions.complete_tag,
							["<C-/>"] = actions.which_key,
							["<C-_>"] = actions.which_key, -- For terminals that map C-/ as C-_
							
							-- Close
							["<C-c>"] = actions.close,
							["<Esc>"] = actions.close,
							
							-- Delete buffers
							["<C-Del>"] = function(prompt_bufnr)
								local current_picker = action_state.get_current_picker(prompt_bufnr)
								if current_picker.prompt_title == "Buffers" then
									actions.delete_buffer(prompt_bufnr)
								end
							end,
						},
						n = {
							-- Navigation
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["H"] = actions.move_to_top,
							["M"] = actions.move_to_middle,
							["L"] = actions.move_to_bottom,
							["gg"] = actions.move_to_top,
							["G"] = actions.move_to_bottom,
							
							-- Preview scrolling
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							
							-- Selection actions
							["<CR>"] = actions.select_default,
							["<C-x>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,
							
							-- Quickfix
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
							
							-- Close
							["q"] = actions.close,
							["<Esc>"] = actions.close,
							
							-- Toggle selection
							["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
							["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
							["<C-a>"] = actions.select_all,
							["<C-A>"] = actions.drop_all,
							
							-- Utility
							["?"] = actions.which_key,
						},
					},
					
					-- File sorter
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					
					-- Previewers
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					
					-- Buffer previewer
					buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
					
					-- Color and highlighting
					color_devicons = true,
					use_less = true,
					set_env = { ["COLORTERM"] = "truecolor" },
				},
				-- Picker-specific configurations with ivy theme and previews
				pickers = {
					find_files = {
						theme = "ivy",
						previewer = true, -- Enable file preview
						hidden = true,
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
					},
					live_grep = {
						additional_args = function()
							return { "--hidden" }
						end,
						theme = "ivy",
						previewer = true, -- Enable preview for grep results
					},
					grep_string = {
						theme = "ivy",
						previewer = true, -- Enable preview for grep string results
					},
					buffers = {
						theme = "ivy",
						previewer = true, -- Enable buffer preview
						initial_mode = "normal",
						sort_mru = true,
						sort_lastused = true,
					},
					oldfiles = {
						theme = "ivy",
						previewer = true, -- Enable recent files preview
					},
					commands = {
						theme = "ivy",
						previewer = false, -- Commands don't need preview
					},
					help_tags = {
						theme = "ivy",
						previewer = true, -- Enable help preview
					},
					diagnostics = {
						theme = "ivy",
						previewer = true, -- Enable diagnostics preview
						initial_mode = "normal",
					},
					lsp_references = {
						theme = "ivy",
						previewer = true, -- Enable LSP references preview
						initial_mode = "normal",
					},
					lsp_definitions = {
						theme = "ivy",
						previewer = true, -- Enable LSP definitions preview
						initial_mode = "normal",
					},
					lsp_implementations = {
						theme = "ivy",
						previewer = true, -- Enable LSP implementations preview
						initial_mode = "normal",
					},
					lsp_document_symbols = {
						theme = "ivy",
						previewer = true, -- Enable document symbols preview
						initial_mode = "normal",
					},
					lsp_workspace_symbols = {
						theme = "ivy",
						previewer = true, -- Enable workspace symbols preview
						initial_mode = "normal",
					},
					git_files = {
						theme = "ivy",
						previewer = true, -- Enable git files preview
						show_untracked = true,
					},
					git_branches = {
						theme = "ivy",
						previewer = false, -- Branches don't need preview
					},
					git_commits = {
						theme = "ivy",
						previewer = true, -- Enable git commits preview
					},
					git_status = {
						theme = "ivy",
						previewer = true, -- Enable git status preview
						initial_mode = "normal",
					},
					
					-- Enhanced treesitter picker for cloud security code
					treesitter = {
						theme = "ivy",
						previewer = true, -- Enable treesitter symbols preview
						initial_mode = "normal",
						show_line = true, -- Show line numbers
						symbols = { -- Focus on cloud/infrastructure symbols
							"function", "method", "class", "struct", "interface",
							"variable", "property", "field", "constant", "enum",
							"module", "namespace", "package", "constructor",
						},
					},
				},
				
				-- Extension configurations
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_ivy({
							previewer = false, -- UI select items don't need preview
							initial_mode = "normal",
							layout_config = {
								height = 0.4,
							},
						}),
					},
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					file_browser = {
						theme = "ivy",
						previewer = true, -- Enable file browser preview
						hijack_netrw = true,
						respect_gitignore = false, -- Show all files including ignored
						hidden = { file_browser = true, folder_browser = true }, -- Show hidden files
						grouped = true, -- Group directories first
						mappings = {
							["i"] = {
								-- Custom file browser mappings can be added here
							},
							["n"] = {
								-- Custom normal mode mappings can be added here
							},
						},
					},
					project = {
						base_dirs = (function()
							-- Only include base dirs that actually exist to avoid
							-- plenary.scandir "is not accessible" errors on startup
							local candidates = {
								{ "~/.config" },
								{ "~/Documents" },
								{ "~/Downloads", max_depth = 1 }, -- Search Downloads with limited depth
							}
							local base_dirs = {}
							for _, candidate in ipairs(candidates) do
								local path = vim.fn.expand(candidate[1])
								if vim.loop.fs_stat(path) then
									table.insert(base_dirs, candidate)
								end
							end
							return base_dirs
						end)(),
						hidden_files = true,
						theme = "ivy", -- Use ivy theme for consistency
						order_by = "asc",
						search_by = "title",
						sync_with_nvim_tree = true, -- Sync with file explorer if available
					},
				},
			})

			-- Load extensions with error handling
			local extensions = {
				"fzf",
				"ui-select", 
				"noice",
				"file_browser",
				"project",
				"symbols", -- Treesitter symbols integration
			}
			
			for _, extension in ipairs(extensions) do
				pcall(telescope.load_extension, extension)
			end
	end,
	},
}