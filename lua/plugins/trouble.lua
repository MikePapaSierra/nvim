return {
	"folke/trouble.nvim",
	version = "^3.0", -- Use latest v3 for modern features
	cmd = "Trouble",
	keys = {
		-- Enhanced diagnostic navigation optimized for cloud security engineering
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
		{ "<leader>xw", "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.WARN<cr>", desc = "Warnings (Trouble)" },
		{ "<leader>xe", "<cmd>Trouble diagnostics toggle filter.severity=vim.diagnostic.severity.ERROR<cr>", desc = "Errors (Trouble)" },
		
		-- Symbol and code navigation
		{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
		{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
		{ "<leader>cr", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP References (Trouble)" },
		{ "<leader>cd", "<cmd>Trouble lsp_definitions toggle<cr>", desc = "LSP Definitions (Trouble)" },
		{ "<leader>ci", "<cmd>Trouble lsp_implementations toggle<cr>", desc = "LSP Implementations (Trouble)" },
		{ "<leader>ct", "<cmd>Trouble lsp_type_definitions toggle<cr>", desc = "LSP Type Definitions (Trouble)" },
		
		-- Enhanced quickfix and location list management
		{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle focus=true<cr>", desc = "Location List Focus (Trouble)" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle focus=true<cr>", desc = "Quickfix Focus (Trouble)" },
		
		-- Security-focused shortcuts for cloud engineering
		{ "<leader>xs", function()
			require("trouble").toggle({
				mode = "diagnostics",
				filter = {
					any = {
						buf = 0,
						function(item)
							-- Filter for security-related diagnostics
							local message = item.message:lower()
							return message:match("security") or 
								   message:match("vulnerability") or 
								   message:match("secret") or 
								   message:match("credential") or 
								   message:match("password") or 
								   message:match("token") or 
								   message:match("hardcoded") or 
								   message:match("insecure")
						end,
					},
				},
			})
		end, desc = "Security Issues (Trouble)" },
		
		{ "<leader>xc", function()
			require("trouble").toggle({
				mode = "diagnostics", 
				filter = {
					any = {
						buf = 0,
						function(item)
							-- Filter for configuration and compliance issues
							local message = item.message:lower()
							return message:match("deprecated") or 
								   message:match("obsolete") or 
								   message:match("compliance") or 
								   message:match("policy") or 
								   message:match("lint")
						end,
					},
				},
			})
		end, desc = "Config/Compliance Issues (Trouble)" },
		
		-- Quick navigation
		{ "gR", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP References (Trouble)" },
		{ "]t", function() require("trouble").next({ skip_groups = true, jump = true }) end, desc = "Next trouble item" },
		{ "[t", function() require("trouble").prev({ skip_groups = true, jump = true }) end, desc = "Previous trouble item" },
		{ "]T", function() require("trouble").last({ skip_groups = true, jump = true }) end, desc = "Last trouble item" },
		{ "[T", function() require("trouble").first({ skip_groups = true, jump = true }) end, desc = "First trouble item" },
	},
	dependencies = { 
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim", -- For enhanced TODO integration
	},
	opts = {
		-- Enhanced configuration optimized for cloud security engineering
		modes = {
			-- Diagnostics modes with enhanced filtering
			diagnostics = {
				mode = "diagnostics",
				preview = {
					type = "split",
					relative = "win",
					position = "right",
					size = 0.3,
				},
				filter = {
					any = {
						buf = 0, -- Current buffer
						function(item)
							-- Include all items by default, can be filtered via keymaps
							return true
						end,
					},
				},
				sort = { "severity", "filename", "pos" },
				groups = {
					{ "filename", format = "{file_icon} {basename:Title} {count}" },
				},
				format = "{severity_icon} {pos} {message:md}",
			},
			
			-- Buffer-specific diagnostics
			buffer_diagnostics = {
				mode = "diagnostics",
				filter = { buf = 0 },
				sort = { "severity", "pos" },
				format = "{severity_icon} {pos} {message:md}",
			},
			
			-- LSP references with enhanced display
			lsp_references = {
				mode = "lsp_references",
				sections = {
					{
						name = "References",
						format = "{file_icon} {basename} {pos}",
						sort = { "filename", "pos" },
					},
				},
				format = "{file_icon} {basename} {pos} {text:md}",
				sort = { "filename", "pos" },
			},
			
			-- Enhanced symbols view for cloud security engineering
			symbols = {
				mode = "lsp_document_symbols",
				focus = false,
				win = { position = "right", size = 0.25 },
				filter = {
					-- Focus on important symbols for security engineering
					any = {
						ft = { "python", "go", "terraform", "yaml", "json" },
						kind = {
							"Class", "Constructor", "Enum", "Field", "Function", "Interface", 
							"Method", "Module", "Namespace", "Package", "Property", "Struct", 
							"Trait", "Variable", "Constant", "String", "Number", "Object"
						},
					},
				},
				format = "{kind_icon} {symbol.name:Normal}",
				sort = { "kind", "name" },
				groups = {
					{ "kind" },
				},
			},
			
			-- Enhanced quickfix with better formatting
			qflist = {
				mode = "qflist",
				sort = { "filename", "pos" },
				format = "{file_icon} {basename} {pos} {text:md}",
				groups = {
					{ "filename", format = "{file_icon} {basename:Title} {count}" },
				},
			},
			
			-- Enhanced location list
			loclist = {
				mode = "loclist", 
				sort = { "filename", "pos" },
				format = "{file_icon} {basename} {pos} {text:md}",
				groups = {
					{ "filename", format = "{file_icon} {basename:Title} {count}" },
				},
			},
			
			-- Custom mode for TODO comments integration
			todos = {
				mode = "todo",
				sort = { "pos" },
				format = "{tag} {pos} {text:md}",
				filter = {
					tag = { "TODO", "HACK", "WARN", "PERF", "NOTE", "TEST", "FIXME", "BUG", "SECURITY", "XXX" },
				},
				groups = {
					{ "tag", format = "{tag} {count}" },
				},
			},
		},
		
		-- Enhanced UI configuration with Catppuccin theme integration
		icons = {
			indent = {
				top = "│ ",
				middle = "├╴",
				last = "└╴",
				fold_open = " ",
				fold_closed = " ",
				ws = "  ",
			},
			folder_closed = " ",
			folder_open = " ",
			kinds = {
				Array = " ",
				Boolean = "󰨙 ",
				Class = " ",
				Constant = "󰏿 ",
				Constructor = " ",
				Enum = " ",
				EnumMember = " ",
				Event = " ",
				Field = " ",
				File = " ",
				Function = "󰊕 ",
				Interface = " ",
				Key = " ",
				Method = "󰊕 ",
				Module = " ",
				Namespace = "󰦮 ",
				Null = " ",
				Number = "󰎠 ",
				Object = " ",
				Operator = " ",
				Package = " ",
				Property = " ",
				String = " ",
				Struct = "󰆼 ",
				TypeParameter = " ",
				Variable = "󰀫 ",
				-- Cloud security specific icons
				Secret = "󰟵 ",
				Config = "󰒓 ",
				Resource = "󰅶 ",
				Policy = "󰒖 ",
			},
		},
		
		-- Enhanced window configuration
		win = {
			type = "split",
			relative = "editor",
			position = "bottom",
			size = 0.3,
			border = "rounded",
			title = "{mode} {count}",
			title_pos = "center",
			zindex = 200,
			-- Catppuccin-friendly styling
			style = "minimal",
			backdrop = 60,
		},
		
		-- Enhanced preview configuration
		preview = {
			type = "main",
			border = "rounded",
			title = "Preview",
			title_pos = "center",
			position = "right", 
			size = 0.4,
			zindex = 300,
		},
		
		-- Enhanced throttle and performance settings
		throttle = {
			refresh = 20, -- Refresh rate in ms
			update = 10,  -- Update rate in ms
			render = 10,  -- Render rate in ms
			follow = 10,  -- Follow cursor rate in ms
			preview = {
				ms = 100,   -- Preview update delay
				debounce = true,
			},
		},
		
		-- Enhanced follow configuration for better navigation
		follow = true,
		open_no_results = false,
		
		-- Enhanced auto-close behavior
		auto_close = false,
		auto_open = false,
		auto_preview = true,
		auto_fold = false,
		auto_jump = false,
		
		-- Enhanced focus management
		focus = false,
		restore = true,
		
		-- Cloud security engineering specific configuration
		keys = {
			["?"] = "help",
			r = "refresh",
			R = "toggle_refresh",
			q = "close",
			o = "jump_close",
			["<esc>"] = "cancel",
			["<cr>"] = "jump",
			["<2-leftmouse>"] = "jump",
			["<c-s>"] = "jump_split",
			["<c-v>"] = "jump_vsplit",
			-- Enhanced navigation for large lists
			["}"] = "next",
			["{"] = "prev", 
			["]]"] = "next_file",
			["[["] = "prev_file",
			-- Security-focused actions
			["zR"] = "fold_open_all",
			["zM"] = "fold_close_all",
			["za"] = "fold_toggle",
			["zo"] = "fold_open",
			["zc"] = "fold_close",
			-- Enhanced selection and filtering
			["<space>"] = "fold_toggle",
			["<tab>"] = "fold_toggle_enable_preview",
			["<s-tab>"] = "fold_toggle_disable_preview",
			-- Quick actions for cloud security workflows  
			i = "inspect",
			p = "preview",
			P = "toggle_preview",
			l = "fold_open",
			h = "fold_close",
			-- Custom security analysis shortcuts
			s = {
				function(trouble)
					-- Filter for security issues
					trouble.filter({ buf = 0 }, function(item)
						local message = item.message:lower()
						return message:match("security") or message:match("vulnerability")
					end)
				end,
				desc = "Filter security issues",
			},
			c = {
				function(trouble)
					-- Filter for configuration issues
					trouble.filter({ buf = 0 }, function(item)
						local message = item.message:lower()
						return message:match("config") or message:match("deprecated")
					end)
				end,
				desc = "Filter config issues",
			},
		},
		
		-- Enhanced multiline support for complex error messages
		multiline = true,
		max_items = 200,
		
		-- Enhanced pinning for important issues
		pinned = false,
		
		-- Enhanced warn_no_results message
		warn_no_results = true,
		
		-- Enhanced integration with other plugins
		signs = {
			error = "",
			warning = "",
			hint = "󰌶",
			information = "",
			other = "󰌵",
		},
		
		-- Cloud security engineering specific action groups
		action_groups = {
			security = {
				filter = function(item)
					local message = item.message:lower()
					return message:match("security") or 
						   message:match("vulnerability") or 
						   message:match("cve") or 
						   message:match("exploit")
				end,
				name = "Security Issues",
				icon = "󰒃",
			},
			compliance = {
				filter = function(item)
					local message = item.message:lower()
					return message:match("compliance") or 
						   message:match("policy") or 
						   message:match("standard") or 
						   message:match("regulation")
				end,
				name = "Compliance Issues", 
				icon = "󰒖",
			},
			performance = {
				filter = function(item)
					local message = item.message:lower()
					return message:match("performance") or 
						   message:match("slow") or 
						   message:match("memory") or 
						   message:match("cpu")
				end,
				name = "Performance Issues",
				icon = "󰓅",
			},
		},
	},
	
	config = function(_, opts)
		require("trouble").setup(opts)
		
		-- Enhanced integration with LSP diagnostics
		vim.api.nvim_create_autocmd("DiagnosticChanged", {
			group = vim.api.nvim_create_augroup("TroubleAutoRefresh", { clear = true }),
			callback = function()
				local trouble = require("trouble")
				if trouble.is_open() then
					trouble.refresh()
				end
			end,
		})
		
		-- Enhanced integration with quickfix updates
		vim.api.nvim_create_autocmd("QuickFixCmdPost", {
			group = vim.api.nvim_create_augroup("TroubleQuickfixRefresh", { clear = true }),
			callback = function()
				local trouble = require("trouble")
				if trouble.is_open("qflist") then
					trouble.refresh("qflist")
				end
			end,
		})
		
		-- Cloud security engineering specific highlights
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("TroubleHighlights", { clear = true }),
			callback = function()
				-- Enhanced highlights for better visibility with Catppuccin
				local colors = {
					TroubleError = { fg = "#f38ba8" }, -- Red for errors
					TroubleWarning = { fg = "#fab387" }, -- Orange for warnings  
					TroubleInformation = { fg = "#89b4fa" }, -- Blue for info
					TroubleHint = { fg = "#a6e3a1" }, -- Green for hints
					TroubleSource = { fg = "#cdd6f4" }, -- Light text
					TroubleCode = { fg = "#bac2de" }, -- Slightly darker text
					TroubleLocation = { fg = "#6c7086" }, -- Muted text
					TroubleNormal = { bg = "#181825" }, -- Dark background
					TroubleTextInformation = { fg = "#89b4fa" },
					TroubleSignInformation = { fg = "#89b4fa" },
					TroubleTextError = { fg = "#f38ba8" },
					TroubleSignError = { fg = "#f38ba8" },
					TroubleTextWarning = { fg = "#fab387" },
					TroubleSignWarning = { fg = "#fab387" },
					TroubleTextHint = { fg = "#a6e3a1" },
					TroubleSignHint = { fg = "#a6e3a1" },
					-- Custom security-focused highlights
					TroubleSecurity = { fg = "#f38ba8", bold = true }, -- Bold red for security
					TroubleCompliance = { fg = "#fab387", bold = true }, -- Bold orange for compliance
					TroublePerformance = { fg = "#f9e2af", bold = true }, -- Bold yellow for performance
				}
				
				for group, color in pairs(colors) do
					vim.api.nvim_set_hl(0, group, color)
				end
			end,
		})
		
		-- Enhanced telescope integration for finding issues
		if pcall(require, "telescope") then
			local telescope = require("telescope")
			local trouble = require("trouble.sources.telescope")
			
			telescope.setup({
				defaults = {
					mappings = {
						i = { ["<c-t>"] = trouble.open },
						n = { ["<c-t>"] = trouble.open },
					},
				},
			})
		end
		
		-- Enhanced todo-comments integration
		if pcall(require, "todo-comments") then
			vim.keymap.set("n", "<leader>xt", "<cmd>Trouble todos toggle<cr>", { desc = "TODOs (Trouble)" })
			vim.keymap.set("n", "<leader>xT", "<cmd>Trouble todos toggle filter={tag={TODO,FIXME,HACK}}<cr>", { desc = "TODOs/FIXME/HACK (Trouble)" })
		end
		
		-- Cloud security specific commands
		vim.api.nvim_create_user_command("TroubleSecurity", function()
			require("trouble").toggle({
				mode = "diagnostics",
				filter = {
					any = {
						buf = 0,
						function(item)
							local message = item.message:lower()
							return message:match("security") or 
								   message:match("vulnerability") or 
								   message:match("secret") or 
								   message:match("credential")
						end,
					},
				},
			})
		end, { desc = "Show security-related diagnostics" })
		
		vim.api.nvim_create_user_command("TroubleCompliance", function()
			require("trouble").toggle({
				mode = "diagnostics",
				filter = {
					any = {
						buf = 0, 
						function(item)
							local message = item.message:lower()
							return message:match("compliance") or 
								   message:match("policy") or 
								   message:match("deprecated") or 
								   message:match("lint")
						end,
					},
				},
			})
		end, { desc = "Show compliance-related diagnostics" })
		
		-- Enhanced status line integration
		local function trouble_status()
			if not package.loaded["trouble"] then
				return ""
			end
			
			local trouble = require("trouble")
			local symbols = {
				error = "",
				warn = "", 
				info = "",
				hint = "󰌶",
			}
			
			local counts = {}
			local items = trouble.get_items("diagnostics")
			
			for _, item in ipairs(items) do
				local severity = item.severity
				if severity == vim.diagnostic.severity.ERROR then
					counts.error = (counts.error or 0) + 1
				elseif severity == vim.diagnostic.severity.WARN then
					counts.warn = (counts.warn or 0) + 1
				elseif severity == vim.diagnostic.severity.INFO then
					counts.info = (counts.info or 0) + 1
				elseif severity == vim.diagnostic.severity.HINT then
					counts.hint = (counts.hint or 0) + 1
				end
			end
			
			local parts = {}
			for severity, count in pairs(counts) do
				if count > 0 then
					table.insert(parts, symbols[severity] .. count)
				end
			end
			
			return table.concat(parts, " ")
		end
		
		-- Make status function available globally
		_G.trouble_status = trouble_status
	end
}
