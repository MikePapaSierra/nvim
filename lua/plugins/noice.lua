return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim", -- UI components library
		"rcarriga/nvim-notify", -- Enhanced notifications
		"nvim-treesitter/nvim-treesitter", -- For syntax highlighting in messages
	},
	keys = {
		-- Enhanced message management (VS Code style)
		{ "<leader>nd", "<cmd>NoiceDismiss<cr>", desc = "󰅖 Dismiss all notifications" },
		{ "<leader>nl", "<cmd>NoiceLast<cr>", desc = "󰋼 Show last message" },
		{ "<leader>nh", "<cmd>NoiceHistory<cr>", desc = "󰋚 Show message history" },
		{ "<leader>ne", "<cmd>NoiceErrors<cr>", desc = "󰅚 Show error messages" },
		{ "<leader>nt", "<cmd>NoiceTelescope<cr>", desc = "󰭎 Search messages with Telescope" },
		
		-- Enhanced command line navigation
		{ "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "󰘳 Redirect command to popup" },
		{ "<leader>snl", function() require("noice").cmd("last") end, desc = "󰋼 Show last Noice message" },
		{ "<leader>snh", function() require("noice").cmd("history") end, desc = "󰋚 Show Noice history" },
		{ "<leader>sna", function() require("noice").cmd("all") end, desc = "󰠶 Show all Noice messages" },
		
		-- Cloud security message filtering
		{ "<leader>nsec", function() require("noice").cmd("pick", { filter = { find = "security" } }) end, desc = "󰒃 Show security messages" },
		{ "<leader>nwarn", function() require("noice").cmd("pick", { filter = { kind = "warning" } }) end, desc = "󰀪 Show warnings" },
		{ "<leader>nerr", function() require("noice").cmd("pick", { filter = { kind = "error" } }) end, desc = "󰅚 Show errors" },
	},
	opts = {
		-- Enhanced command line interface (VS Code style)
		cmdline = {
			enabled = true,
			view = "cmdline_popup", -- Floating command line for modern UX
			opts = {
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				position = {
					row = "50%",
					col = "50%",
				},
				size = {
					min_width = 60,
					width = "auto",
					height = "auto",
				},
				win_options = {
					winblend = 0, -- No transparency for better readability
					winhighlight = {
						Normal = "NormalFloat",
						FloatBorder = "FloatBorder",
						CursorLine = "PmenuSel",
						Search = "None",
					},
				},
			},
			format = {
				-- Enhanced command formatting for cloud security
				cmdline = { pattern = "^:", icon = "󰘳", lang = "vim", title = " Command " },
				search_down = { kind = "search", pattern = "^/", icon = "󰍉 ", lang = "regex", title = " Search " },
				search_up = { kind = "search", pattern = "^%?", icon = "󰍉 ", lang = "regex", title = " Search " },
				filter = { pattern = "^:%s*!", icon = "󰻿", lang = "bash", title = " Shell " },
				lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=" }, icon = "󰢱", lang = "lua", title = " Lua " },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "󰘥", title = " Help " },
				
				-- Cloud security specific commands
				terraform = { pattern = "^:%s*!terraform", icon = "󱁢", lang = "hcl", title = " Terraform " },
				docker = { pattern = "^:%s*!docker", icon = "󰡨", lang = "dockerfile", title = " Docker " },
				kubectl = { pattern = "^:%s*!kubectl", icon = "󱃾", lang = "yaml", title = " Kubernetes " },
				git = { pattern = "^:%s*!git", icon = "󰊢", lang = "gitcommit", title = " Git " },
				ansible = { pattern = "^:%s*!ansible", icon = "󱂚", lang = "ansible", title = " Ansible " },
			},
		},
		
		-- Professional message system
		messages = {
			enabled = true,
			view = "notify", -- Use nvim-notify for all messages
			view_error = "notify",
			view_warn = "notify", 
			view_history = "messages",
			view_search = "virtualtext", -- Show search count in virtual text
		},
		
		-- Enhanced popup menu for completions
		popupmenu = {
			enabled = true,
			backend = "nui", -- Use nui for better performance
			kind_icons = {
				-- Enhanced icons for cloud security engineering
				Text = "󰉿",
				Method = "󰆧",
				Function = "󰊕",
				Constructor = "󰡱",
				Field = "󰜢",
				Variable = "󰀫",
				Class = "󰠱",
				Interface = "󰜰",
				Module = "󰏗",
				Property = "󰜢",
				Unit = "󰑭",
				Value = "󰎠",
				Enum = "󰒻",
				Keyword = "󰌋",
				Snippet = "󰅴",
				Color = "󰏘",
				File = "󰈙",
				Reference = "󰈇",
				Folder = "󰉋",
				EnumMember = "󰒻",
				Constant = "󰏿",
				Struct = "󰙅",
				Event = "󰉁",
				Operator = "󰆕",
				TypeParameter = "󰊄",
				
				-- Cloud security specific
				Secret = "󰌋",
				Config = "󰒓",
				Security = "󰒃",
				Compliance = "󰈸",
				Policy = "󰿭",
			},
		},
		
		-- Smart message redirection
		redirect = {
			view = "popup",
			filter = { event = "msg_show" },
		},
		
		-- Enhanced LSP integration
		lsp = {
			progress = {
				enabled = true,
				format = "lsp_progress",
				format_done = "lsp_progress_done",
				throttle = 1000 / 30, -- frequency of updates
				view = "mini",
			},
			override = {
				-- Enable enhanced rendering for better markdown support
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- Enhanced completion docs
			},
			hover = {
				enabled = true,
				silent = false, -- Show hover progress
				view = nil, -- Use default hover view
				opts = {}, -- Merged with defaults
			},
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					trigger = true, -- Auto-open signature help
					luasnip = true, -- Include luasnip completions
					throttle = 50, -- Throttle signature help updates
				},
				view = nil, -- Use default signature view
				opts = {}, -- Merged with defaults
			},
			message = {
				enabled = true,
				view = "notify", -- Use notify for LSP messages
				opts = {},
			},
			documentation = {
				view = "hover",
				opts = {
					lang = "markdown",
					replace = true,
					render = "plain",
					format = { "{message}" },
					win_options = { 
						concealcursor = "n", 
						conceallevel = 3,
						winblend = 0, -- No transparency for better readability
					},
				},
			},
		},
		
		-- Smart message routing for cloud security engineering
		routes = {
			-- Filter out noisy messages
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "No information available" },
						{ find = "search hit BOTTOM" },
						{ find = "search hit TOP" },
						{ find = "Pattern not found" },
						{ find = "E486" }, -- Pattern not found
						{ find = "E121" }, -- Undefined variable
					},
				},
				skip = true,
			},
			
			-- Route security-related messages to notify with high priority
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "security" },
						{ find = "vulnerability" },
						{ find = "CVE" },
						{ find = "SECURITY" },
						{ find = "SECRET" },
						{ find = "password" },
						{ find = "credential" },
						{ find = "token" },
					},
				},
				view = "notify",
				opts = { 
					level = "warn",
					title = "󰒃 Security Alert",
					timeout = 10000, -- Keep security messages longer
				},
			},
			
			-- Route git messages to mini view
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "git" },
						{ find = "Git" },
						{ find = "branch" },
						{ find = "commit" },
						{ find = "merge" },
					},
				},
				view = "mini",
			},
			
			-- Route LSP errors to notify
			{
				filter = {
					event = "lsp",
					kind = "message",
					any = {
						{ find = "error" },
						{ find = "Error" },
						{ find = "ERROR" },
					},
				},
				view = "notify",
				opts = { level = "error" },
			},
			
			-- Route long messages to split
			{
				filter = {
					event = "msg_show",
					min_height = 20,
				},
				view = "split",
			},
			
			-- Route very long messages to split with custom opts
			{
				filter = {
					event = "msg_show",
					min_height = 10,
				},
				view = "messages", -- Send to message history
			},
		},
		
		-- Enhanced command line presets
		presets = {
			bottom_search = false, -- Use floating search for modern UX
			command_palette = true, -- Command palette style
			long_message_to_split = true, -- Long messages in split
			inc_rename = true, -- Enhanced rename dialog
			lsp_doc_border = true, -- Bordered LSP docs
		},
		
		-- Performance optimization
		throttle = 1000 / 30, -- 30 FPS for smooth animations
		
		-- Enhanced view configurations
		views = {
			-- Floating command line with professional styling
			cmdline_popup = {
				position = {
					row = "50%",
					col = "50%",
				},
				size = {
					width = "auto",
					height = "auto",
					max_width = 100,
					min_width = 40,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winblend = 0,
					winhighlight = {
						Normal = "NormalFloat",
						FloatBorder = "FloatBorder",
						IncSearch = "",
						Search = "",
					},
				},
			},
			
			-- Enhanced popup menu
			popupmenu = {
				relative = "editor",
				position = {
					row = "auto",
					col = "auto",
				},
				size = {
					width = "auto",
					height = "auto",
					max_height = 15,
					min_width = 20,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winblend = 0,
					winhighlight = {
						Normal = "NormalFloat",
						FloatBorder = "FloatBorder",
						CursorLine = "PmenuSel",
						Search = "None",
					},
				},
			},
			
			-- Confirmation dialog styling
			confirm = {
				backend = "popup",
				relative = "editor",
				focusable = false,
				align = "center",
				enter = false,
				zindex = 210,
				format = { "{confirm}" },
				position = {
					row = "50%",
					col = "50%",
				},
				size = "auto",
				border = {
					style = "rounded",
					padding = { 0, 1 },
					text = {
						top = " Confirm ",
					},
				},
				win_options = {
					winblend = 0,
					winhighlight = {
						Normal = "NormalFloat",
						FloatBorder = "FloatBorder",
					},
				},
			},
			
			-- Mini view for less important messages
			mini = {
				backend = "mini",
				relative = "editor",
				align = "message-right",
				timeout = 2000,
				reverse = true,
				focusable = false,
				position = {
					row = -2,
					col = "100%",
					-- col = 0,
				},
				size = "auto",
				border = {
					style = "none",
				},
				zindex = 60,
				win_options = {
					winblend = 0,
					winhighlight = {
						Normal = "NoiceMini",
						IncSearch = "",
						CurSearch = "",
						Search = "",
					},
				},
			},
			
			-- Split view for long messages
			split = {
				backend = "split",
				enter = true,
				relative = "editor",
				position = "bottom",
				size = "20%",
				close = {
					keys = { "q", "<Esc>" },
				},
				win_options = {
					winhighlight = { Normal = "Normal" },
				},
			},
			
			-- Popup view for redirected messages
			popup = {
				backend = "popup",
				close = {
					events = { "BufLeave" },
					keys = { "q", "<Esc>" },
				},
				enter = true,
				border = {
					style = "rounded",
				},
				position = {
					row = "50%",
					col = "50%",
				},
				size = {
					width = "80%",
					height = "60%",
				},
				win_options = {
					winblend = 0,
					winhighlight = {
						Normal = "NormalFloat",
						FloatBorder = "FloatBorder",
					},
				},
			},
			
			-- Hover documentation
			hover = {
				border = {
					style = "rounded",
					padding = { 0, 2 },
				},
				position = { row = 2, col = 2 },
				win_options = {
					winblend = 0,
					winhighlight = {
						Normal = "NormalFloat",
						FloatBorder = "FloatBorder",
					},
				},
			},
		},
		
		-- Enhanced format configurations
		format = {
			-- Level formatting for different message types
			level = {
				icons = {
					error = "󰅚",
					warn = "󰀪",
					info = "󰋽",
					debug = "󰃤",
					trace = "󰜥",
				},
			},
			
			-- Progress formatting
			lsp_progress = {
				"{progress}% {data.progress.message}",
			},
			lsp_progress_done = {
				"󰄬 {data.progress.title}",
			},
			
			-- Enhanced spinner for operations
			spinner = {
				name = "dots12",
			},
			
			-- Enhanced confirmation formatting
			confirm = {
				"{confirm}",
			},
		},
	},
	
	config = function(_, opts)
		-- Setup noice with enhanced configuration
		require("noice").setup(opts)
		
		-- Enhanced integration with telescope if available
		if pcall(require, "telescope") then
			require("telescope").load_extension("noice")
		end
		
		-- Custom highlight groups for Catppuccin integration
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("NoiceHighlights", { clear = true }),
			callback = function()
				-- Catppuccin color integration
				local colors = {
					NoiceCommand = { fg = "#89b4fa" }, -- Blue for commands
					NoiceCommandIcon = { fg = "#89b4fa" },
					NoiceSearch = { fg = "#f9e2af" }, -- Yellow for search
					NoiceSearchIcon = { fg = "#f9e2af" },
					NoiceLsp = { fg = "#a6e3a1" }, -- Green for LSP
					NoiceLspProgress = { fg = "#a6e3a1" },
					NoiceMini = { bg = "#313244" }, -- Surface0 for mini
					NoiceFormatConfirm = { fg = "#f38ba8" }, -- Red for confirmations
					NoiceFormatConfirmDefault = { fg = "#89b4fa" }, -- Blue for default
					NoiceFormatTitle = { fg = "#cba6f7", bold = true }, -- Mauve for titles
					
					-- Security-related highlights
					NoiceSecurity = { fg = "#f38ba8", bold = true }, -- Red for security
					NoiceGit = { fg = "#fab387" }, -- Peach for git
					NoiceDocker = { fg = "#89dceb" }, -- Sky for docker
					NoiceTerraform = { fg = "#a6e3a1" }, -- Green for terraform
				}
				
				for group, color in pairs(colors) do
					vim.api.nvim_set_hl(0, group, color)
				end
			end,
		})
		
		-- User commands for enhanced functionality
		vim.api.nvim_create_user_command("NoiceConfig", function()
			vim.cmd("edit " .. vim.fn.stdpath("config") .. "/lua/plugins/noice.lua")
		end, { desc = "Edit Noice configuration" })
		
		vim.api.nvim_create_user_command("NoiceDebug", function()
			require("noice").cmd("stats")
		end, { desc = "Show Noice debug stats" })
		
		vim.api.nvim_create_user_command("NoiceClear", function()
			require("noice").cmd("dismiss")
			require("notify").dismiss({ silent = true, pending = true })
		end, { desc = "Clear all notifications and messages" })
		
		-- Security-focused message commands
		vim.api.nvim_create_user_command("NoiceSecurity", function()
			require("noice").cmd("pick", { 
				filter = { 
					any = {
						{ find = "security" },
						{ find = "vulnerability" },
						{ find = "CVE" },
						{ find = "SECRET" },
						{ find = "password" },
					}
				}
			})
		end, { desc = "Show security-related messages" })
		
		vim.api.nvim_create_user_command("NoiceErrors", function()
			require("noice").cmd("pick", { filter = { error = true } })
		end, { desc = "Show error messages only" })
		
		vim.api.nvim_create_user_command("NoiceWarnings", function()
			require("noice").cmd("pick", { filter = { warning = true } })
		end, { desc = "Show warning messages only" })
	end,
}
