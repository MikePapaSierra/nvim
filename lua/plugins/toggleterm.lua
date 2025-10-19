return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		event = "VeryLazy",
		cmd = { "ToggleTerm", "TermExec", "TermSelect" },
		dependencies = {
			"nvim-lua/plenary.nvim", -- For enhanced terminal utilities
		},
		keys = {
			-- VS Code-style terminal shortcuts (primary)
			{ "<C-`>", function() require("toggleterm").toggle(1, nil, nil, "horizontal") end, desc = "Toggle bottom terminal (VS Code style)", mode = { "n", "t", "i" } },
			{ "<C-\\>", function() require("toggleterm").toggle(1, nil, nil, "horizontal") end, desc = "Toggle bottom terminal (Alt)", mode = { "n", "t", "i" } },
			{ "<C-S-`>", function() _G.vscode_terminal_new() end, desc = "New terminal instance", mode = { "n", "t", "i" } },
			
			-- Enhanced terminal management
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal (default)" },
			{ "<leader>tn", function() _G.vscode_terminal_new() end, desc = "New terminal" },
			{ "<leader>tk", function() _G.vscode_terminal_kill() end, desc = "Kill terminal" },
			{ "<leader>tr", function() _G.vscode_terminal_rename() end, desc = "Rename terminal" },
			{ "<leader>ts", "<cmd>TermSelect<cr>", desc = "Select terminal" },
			
			-- Direction-specific terminals
			{ "<leader>tb", function() require("toggleterm").toggle(nil, 15, nil, "horizontal") end, desc = "Terminal bottom" },
			{ "<leader>tf", function() require("toggleterm").toggle(nil, nil, nil, "float") end, desc = "Terminal float" },
			{ "<leader>tv", function() require("toggleterm").toggle(nil, 80, nil, "vertical") end, desc = "Terminal vertical" },
			{ "<leader>tT", function() require("toggleterm").toggle(nil, nil, nil, "tab") end, desc = "Terminal tab" },
			
			-- Multiple terminal instances (VS Code style)
			{ "<leader>t1", function() require("toggleterm").toggle(1, nil, nil, "horizontal") end, desc = "Terminal 1" },
			{ "<leader>t2", function() require("toggleterm").toggle(2, nil, nil, "horizontal") end, desc = "Terminal 2" },
			{ "<leader>t3", function() require("toggleterm").toggle(3, nil, nil, "horizontal") end, desc = "Terminal 3" },
			{ "<leader>t4", function() require("toggleterm").toggle(4, nil, nil, "horizontal") end, desc = "Terminal 4" },
			
			-- Send code to terminal (REPL style)
			{ "<leader>sl", function() _G.send_line_to_terminal() end, desc = "Send line to terminal" },
			{ "<leader>sp", function() _G.send_paragraph_to_terminal() end, desc = "Send paragraph to terminal" },
			{ "<leader>ss", function() _G.send_selection_to_terminal() end, desc = "Send selection to terminal", mode = "v" },
			{ "<leader>sf", function() _G.send_file_to_terminal() end, desc = "Send file to terminal" },
			
			-- Cloud security engineering terminals
			{ "<leader>gg", function() _G.terminal_lazygit() end, desc = "LazyGit" },
			{ "<leader>tp", function() _G.terminal_python() end, desc = "Python REPL" },
			{ "<leader>tg", function() _G.terminal_go() end, desc = "Go REPL" },
			{ "<leader>td", function() _G.terminal_docker() end, desc = "Docker CLI" },
			{ "<leader>tc", function() _G.terminal_kubectl() end, desc = "Kubectl CLI" },
			{ "<leader>ta", function() _G.terminal_aws() end, desc = "AWS CLI" },
			{ "<leader>tm", function() _G.terminal_htop() end, desc = "System monitor" },
			{ "<leader>tl", function() _G.terminal_logs() end, desc = "Log viewer" },
			
			-- Terminal navigation (in terminal mode)
			{ "<C-h>", [[<Cmd>wincmd h<CR>]], desc = "Go to left window", mode = "t" },
			{ "<C-j>", [[<Cmd>wincmd j<CR>]], desc = "Go to down window", mode = "t" },
			{ "<C-k>", [[<Cmd>wincmd k<CR>]], desc = "Go to up window", mode = "t" },
			{ "<C-l>", [[<Cmd>wincmd l<CR>]], desc = "Go to right window", mode = "t" },
			{ "<esc>", [[<C-\><C-n>]], desc = "Exit terminal mode", mode = "t" },
		},
		opts = {
			-- VS Code-like terminal configuration
			size = function(term)
				if term.direction == "horizontal" then
					return math.max(15, math.min(30, math.floor(vim.o.lines * 0.3)))
				elseif term.direction == "vertical" then
					return math.max(80, math.floor(vim.o.columns * 0.4))
				end
			end,
			
			-- Enhanced open mapping for VS Code experience
			open_mapping = [[<C-`>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = "horizontal", -- Default to bottom like VS Code
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
			
			-- Enhanced float configuration
			float_opts = {
				border = "rounded",
				width = function()
					return math.min(120, math.floor(vim.o.columns * 0.85))
				end,
				height = function()
					return math.min(40, math.floor(vim.o.lines * 0.8))
				end,
				winblend = 0,
				zindex = 1000,
				title_pos = "center",
				highlights = {
					border = "FloatBorder",
					background = "NormalFloat",
				},
			},
			
			-- Enhanced winbar for terminal identification
			winbar = {
				enabled = true,
				name_formatter = function(term)
					local name = term.display_name or ("Terminal " .. term.id)
					local cmd = term.cmd and (" (" .. term.cmd .. ")") or ""
					return " 󰆍 " .. name .. cmd
				end
			},
			
			-- VS Code-like terminal behavior
			on_create = function(term)
				-- Set up VS Code-like terminal environment
				vim.cmd("setlocal nonumber norelativenumber signcolumn=no")
				
				-- Enhanced terminal-specific options
				vim.api.nvim_buf_set_option(term.bufnr, "filetype", "terminal")
				vim.api.nvim_buf_set_option(term.bufnr, "buflisted", false)
				
				-- Set terminal-specific highlights
				vim.api.nvim_win_set_option(term.window, "winhighlight", "Normal:TerminalNormal,FloatBorder:TerminalBorder")
				
				-- Cloud security engineering environment setup
				if term.cmd == nil or term.cmd == vim.o.shell then
					-- Set up environment for cloud security work
					vim.fn.chansend(term.job_id, {
						"export EDITOR=nvim\n",
						"export PAGER=less\n",
						"export TERM=xterm-256color\n",
						"alias ll='ls -la'\n",
						"alias la='ls -A'\n",
						"alias l='ls -CF'\n",
						"alias k='kubectl'\n",
						"alias d='docker'\n",
						"alias dc='docker-compose'\n",
						"alias tf='terraform'\n",
						"alias tg='terragrunt'\n",
					})
				end
			end,
			
			on_open = function(term)
				vim.cmd("startinsert!")
				-- Focus the terminal window
				vim.api.nvim_set_current_win(term.window)
			end,
			
			on_close = function(term)
				-- Return to normal mode and previous window
				vim.cmd("stopinsert")
			end,
		},
		
		config = function(_, opts)
			require("toggleterm").setup(opts)
			
			-- Enhanced terminal management for VS Code-like experience
			local Terminal = require("toggleterm.terminal").Terminal
			local terminals = {}
			local terminal_count = 0
			
			-- VS Code-style terminal creation
			function _G.vscode_terminal_new()
				terminal_count = terminal_count + 1
				local term = Terminal:new({
					id = terminal_count,
					direction = "horizontal",
					size = 15,
					display_name = "Terminal " .. terminal_count,
					on_open = function(t)
						vim.cmd("startinsert!")
						vim.api.nvim_set_current_win(t.window)
					end,
				})
				terminals[terminal_count] = term
				term:toggle()
				return term
			end
			
			-- VS Code-style terminal killing
			function _G.vscode_terminal_kill()
				local current_term_id = vim.b.toggle_number
				if current_term_id and terminals[current_term_id] then
					terminals[current_term_id]:close()
					terminals[current_term_id] = nil
				else
					-- If no specific terminal, get user input
					vim.ui.input({ prompt = "Terminal ID to kill: " }, function(input)
						local id = tonumber(input)
						if id and terminals[id] then
							terminals[id]:close()
							terminals[id] = nil
						end
					end)
				end
			end
			
			-- VS Code-style terminal renaming
			function _G.vscode_terminal_rename()
				local current_term_id = vim.b.toggle_number
				if current_term_id and terminals[current_term_id] then
					vim.ui.input({ 
						prompt = "New terminal name: ",
						default = terminals[current_term_id].display_name 
					}, function(input)
						if input then
							terminals[current_term_id].display_name = input
						end
					end)
				end
			end
			
			-- Enhanced code sending functions
			function _G.send_line_to_terminal()
				local line = vim.api.nvim_get_current_line()
				require("toggleterm").send_lines_to_terminal("single_line", true, { line })
			end
			
			function _G.send_paragraph_to_terminal()
				local start_line = vim.fn.line(".")
				local end_line = start_line
				
				-- Find paragraph boundaries
				while start_line > 1 and vim.api.nvim_buf_get_lines(0, start_line - 2, start_line - 1, false)[1] ~= "" do
					start_line = start_line - 1
				end
				
				while end_line < vim.fn.line("$") and vim.api.nvim_buf_get_lines(0, end_line, end_line + 1, false)[1] ~= "" do
					end_line = end_line + 1
				end
				
				local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
				require("toggleterm").send_lines_to_terminal("visual_lines", true, lines)
			end
			
			function _G.send_selection_to_terminal()
				require("toggleterm").send_lines_to_terminal("visual_selection", true, {})
			end
			
			function _G.send_file_to_terminal()
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				require("toggleterm").send_lines_to_terminal("visual_lines", true, lines)
			end
			
			-- Cloud security engineering specialized terminals
			
			-- LazyGit with enhanced configuration
			local lazygit = Terminal:new({
				cmd = "lazygit",
				dir = "git_dir",
				direction = "float",
				display_name = "LazyGit",
				float_opts = {
					border = "rounded",
					width = function() return math.floor(vim.o.columns * 0.95) end,
					height = function() return math.floor(vim.o.lines * 0.95) end,
					title = " 󰊢 LazyGit ",
				},
				on_open = function(term)
					vim.cmd("startinsert!")
					-- LazyGit specific keymaps
					vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-c>", "<cmd>close<CR>", { noremap = true, silent = true })
				end,
			})
			
			function _G.terminal_lazygit()
				lazygit:toggle()
			end
			
			-- Python REPL with enhanced features
			local python_repl = Terminal:new({
				cmd = "python3 -i",
				direction = "float",
				display_name = "Python REPL",
				float_opts = {
					border = "rounded",
					title = " 󰌠 Python REPL ",
				},
				on_create = function(term)
					-- Set up Python environment
					vim.fn.chansend(term.job_id, {
						"import os, sys, json, requests\n",
						"import pandas as pd\n",
						"import numpy as np\n",
						"print('Python environment ready for cloud security work!')\n"
					})
				end,
			})
			
			function _G.terminal_python()
				python_repl:toggle()
			end
			
			-- Go REPL
			local go_repl = Terminal:new({
				cmd = "gore", -- Go REPL (install with: go install github.com/x-motemen/gore/cmd/gore@latest)
				direction = "float",
				display_name = "Go REPL",
				float_opts = {
					border = "rounded",
					title = " 󰟓 Go REPL ",
				},
			})
			
			function _G.terminal_go()
				go_repl:toggle()
			end
			
			-- Docker CLI with enhanced setup
			local docker_cli = Terminal:new({
				cmd = vim.o.shell,
				direction = "horizontal",
				display_name = "Docker CLI",
				size = 15,
				on_create = function(term)
					vim.fn.chansend(term.job_id, {
						"echo 'Docker CLI Ready!'\n",
						"alias d='docker'\n",
						"alias dc='docker-compose'\n",
						"alias dps='docker ps'\n",
						"alias dpa='docker ps -a'\n",
						"alias di='docker images'\n",
						"docker --version\n",
						"docker-compose --version\n",
					})
				end,
			})
			
			function _G.terminal_docker()
				docker_cli:toggle()
			end
			
			-- Kubectl CLI
			local kubectl_cli = Terminal:new({
				cmd = vim.o.shell,
				direction = "horizontal", 
				display_name = "Kubectl CLI",
				size = 15,
				on_create = function(term)
					vim.fn.chansend(term.job_id, {
						"echo 'Kubernetes CLI Ready!'\n",
						"alias k='kubectl'\n",
						"alias kg='kubectl get'\n",
						"alias kd='kubectl describe'\n",
						"alias ka='kubectl apply'\n",
						"alias kl='kubectl logs'\n",
						"kubectl version --client\n",
						"kubectl config current-context\n",
					})
				end,
			})
			
			function _G.terminal_kubectl()
				kubectl_cli:toggle()
			end
			
			-- AWS CLI
			local aws_cli = Terminal:new({
				cmd = vim.o.shell,
				direction = "horizontal",
				display_name = "AWS CLI",
				size = 15,
				on_create = function(term)
					vim.fn.chansend(term.job_id, {
						"echo 'AWS CLI Ready!'\n",
						"aws --version\n",
						"aws sts get-caller-identity\n",
						"echo 'Current AWS Profile:' $(aws configure list-profiles | head -1)\n",
					})
				end,
			})
			
			function _G.terminal_aws()
				aws_cli:toggle()
			end
			
			-- System monitor (htop/btop)
			local system_monitor = Terminal:new({
				cmd = vim.fn.executable("btop") == 1 and "btop" or "htop",
				direction = "float",
				display_name = "System Monitor",
				float_opts = {
					border = "rounded",
					width = function() return math.floor(vim.o.columns * 0.9) end,
					height = function() return math.floor(vim.o.lines * 0.9) end,
					title = " 󰍛 System Monitor ",
				},
				on_open = function(term)
					vim.api.nvim_buf_set_keymap(term.bufnr, "t", "q", "<cmd>close<CR>", { noremap = true, silent = true })
				end,
			})
			
			function _G.terminal_htop()
				system_monitor:toggle()
			end
			
			-- Log viewer with tail
			local log_viewer = Terminal:new({
				cmd = vim.o.shell,
				direction = "horizontal",
				display_name = "Log Viewer",
				size = 20,
				on_create = function(term)
					vim.fn.chansend(term.job_id, {
						"echo 'Log Viewer Ready! Use: tail -f /path/to/logfile'\n",
						"echo 'Or: journalctl -f for systemd logs'\n",
						"echo 'Or: kubectl logs -f pod-name for k8s logs'\n",
					})
				end,
			})
			
			function _G.terminal_logs()
				log_viewer:toggle()
			end
			
			-- Enhanced terminal keymaps for better VS Code experience
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0, noremap = true, silent = true }
				
				-- VS Code-like terminal navigation
				vim.keymap.set("t", "<C-`>", [[<Cmd>ToggleTerm<CR>]], opts)
				vim.keymap.set("t", "<C-\\>", [[<Cmd>ToggleTerm<CR>]], opts)
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				
				-- Window navigation
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
				
				-- Terminal management
				vim.keymap.set("t", "<C-S-`>", function() _G.vscode_terminal_new() end, opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
				
				-- Quick commands
				vim.keymap.set("t", "<C-c>", "<C-c>", opts)
				vim.keymap.set("t", "<C-d>", "<C-d>", opts)
				vim.keymap.set("t", "<C-z>", "<C-z>", opts)
			end
			
			-- Apply terminal keymaps on terminal open
			vim.api.nvim_create_autocmd("TermOpen", {
				group = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true }),
				pattern = "term://*",
				callback = function()
					_G.set_terminal_keymaps()
				end,
			})
			
			-- Enhanced terminal highlights for Catppuccin theme
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = vim.api.nvim_create_augroup("ToggleTermHighlights", { clear = true }),
				callback = function()
					local colors = {
						TerminalNormal = { bg = "#1e1e2e" }, -- Catppuccin base
						TerminalBorder = { fg = "#89b4fa" }, -- Catppuccin blue
						ToggleTermNormal = { bg = "#1e1e2e" },
						ToggleTermBorder = { fg = "#89b4fa" },
					}
					
					for group, color in pairs(colors) do
						vim.api.nvim_set_hl(0, group, color)
					end
				end,
			})
			
			-- VS Code-style terminal status line integration
			function _G.get_terminal_status()
				local terms = require("toggleterm.terminal").get_all()
				local active_terms = {}
				
				for _, term in pairs(terms) do
					if term:is_open() then
						table.insert(active_terms, {
							id = term.id,
							name = term.display_name or ("Term " .. term.id),
							dir = term.direction,
						})
					end
				end
				
				if #active_terms == 0 then
					return ""
				end
				
				local status_parts = {}
				for _, term in ipairs(active_terms) do
					table.insert(status_parts, "󰆍" .. term.name)
				end
				
				return table.concat(status_parts, " ")
			end
			
			-- User commands for terminal management
			vim.api.nvim_create_user_command("TerminalNew", function()
				_G.vscode_terminal_new()
			end, { desc = "Create new terminal" })
			
			vim.api.nvim_create_user_command("TerminalKill", function()
				_G.vscode_terminal_kill()
			end, { desc = "Kill current terminal" })
			
			vim.api.nvim_create_user_command("TerminalRename", function()
				_G.vscode_terminal_rename()
			end, { desc = "Rename current terminal" })
			
			vim.api.nvim_create_user_command("TerminalList", function()
				local terms = require("toggleterm.terminal").get_all()
				local lines = { "Active Terminals:" }
				
				for _, term in pairs(terms) do
					if term:is_open() then
						table.insert(lines, string.format("  %d: %s (%s)", 
							term.id, 
							term.display_name or "Terminal", 
							term.direction
						))
					end
				end
				
				if #lines == 1 then
					table.insert(lines, "  No active terminals")
				end
				
				vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "ToggleTerm" })
			end, { desc = "List all terminals" })
			
			-- Security-focused terminal shortcuts
			vim.api.nvim_create_user_command("SecurityScan", function()
				local scanner = Terminal:new({
					cmd = "trivy fs .",
					direction = "horizontal",
					display_name = "Security Scanner",
					size = 20,
					close_on_exit = false,
				})
				scanner:toggle()
			end, { desc = "Run security scan with Trivy" })
			
			vim.api.nvim_create_user_command("VulnCheck", function()
				local vuln_check = Terminal:new({
					cmd = "govulncheck ./...",
					direction = "horizontal", 
					display_name = "Vulnerability Check",
					size = 20,
					close_on_exit = false,
				})
				vuln_check:toggle()
			end, { desc = "Run Go vulnerability check" })
		end,
	}
}
