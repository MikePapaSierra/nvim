return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		event = "VeryLazy",
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- Enhanced file icons
		},
		keys = {
			-- Primary file tree navigation (VS Code style)
			{ "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "󰔱 Toggle file tree (VS Code style)" },
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "󰔱 Toggle explorer" },
			{ "<leader>ef", "<cmd>NvimTreeFindFileToggle<cr>", desc = "󰈞 Toggle file tree on current file" },
			{ "<leader>ec", "<cmd>NvimTreeCollapse<cr>", desc = "󰘖 Collapse file tree" },
			{ "<leader>er", "<cmd>NvimTreeRefresh<cr>", desc = "󰑐 Refresh file tree" },
			
			-- Enhanced file tree operations
			{ "<leader>es", "<cmd>NvimTreeResize<cr>", desc = "󰩨 Resize file tree" },
			{ "<leader>eq", "<cmd>NvimTreeClose<cr>", desc = "󰅖 Close file tree" },
			{ "<leader>eb", "<cmd>NvimTreeToggle %:p:h<cr>", desc = "󰉋 Open file tree on buffer dir" },
			
			-- Cloud security file operations
			{ "<leader>ey", function() _G.copy_file_path() end, desc = "󰆐 Copy file path" },
			{ "<leader>eY", function() _G.copy_relative_path() end, desc = "󰆏 Copy relative path" },
			{ "<leader>ed", function() _G.duplicate_file() end, desc = "󰆓 Duplicate file" },
			{ "<leader>em", function() _G.move_file() end, desc = "󰪹 Move/rename file" },
		},
		opts = {
			-- VS Code-style file tree configuration
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = false,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			reload_on_bufenter = false,
			select_prompts = false,
			sort_by = "case_sensitive",
			root_dirs = {},
			prefer_startup_root = false,
			
			-- Enhanced view configuration
			view = {
				centralize_selection = false,
				cursorline = true,
				debounce_delay = 15,
				width = function()
					return math.max(30, math.min(50, math.floor(vim.o.columns * 0.25)))
				end,
				side = "left",
				preserve_window_proportions = true,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
				float = {
					enable = false,
					quit_on_focus_loss = true,
					open_win_config = {
						relative = "editor",
						border = "rounded",
						width = 50,
						height = 30,
						row = 1,
						col = 1,
					},
				},
			},
			
			-- Enhanced renderer for cloud security engineering
			renderer = {
				add_trailing = false,
				group_empty = true,
				highlight_git = true,
				full_name = false,
				highlight_opened_files = "name",
				highlight_modified = "name",
				root_folder_label = ":t",
				
				-- Enhanced indent markers
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└",
						edge = "│",
						item = "│",
						bottom = "─",
						none = " ",
					},
				},
				
				-- Professional icon configuration
				icons = {
					webdev_colors = true, -- Use enhanced colors
					git_placement = "before",
					modified_placement = "after",
					padding = " ",
					symlink_arrow = " ➛ ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
						modified = true,
						diagnostics = true,
						bookmarks = true,
					},
					glyphs = {
						default = "󰈚",
						symlink = "󰌷",
						bookmark = "󰆤",
						modified = "󰏫", -- Enhanced modified indicator
						folder = {
							arrow_closed = "󰅂",
							arrow_open = "󰅀",
							default = "󰉋",
							open = "󰝰",
							empty = "󰉖",
							empty_open = "󰉖",
							symlink = "󰉒",
							symlink_open = "󰉒",
						},
						git = {
							unstaged = "󰄱", -- Enhanced git icons
							staged = "󰱒",
							unmerged = "",
							renamed = "󰁕",
							untracked = "󰋖",
							deleted = "󰍵",
							ignored = "󰿠",
						},
					},
				},
				
				-- Special file highlighting for cloud security
				special_files = {
					"Cargo.toml",
					"Makefile",
					"README.md",
					"readme.md",
					"package.json",
					"go.mod",
					"go.sum",
					"requirements.txt",
					"Pipfile",
					"poetry.lock",
					"Dockerfile",
					"docker-compose.yml",
					"docker-compose.yaml",
					"kubernetes.yml",
					"kubernetes.yaml",
					"terraform.tf",
					"terraform.tfvars",
					"terragrunt.hcl",
					".env",
					".env.example",
					".gitignore",
					".gitattributes",
					"LICENSE",
					"SECURITY.md",
					"CHANGELOG.md",
				},
			},
			
			-- Enhanced hijack directories
			hijack_directories = {
				enable = true,
				auto_open = true,
			},
			
			-- Security-aware filters
			filters = {
				dotfiles = false, -- Show dotfiles for security configs
				git_clean = false,
				no_buffer = false,
				custom = {
					".DS_Store",
					".git",
					"node_modules",
					".cache",
					"__pycache__",
					"*.pyc",
					".pytest_cache",
					".coverage",
					"dist",
					"build",
					".terraform",
					".terragrunt-cache",
					"vendor",
					"target",
				},
				exclude = {
					".gitignore",
					".env.example",
					".env.template",
					".gitattributes",
					"SECURITY.md",
					"LICENSE",
					"README.md",
					"Dockerfile",
					"docker-compose.yml",
					"kubernetes.yml",
					"terraform.tf",
					"terragrunt.hcl",
				},
			},
			
			-- Enhanced git integration
			git = {
				enable = true,
				ignore = false,
				show_on_dirs = true,
				show_on_open_dirs = true,
				disable_for_dirs = {},
				timeout = 400,
			},
			
			-- Diagnostics integration for security issues
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				show_on_open_dirs = true,
				debounce_delay = 50,
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
				icons = {
					hint = "󰌶",
					info = "󰋽",
					warning = "󰀪",
					error = "󰅚",
				},
			},
			
			-- Enhanced filesystem watchers
			filesystem_watchers = {
				enable = true,
				debounce_delay = 50,
				ignore_dirs = {
					"node_modules",
					".git",
					".terraform",
					".terragrunt-cache",
					"__pycache__",
					".pytest_cache",
					"vendor",
					"target",
				},
			},
			
			-- Professional actions configuration
			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
					restrict_above_cwd = false,
				},
				expand_all = {
					max_folder_discovery = 300,
					exclude = {
						".git",
						"node_modules",
						".terraform",
						"vendor",
						"target",
					},
				},
				file_popup = {
					open_win_config = {
						col = 1,
						row = 1,
						relative = "cursor",
						border = "rounded",
						style = "minimal",
					},
				},
				open_file = {
					quit_on_open = false,
					resize_window = true,
					window_picker = {
						enable = true,
						picker = "default",
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = {
								"notify",
								"packer",
								"qf",
								"diff",
								"fugitive",
								"fugitiveblame",
								"alpha",
								"dashboard",
								"lazy",
								"mason",
								"trouble",
								"toggleterm",
							},
							buftype = {
								"nofile",
								"terminal",
								"help",
							},
						},
					},
				},
				remove_file = {
					close_window = true,
				},
			},
			
			-- Enhanced trash configuration
			trash = {
				cmd = "gio trash",
				require_confirm = true,
			},
			
			-- Live filter configuration
			live_filter = {
				prefix = "[FILTER]: ",
				always_show_folders = true,
			},
			
			-- Tab configuration
			tab = {
				sync = {
					open = false,
					close = false,
					ignore = {},
				},
			},
			
			-- Notification integration
			notify = {
				threshold = vim.log.levels.INFO,
				absolute_path = true,
			},
			
			-- Enhanced UI configuration
			ui = {
				confirm = {
					remove = true,
					trash = true,
					default_yes = false,
				},
			},
			
			-- Log configuration for debugging
			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					dev = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
		},
		
		config = function(_, opts)
			-- Disable netrw at the very start to prevent conflicts
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			
			-- Clear any existing nvim-tree buffers to prevent conflicts
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				local name = vim.api.nvim_buf_get_name(buf)
				if name:match("NvimTree_") then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
			
			-- Enhanced file tree utility functions for cloud security engineering
			
			-- Copy file path to clipboard
			function _G.copy_file_path()
				local ok, api = pcall(require, "nvim-tree.api")
				if not ok then
					vim.notify("nvim-tree not available", vim.log.levels.ERROR)
					return
				end
				local node = api.tree.get_node_under_cursor()
				if node then
					vim.fn.setreg("+", node.absolute_path)
					vim.notify("Copied file path: " .. node.absolute_path, vim.log.levels.INFO)
				end
			end
			
			-- Copy relative path to clipboard
			function _G.copy_relative_path()
				local ok, api = pcall(require, "nvim-tree.api")
				if not ok then
					vim.notify("nvim-tree not available", vim.log.levels.ERROR)
					return
				end
				local node = api.tree.get_node_under_cursor()
				if node then
					local relative_path = vim.fn.fnamemodify(node.absolute_path, ":~:.")
					vim.fn.setreg("+", relative_path)
					vim.notify("Copied relative path: " .. relative_path, vim.log.levels.INFO)
				end
			end
			
			-- Duplicate file functionality
			function _G.duplicate_file()
				local ok, api = pcall(require, "nvim-tree.api")
				if not ok then
					vim.notify("nvim-tree not available", vim.log.levels.ERROR)
					return
				end
				local node = api.tree.get_node_under_cursor()
				if node and node.type == "file" then
					local old_name = node.absolute_path
					local new_name = old_name .. ".copy"
					
					vim.ui.input({
						prompt = "Duplicate as: ",
						default = new_name,
					}, function(input)
						if input then
							local success, err = pcall(vim.loop.fs_copyfile, old_name, input)
							if success then
								vim.notify("File duplicated: " .. input, vim.log.levels.INFO)
								api.tree.reload()
							else
								vim.notify("Error duplicating file: " .. err, vim.log.levels.ERROR)
							end
						end
					end)
				end
			end
			
			-- Move/rename file functionality
			function _G.move_file()
				local ok, api = pcall(require, "nvim-tree.api")
				if not ok then
					vim.notify("nvim-tree not available", vim.log.levels.ERROR)
					return
				end
				local node = api.tree.get_node_under_cursor()
				if node then
					local old_name = node.absolute_path
					vim.ui.input({
						prompt = "Move/rename to: ",
						default = old_name,
					}, function(input)
						if input and input ~= old_name then
							local success, err = pcall(vim.loop.fs_rename, old_name, input)
							if success then
								vim.notify("File moved: " .. input, vim.log.levels.INFO)
								api.tree.reload()
							else
								vim.notify("Error moving file: " .. err, vim.log.levels.ERROR)
							end
						end
					end)
				end
			end
			
			-- Enhanced nvim-tree keymaps
			local function tree_on_attach(bufnr)
				local api = require("nvim-tree.api")
				
				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end
				
				-- Default mappings (enhanced)
				api.config.mappings.default_on_attach(bufnr)
				
				-- Cloud security engineering mappings
				vim.keymap.set("n", "y", _G.copy_file_path, opts("Copy file path"))
				vim.keymap.set("n", "Y", _G.copy_relative_path, opts("Copy relative path"))
				vim.keymap.set("n", "D", _G.duplicate_file, opts("Duplicate file"))
				vim.keymap.set("n", "M", _G.move_file, opts("Move/rename file"))
				
				-- Enhanced navigation
				vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
				vim.keymap.set("n", "<C-r>", api.tree.reload, opts("Refresh"))
				vim.keymap.set("n", "<C-f>", api.live_filter.start, opts("Live filter"))
				vim.keymap.set("n", "<C-c>", api.live_filter.clear, opts("Clear filter"))
				
				-- Git operations (updated for current API)
				vim.keymap.set("n", "gs", function()
					local node = api.tree.get_node_under_cursor()
					if node then
						-- Use git command directly for staging
						vim.cmd("silent !git add " .. vim.fn.shellescape(node.absolute_path))
						api.tree.reload()
						vim.notify("Staged: " .. node.name, vim.log.levels.INFO)
					end
				end, opts("Git stage"))
				
				vim.keymap.set("n", "gu", function()
					local node = api.tree.get_node_under_cursor()
					if node then
						-- Use git command directly for unstaging
						vim.cmd("silent !git reset HEAD " .. vim.fn.shellescape(node.absolute_path))
						api.tree.reload()
						vim.notify("Unstaged: " .. node.name, vim.log.levels.INFO)
					end
				end, opts("Git unstage"))
				
				vim.keymap.set("n", "gr", function()
					local node = api.tree.get_node_under_cursor()
					if node then
						-- Use git command directly for reverting
						vim.ui.input({
							prompt = "Revert changes for " .. node.name .. "? (y/N): ",
						}, function(input)
							if input and (input:lower() == "y" or input:lower() == "yes") then
								vim.cmd("silent !git checkout -- " .. vim.fn.shellescape(node.absolute_path))
								api.tree.reload()
								vim.notify("Reverted: " .. node.name, vim.log.levels.INFO)
							end
						end)
					end
				end, opts("Git revert"))
				
				-- File operations
				vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open horizontal split"))
				vim.keymap.set("n", "v", api.node.open.vertical, opts("Open vertical split"))
				vim.keymap.set("n", "t", api.node.open.tab, opts("Open in new tab"))
				vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open in new tab"))
				
				-- Bookmark operations
				vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle bookmark"))
				vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move bookmarked"))
				
				-- Security-focused quick access
				vim.keymap.set("n", "<leader>sf", function()
					api.tree.find_file(vim.fn.expand("~/.ssh/config"))
				end, opts("Find SSH config"))
				
				vim.keymap.set("n", "<leader>se", function()
					api.tree.find_file(".env")
				end, opts("Find .env file"))
				
				vim.keymap.set("n", "<leader>sg", function()
					api.tree.find_file(".gitignore")
				end, opts("Find .gitignore"))
				
				vim.keymap.set("n", "<leader>sd", function()
					api.tree.find_file("Dockerfile")
				end, opts("Find Dockerfile"))
				
				vim.keymap.set("n", "<leader>st", function()
					api.tree.find_file("terraform.tf")
				end, opts("Find Terraform files"))
			end
			
			-- Set up opts with on_attach function
			opts.on_attach = tree_on_attach
			
			-- Initialize nvim-tree
			require("nvim-tree").setup(opts)
			
			-- Catppuccin theme integration
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("NvimTreeHighlights", { clear = true }),
				callback = function()
					-- Catppuccin color integration
					local colors = {
						NvimTreeNormal = { bg = "#1e1e2e" }, -- Catppuccin base
						NvimTreeNormalNC = { bg = "#1e1e2e" },
						NvimTreeRootFolder = { fg = "#89b4fa", bold = true }, -- Catppuccin blue
						NvimTreeGitDirty = { fg = "#fab387" }, -- Catppuccin peach
						NvimTreeGitNew = { fg = "#a6e3a1" }, -- Catppuccin green
						NvimTreeGitDeleted = { fg = "#f38ba8" }, -- Catppuccin red
						NvimTreeSpecialFile = { fg = "#f9e2af", bold = true }, -- Catppuccin yellow
						NvimTreeIndentMarker = { fg = "#45475a" }, -- Catppuccin surface1
						NvimTreeImageFile = { fg = "#cba6f7" }, -- Catppuccin mauve
						NvimTreeSymlink = { fg = "#94e2d5" }, -- Catppuccin teal
						NvimTreeFolderName = { fg = "#89b4fa" }, -- Catppuccin blue
						NvimTreeFolderIcon = { fg = "#89b4fa" }, -- Catppuccin blue
						NvimTreeOpenedFolderName = { fg = "#89b4fa", bold = true },
						
						-- Security file highlighting
						NvimTreeSecurityFile = { fg = "#f38ba8", bold = true }, -- Red for security files
						NvimTreeConfigFile = { fg = "#cba6f7", bold = true }, -- Mauve for config files
						NvimTreeDockerFile = { fg = "#89dceb", bold = true }, -- Sky for Docker files
						NvimTreeTerraformFile = { fg = "#a6e3a1", bold = true }, -- Green for Terraform
					}
					
					for group, color in pairs(colors) do
						vim.api.nvim_set_hl(0, group, color)
					end
				end,
			})
			
			-- Auto-open nvim-tree for directories
			vim.api.nvim_create_autocmd("VimEnter", {
				group = vim.api.nvim_create_augroup("NvimTreeAutoOpen", { clear = true }),
				callback = function(data)
					-- Buffer is a directory
					local directory = vim.fn.isdirectory(data.file) == 1
					
					if directory then
						-- Change to the directory
						vim.cmd.cd(data.file)
						-- Open the tree
						require("nvim-tree.api").tree.open()
					end
				end,
			})
			
			-- Auto-close when nvim-tree is the last window
			vim.api.nvim_create_autocmd("QuitPre", {
				group = vim.api.nvim_create_augroup("NvimTreeAutoClose", { clear = true }),
				callback = function()
					local tree_wins = {}
					local floating_wins = {}
					local wins = vim.api.nvim_list_wins()
					for _, w in ipairs(wins) do
						local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
						if bufname:match("NvimTree_") ~= nil then
							table.insert(tree_wins, w)
						end
						if vim.api.nvim_win_get_config(w).relative ~= "" then
							table.insert(floating_wins, w)
						end
					end
					if 1 == #wins - #floating_wins - #tree_wins then
						-- Should quit, so we close all invalid windows.
						for _, w in ipairs(tree_wins) do
							vim.api.nvim_win_close(w, true)
						end
					end
				end,
			})
			
			-- User commands for enhanced functionality
			vim.api.nvim_create_user_command("TreeFindFile", function()
				require("nvim-tree.api").tree.find_file()
			end, { desc = "Find current file in tree" })
			
			vim.api.nvim_create_user_command("TreeCollapse", function()
				require("nvim-tree.api").tree.collapse_all()
			end, { desc = "Collapse all tree nodes" })
			
			vim.api.nvim_create_user_command("TreeExpandAll", function()
				require("nvim-tree.api").tree.expand_all()
			end, { desc = "Expand all tree nodes" })
			
			vim.api.nvim_create_user_command("TreeToggleGitIgnore", function()
				require("nvim-tree.api").tree.toggle_gitignore_filter()
			end, { desc = "Toggle git ignore filter" })
			
			vim.api.nvim_create_user_command("TreeToggleHidden", function()
				require("nvim-tree.api").tree.toggle_hidden_filter()
			end, { desc = "Toggle hidden files filter" })
			
			-- Security-focused file finder commands
			vim.api.nvim_create_user_command("FindDockerfile", function()
				require("nvim-tree.api").tree.find_file("Dockerfile")
			end, { desc = "Find Dockerfile in tree" })
			
			vim.api.nvim_create_user_command("FindEnvFile", function()
				require("nvim-tree.api").tree.find_file(".env")
			end, { desc = "Find .env file in tree" })
			
			vim.api.nvim_create_user_command("FindTerraform", function()
				require("nvim-tree.api").tree.find_file("terraform.tf")
			end, { desc = "Find Terraform files in tree" })
			
			vim.api.nvim_create_user_command("FindKubernetes", function()
				require("nvim-tree.api").tree.find_file("kubernetes.yml")
			end, { desc = "Find Kubernetes files in tree" })
		end,
	}
}
