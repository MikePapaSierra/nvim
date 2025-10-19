-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Enhanced Debugging Configuration for Cloud Security Engineering            │
-- │ Professional debugging setup with multi-language support and UI           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
	-- Core Debug Adapter Protocol
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio", -- Async I/O for Neovim
			"rcarriga/nvim-dap-ui", -- Enhanced debugging UI
			"theHamsta/nvim-dap-virtual-text", -- Virtual text for variables
			"nvim-telescope/telescope-dap.nvim", -- Telescope integration
		},
		event = "VeryLazy",
		
		keys = {
			-- Essential Debugging Controls
			{ "<F5>", function() require("dap").continue() end, desc = "󰐊 Debug: Continue" },
			{ "<F10>", function() require("dap").step_over() end, desc = "󰆹 Debug: Step Over" },
			{ "<F11>", function() require("dap").step_into() end, desc = "󰆹 Debug: Step Into" },
			{ "<F12>", function() require("dap").step_out() end, desc = "󰆹 Debug: Step Out" },
			
			-- Breakpoint Management
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "󰏃 Debug: Toggle Breakpoint" },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "󰏃 Debug: Conditional Breakpoint" },
			{ "<leader>dlp", function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, desc = "󰏃 Debug: Log Point" },
			{ "<leader>dcb", function() require("dap").clear_breakpoints() end, desc = "󰆴 Debug: Clear All Breakpoints" },
			
			-- Session Control
			{ "<leader>dc", function() require("dap").continue() end, desc = "󰐊 Debug: Continue" },
			{ "<leader>dC", function() require("dap").run_to_cursor() end, desc = "󰐊 Debug: Run to Cursor" },
			{ "<leader>ds", function() require("dap").terminate() end, desc = "󰓛 Debug: Stop/Terminate" },
			{ "<leader>dr", function() require("dap").restart() end, desc = "󰜉 Debug: Restart" },
			{ "<leader>dp", function() require("dap").pause() end, desc = "󰏤 Debug: Pause" },
			
			-- UI & Navigation
			{ "<leader>du", function() require("dapui").toggle() end, desc = "󰕷 Debug: Toggle UI" },
			{ "<leader>dw", function() require("dapui").float_element("watches", { enter = true }) end, desc = "󰂖 Debug: Watches" },
			{ "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "󰋼 Debug: Hover" },
			{ "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "󰆼 Debug: Evaluate Expression" },
			
			-- Telescope Integration
			{ "<leader>dtb", function() require("telescope").extensions.dap.list_breakpoints() end, desc = "󰺮 Debug: List Breakpoints" },
			{ "<leader>dtv", function() require("telescope").extensions.dap.variables() end, desc = "󰺮 Debug: Variables" },
			{ "<leader>dtf", function() require("telescope").extensions.dap.frames() end, desc = "󰺮 Debug: Frames" },
		},
		
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			
			-- Enhanced DAP UI Configuration
			dapui.setup({
				icons = { 
					expanded = "▾", 
					collapsed = "▸", 
					current_frame = "▶" 
				},
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 0.25,
						position = "bottom",
					},
				},
			})
			
			-- Virtual Text Configuration
			require("nvim-dap-virtual-text").setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = false,
				show_stop_reason = true,
				commented = false,
			})
			
			-- Telescope DAP Extension
			require("telescope").load_extension("dap")
			
			-- Enhanced Signs and Appearance
			local sign = vim.fn.sign_define
			sign("DapBreakpoint", { 
				text = "🔴", 
				texthl = "DiagnosticError", 
				linehl = "DapBreakpointLine", 
				numhl = "DapBreakpointNumber" 
			})
			sign("DapBreakpointCondition", { 
				text = "🟡", 
				texthl = "DiagnosticWarn", 
				linehl = "DapBreakpointLine", 
				numhl = "DapBreakpointNumber" 
			})
			sign("DapLogPoint", { 
				text = "🔵", 
				texthl = "DiagnosticInfo", 
				linehl = "DapLogPointLine", 
				numhl = "DapLogPointNumber" 
			})
			sign("DapStopped", { 
				text = "▶️", 
				texthl = "DiagnosticOk", 
				linehl = "DapStoppedLine", 
				numhl = "DapStoppedNumber" 
			})
			
			-- Auto UI Management
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
	
	-- Language-specific debuggers
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-go").setup()
		end,
		keys = {
			{ "<leader>dgt", function() require("dap-go").debug_test() end, desc = "󰃤 Debug Go Test", ft = "go" },
			{ "<leader>dgl", function() require("dap-go").debug_last_test() end, desc = "󰃤 Debug Last Go Test", ft = "go" },
		},
	},
	
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-python").setup("python")
		end,
		keys = {
			{ "<leader>dpt", function() require("dap-python").test_method() end, desc = "󰃤 Debug Python Test Method", ft = "python" },
			{ "<leader>dpc", function() require("dap-python").test_class() end, desc = "󰃤 Debug Python Test Class", ft = "python" },
		},
	},
	
	-- Mason integration for debuggers
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"python",
					"delve", -- Go debugger
					"codelldb", -- C/C++/Rust
				},
				automatic_installation = true,
			})
		end,
	},
}
