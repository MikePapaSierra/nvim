return {
	"rcarriga/nvim-notify",
	lazy = false, -- Load early for better integration
	priority = 1000, -- High priority to ensure early loading
	keys = {
		-- Enhanced notification management (VS Code style)
		{ "<leader>un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "󰅖 Dismiss all notifications" },
		{ "<leader>uN", function() require("notify").history() end, desc = "󰋚 Show notification history" },
		{ "<leader>nt", function() require("telescope").extensions.notify.notify() end, desc = "󰭎 Search notifications" },
		
		-- Security-focused notification filtering
		{ "<leader>ns", function() 
			require("notify").history({ filter = function(notif) 
				return string.find(notif.message:lower(), "security") or 
				       string.find(notif.message:lower(), "vulnerability") or
				       string.find(notif.message:lower(), "cve") or
				       string.find(notif.message:lower(), "secret")
			end })
		end, desc = "󰒃 Show security notifications" },
		
		{ "<leader>ne", function() 
			require("notify").history({ filter = function(notif) 
				return notif.level == vim.log.levels.ERROR 
			end })
		end, desc = "󰅚 Show error notifications" },
		
		{ "<leader>nw", function() 
			require("notify").history({ filter = function(notif) 
				return notif.level == vim.log.levels.WARN 
			end })
		end, desc = "󰀪 Show warning notifications" },
	},
	opts = {
		-- Professional notification styling
		background_colour = "NotifyBackground", -- Custom background for transparency
		fps = 60, -- Smooth animations for modern UX
		level = vim.log.levels.INFO, -- Show info and above
		minimum_width = 50,
		maximum_width = function()
			return math.floor(vim.o.columns * 0.4)
		end,
		maximum_height = function()
			return math.floor(vim.o.lines * 0.6)
		end,
		
		-- Enhanced icons for cloud security engineering
		icons = {
			DEBUG = "󰃤",
			ERROR = "󰅚",
			INFO = "󰋽",
			TRACE = "󰜥",
			WARN = "󰀪",
			
			-- Custom icons for different contexts
			SUCCESS = "󰄬",
			GIT = "󰊢",
			LSP = "󰅩",
			SECURITY = "󰒃",
			DOCKER = "󰡨",
			TERRAFORM = "󱁢",
			KUBERNETES = "󱃾",
			ANSIBLE = "󱂚",
		},
		
		-- Professional rendering
		render = "wrapped-compact", -- Better for longer messages
		stages = "fade_in_slide_out", -- Smooth animations
		timeout = 5000, -- Longer timeout for important messages
		top_down = true, -- Stack notifications top to bottom
		
		-- Enhanced time formatting
		time_formats = {
			notification = "%T",
			notification_history = "%FT%T",
		},
		
		-- Smart positioning and animations
		stages = "fade_in_slide_out", -- Use built-in smooth animations
	},
	
	config = function(_, opts)
		-- Setup notify with enhanced configuration
		require("notify").setup(opts)
		
		-- Set as the default notification handler
		vim.notify = require("notify")
		
		-- Enhanced notification functions for different contexts
		
		-- Security notification function
		_G.notify_security = function(message, level, title)
			vim.notify(message, level or vim.log.levels.WARN, {
				title = title or "󰒃 Security Alert",
				icon = "󰒃",
				timeout = 10000, -- Keep security messages longer
				keep = function() return true end, -- Don't auto-dismiss security notifications
			})
		end
		
		-- Success notification function
		_G.notify_success = function(message, title)
			vim.notify(message, vim.log.levels.INFO, {
				title = title or "󰄬 Success",
				icon = "󰄬",
				timeout = 3000,
			})
		end
		
		-- Git notification function
		_G.notify_git = function(message, level, title)
			vim.notify(message, level or vim.log.levels.INFO, {
				title = title or "󰊢 Git",
				icon = "󰊢",
				timeout = 4000,
			})
		end
		
		-- LSP notification function
		_G.notify_lsp = function(message, level, title)
			vim.notify(message, level or vim.log.levels.INFO, {
				title = title or "󰅩 LSP",
				icon = "󰅩",
				timeout = 3000,
			})
		end
		
		-- Docker notification function
		_G.notify_docker = function(message, level, title)
			vim.notify(message, level or vim.log.levels.INFO, {
				title = title or "󰡨 Docker",
				icon = "󰡨",
				timeout = 4000,
			})
		end
		
		-- Terraform notification function
		_G.notify_terraform = function(message, level, title)
			vim.notify(message, level or vim.log.levels.INFO, {
				title = title or "󱁢 Terraform",
				icon = "󱁢",
				timeout = 4000,
			})
		end
		
		-- Kubernetes notification function
		_G.notify_kubernetes = function(message, level, title)
			vim.notify(message, level or vim.log.levels.INFO, {
				title = title or "󱃾 Kubernetes",
				icon = "󱃾",
				timeout = 4000,
			})
		end
		
		-- Enhanced integration with telescope if available
		if pcall(require, "telescope") then
			require("telescope").load_extension("notify")
		end
		
		-- Custom highlight groups for Catppuccin integration
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = vim.api.nvim_create_augroup("NotifyHighlights", { clear = true }),
			callback = function()
				-- Catppuccin color integration
				local colors = {
					-- Base notification styles
					NotifyBackground = { bg = "#1e1e2e" }, -- Catppuccin base
					NotifyBorder = { fg = "#6c7086" }, -- Catppuccin overlay0
					NotifyTitle = { fg = "#cba6f7", bold = true }, -- Catppuccin mauve
					NotifyBody = { fg = "#cdd6f4" }, -- Catppuccin text
					
					-- Level-specific colors
					NotifyERRORBorder = { fg = "#f38ba8" }, -- Catppuccin red
					NotifyERRORIcon = { fg = "#f38ba8" },
					NotifyERRORTitle = { fg = "#f38ba8", bold = true },
					NotifyERRORBody = { fg = "#cdd6f4" },
					
					NotifyWARNBorder = { fg = "#fab387" }, -- Catppuccin peach
					NotifyWARNIcon = { fg = "#fab387" },
					NotifyWARNTitle = { fg = "#fab387", bold = true },
					NotifyWARNBody = { fg = "#cdd6f4" },
					
					NotifyINFOBorder = { fg = "#89b4fa" }, -- Catppuccin blue
					NotifyINFOIcon = { fg = "#89b4fa" },
					NotifyINFOTitle = { fg = "#89b4fa", bold = true },
					NotifyINFOBody = { fg = "#cdd6f4" },
					
					NotifyDEBUGBorder = { fg = "#6c7086" }, -- Catppuccin overlay0
					NotifyDEBUGIcon = { fg = "#6c7086" },
					NotifyDEBUGTitle = { fg = "#6c7086", bold = true },
					NotifyDEBUGBody = { fg = "#a6adc8" }, -- Catppuccin subtext0
					
					NotifyTRACEBorder = { fg = "#7f849c" }, -- Catppuccin overlay1
					NotifyTRACEIcon = { fg = "#7f849c" },
					NotifyTRACETitle = { fg = "#7f849c", bold = true },
					NotifyTRACEBody = { fg = "#a6adc8" },
					
					-- Security-specific highlighting
					NotifySECURITYBorder = { fg = "#f38ba8" }, -- Red for security
					NotifySECURITYIcon = { fg = "#f38ba8" },
					NotifySECURITYTitle = { fg = "#f38ba8", bold = true },
					NotifySECURITYBody = { fg = "#cdd6f4" },
					
					-- Success highlighting
					NotifySUCCESSBorder = { fg = "#a6e3a1" }, -- Green for success
					NotifySUCCESSIcon = { fg = "#a6e3a1" },
					NotifySUCCESSTitle = { fg = "#a6e3a1", bold = true },
					NotifySUCCESSBody = { fg = "#cdd6f4" },
					
					-- Git highlighting
					NotifyGITBorder = { fg = "#fab387" }, -- Peach for git
					NotifyGITIcon = { fg = "#fab387" },
					NotifyGITTitle = { fg = "#fab387", bold = true },
					NotifyGITBody = { fg = "#cdd6f4" },
					
					-- LSP highlighting
					NotifyLSPBorder = { fg = "#a6e3a1" }, -- Green for LSP
					NotifyLSPIcon = { fg = "#a6e3a1" },
					NotifyLSPTitle = { fg = "#a6e3a1", bold = true },
					NotifyLSPBody = { fg = "#cdd6f4" },
					
					-- Docker highlighting
					NotifyDOCKERBorder = { fg = "#89dceb" }, -- Sky for Docker
					NotifyDOCKERIcon = { fg = "#89dceb" },
					NotifyDOCKERTitle = { fg = "#89dceb", bold = true },
					NotifyDOCKERBody = { fg = "#cdd6f4" },
					
					-- Terraform highlighting
					NotifyTERRAFORMBorder = { fg = "#a6e3a1" }, -- Green for Terraform
					NotifyTERRAFORMIcon = { fg = "#a6e3a1" },
					NotifyTERRAFORMTitle = { fg = "#a6e3a1", bold = true },
					NotifyTERRAFORMBody = { fg = "#cdd6f4" },
					
					-- Kubernetes highlighting
					NotifyKUBERNETESBorder = { fg = "#89b4fa" }, -- Blue for Kubernetes
					NotifyKUBERNETESIcon = { fg = "#89b4fa" },
					NotifyKUBERNETESTitle = { fg = "#89b4fa", bold = true },
					NotifyKUBERNETESBody = { fg = "#cdd6f4" },
				}
				
				for group, color in pairs(colors) do
					vim.api.nvim_set_hl(0, group, color)
				end
			end,
		})
		
		-- Auto-dismiss less important notifications after timeout
		vim.api.nvim_create_autocmd("VimEnter", {
			group = vim.api.nvim_create_augroup("NotifyAutoDismiss", { clear = true }),
			callback = function()
				-- Auto-dismiss debug and trace messages
				local timer = vim.loop.new_timer()
				timer:start(30000, 30000, vim.schedule_wrap(function()
					require("notify").dismiss({
						silent = true,
						pending = false,
						filter = function(notif)
							return notif.level == vim.log.levels.DEBUG or notif.level == vim.log.levels.TRACE
						end,
					})
				end))
			end,
		})
		
		-- User commands for enhanced functionality
		vim.api.nvim_create_user_command("NotifyConfig", function()
			vim.cmd("edit " .. vim.fn.stdpath("config") .. "/lua/plugins/notify.lua")
		end, { desc = "Edit Notify configuration" })
		
		vim.api.nvim_create_user_command("NotifyTest", function()
			vim.notify("This is a test notification", vim.log.levels.INFO, { title = "󰋽 Test" })
			vim.notify("This is a warning", vim.log.levels.WARN, { title = "󰀪 Warning" })
			vim.notify("This is an error", vim.log.levels.ERROR, { title = "󰅚 Error" })
			_G.notify_security("This is a security alert", vim.log.levels.WARN)
			_G.notify_success("Operation completed successfully")
		end, { desc = "Test notification styles" })
		
		vim.api.nvim_create_user_command("NotifyClear", function()
			require("notify").dismiss({ silent = true, pending = true })
		end, { desc = "Clear all notifications" })
		
		vim.api.nvim_create_user_command("NotifyHistory", function()
			require("notify").history()
		end, { desc = "Show notification history" })
		
		-- Security-focused commands
		vim.api.nvim_create_user_command("NotifySecurity", function(opts)
			_G.notify_security(opts.args or "Security check completed", vim.log.levels.WARN)
		end, { 
			nargs = "?", 
			desc = "Send security notification",
		})
		
		vim.api.nvim_create_user_command("NotifyGit", function(opts)
			_G.notify_git(opts.args or "Git operation completed", vim.log.levels.INFO)
		end, { 
			nargs = "?", 
			desc = "Send git notification",
		})
		
		vim.api.nvim_create_user_command("NotifyDocker", function(opts)
			_G.notify_docker(opts.args or "Docker operation completed", vim.log.levels.INFO)
		end, { 
			nargs = "?", 
			desc = "Send docker notification",
		})
		
		vim.api.nvim_create_user_command("NotifyTerraform", function(opts)
			_G.notify_terraform(opts.args or "Terraform operation completed", vim.log.levels.INFO)
		end, { 
			nargs = "?", 
			desc = "Send terraform notification",
		})
		
		-- Integration with other plugins
		-- LSP progress integration
		if pcall(require, "lsp-progress") then
			vim.api.nvim_create_autocmd("User", {
				group = vim.api.nvim_create_augroup("NotifyLSPProgress", { clear = true }),
				pattern = "LspProgressStatusUpdated",
				callback = function()
					local progress = require("lsp-progress").progress()
					if progress and progress ~= "" then
						_G.notify_lsp(progress, vim.log.levels.INFO, "󰅩 LSP Progress")
					end
				end,
			})
		end
		
		-- Git integration notifications
		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("NotifyGitEvents", { clear = true }),
			pattern = { "GitSignsUpdate", "GitCommit", "GitPush", "GitPull" },
			callback = function(event)
				local messages = {
					GitSignsUpdate = "Git signs updated",
					GitCommit = "Git commit created",
					GitPush = "Git push completed",
					GitPull = "Git pull completed",
				}
				if messages[event.match] then
					_G.notify_git(messages[event.match], vim.log.levels.INFO)
				end
			end,
		})
	end,
}
