return {
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
		event = { "BufReadPost", "BufNewFile", "BufWritePost" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"folke/trouble.nvim",
		},
		keys = {
			-- Enhanced todo navigation and search
			{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "󰗀 Find todos (all)" },
			{ "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME,SECURITY,VULN<cr>", desc = "󰨮 Find todos (critical)" },
			{ "<leader>fs", "<cmd>TodoTelescope keywords=SECURITY,VULN,CVE,AUDIT<cr>", desc = "󰒃 Find security todos" },
			{ "<leader>fb", "<cmd>TodoTelescope keywords=BUG,FIX,FIXME,ISSUE<cr>", desc = "󰃤 Find bugs/fixes" },
			{ "<leader>fn", "<cmd>TodoTelescope keywords=NOTE,INFO,DOCS<cr>", desc = "󰍔 Find notes/docs" },
			{ "<leader>fp", "<cmd>TodoTelescope keywords=PERF,OPTIMIZE,PERFORMANCE<cr>", desc = "󰓅 Find performance" },
			
			-- Trouble integration for todo management
			{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "󰗀 Todo (Trouble)" },
			{ "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIXME,FIX}}<cr>", desc = "󰨮 Todo/Fix (Trouble)" },
			{ "<leader>xs", "<cmd>Trouble todo toggle filter = {tag = {SECURITY,VULN,CVE}}<cr>", desc = "󰒃 Security (Trouble)" },
			
			-- Enhanced navigation with context
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
			{ "]T", function() require("todo-comments").jump_next({keywords = {"ERROR", "FIX", "FIXME", "BUG", "SECURITY", "VULN"}}) end, desc = "Next error/fix todo" },
			{ "[T", function() require("todo-comments").jump_prev({keywords = {"ERROR", "FIX", "FIXME", "BUG", "SECURITY", "VULN"}}) end, desc = "Previous error/fix todo" },
			
			-- Quick todo insertion (VS Code style)
			{ "<leader>it", function() _G.insert_todo_comment("TODO") end, desc = "Insert TODO", mode = {"n", "i"} },
			{ "<leader>if", function() _G.insert_todo_comment("FIXME") end, desc = "Insert FIXME", mode = {"n", "i"} },
			{ "<leader>is", function() _G.insert_todo_comment("SECURITY") end, desc = "Insert SECURITY", mode = {"n", "i"} },
			{ "<leader>in", function() _G.insert_todo_comment("NOTE") end, desc = "Insert NOTE", mode = {"n", "i"} },
			{ "<leader>ip", function() _G.insert_todo_comment("PERF") end, desc = "Insert PERF", mode = {"n", "i"} },
			
			-- Todo management
			{ "<leader>tc", function() _G.create_todo_from_selection() end, desc = "Create todo from selection", mode = "v" },
			{ "<leader>tr", function() _G.resolve_todo_comment() end, desc = "Resolve todo comment" },
			{ "<leader>ta", function() _G.add_todo_assignee() end, desc = "Add todo assignee" },
			{ "<leader>td", function() _G.add_todo_deadline() end, desc = "Add todo deadline" },
		},
		opts = {
			signs = true,
			sign_priority = 8,
			
			-- Enhanced keywords for cloud security engineering
			keywords = {
				-- Critical issues
				FIX = {
					icon = "󰃤",
					color = "error",
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "BROKEN" },
				},
				ERROR = {
					icon = "󰅚",
					color = "error",
					alt = { "ERR", "FAIL", "FAILURE" },
				},
				
				-- Security-focused keywords
				SECURITY = {
					icon = "󰒃",
					color = "security",
					alt = { "SEC", "SECURE", "AUTH", "AUTHZ", "AUDIT" },
				},
				VULN = {
					icon = "󰈻",
					color = "vulnerability",
					alt = { "VULNERABILITY", "CVE", "EXPLOIT", "WEAKNESS" },
				},
				COMPLIANCE = {
					icon = "󰈸",
					color = "compliance",
					alt = { "GDPR", "HIPAA", "SOC2", "ISO27001", "REGULATION" },
				},
				
				-- Development workflow
				TODO = {
					icon = "󰗀",
					color = "info",
					alt = { "TO-DO", "TASK" },
				},
				HACK = {
					icon = "󰈸",
					color = "warning",
					alt = { "TEMPORARY", "WORKAROUND" },
				},
				WARN = {
					icon = "󰀪",
					color = "warning",
					alt = { "WARNING", "XXX", "CAUTION" },
				},
				
				-- Performance and optimization
				PERF = {
					icon = "󰓅",
					color = "performance",
					alt = { "PERFORMANCE", "OPTIMIZE", "OPTIMIZATION", "SPEED", "SLOW" },
				},
				MEMORY = {
					icon = "󰍛",
					color = "performance",
					alt = { "MEM", "LEAK", "ALLOCATION", "GC" },
				},
				
				-- Documentation and notes
				NOTE = {
					icon = "󰍔",
					color = "hint",
					alt = { "INFO", "EXPLAIN", "CLARIFY" },
				},
				DOCS = {
					icon = "󰈙",
					color = "hint",
					alt = { "DOCUMENTATION", "DOC", "README" },
				},
				
				-- Testing and validation
				TEST = {
					icon = "󰙨",
					color = "test",
					alt = { "TESTING", "SPEC", "CASE", "VERIFY" },
				},
				REVIEW = {
					icon = "󰓕",
					color = "review",
					alt = { "PEER-REVIEW", "CHECK", "VALIDATE" },
				},
				
				-- Cloud and infrastructure
				CLOUD = {
					icon = "󰅟",
					color = "cloud",
					alt = { "AWS", "GCP", "AZURE", "K8S", "KUBERNETES" },
				},
				DEPLOY = {
					icon = "󰊄",
					color = "deployment",
					alt = { "DEPLOYMENT", "CI", "CD", "PIPELINE" },
				},
				CONFIG = {
					icon = "󰒓",
					color = "config",
					alt = { "CONFIGURATION", "SETTINGS", "ENV" },
				},
				
				-- Dependencies and external
				DEPS = {
					icon = "󰏖",
					color = "dependencies",
					alt = { "DEPENDENCY", "DEPENDENCIES", "PACKAGE", "LIB" },
				},
				API = {
					icon = "󰿘",
					color = "api",
					alt = { "ENDPOINT", "REST", "GRAPHQL", "RPC" },
				},
			},
			
			gui_style = {
				fg = "NONE",
				bg = "BOLD",
			},
			merge_keywords = true,
			
			-- Standard highlighting configuration
			highlight = {
				multiline = true,
				multiline_pattern = "^.",
				multiline_context = 10,
				before = "",
				keyword = "wide",
				after = "fg",
				pattern = [[.*<(KEYWORDS)\s*:]],
				comments_only = true,
				max_line_len = 400,
				exclude = {},
			},
			
			-- Catppuccin-friendly colors
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#f38ba8" },
				warning = { "DiagnosticWarn", "WarningMsg", "#fab387" },
				info = { "DiagnosticInfo", "#89b4fa" },
				hint = { "DiagnosticHint", "#a6e3a1" },
				default = { "Identifier", "#cba6f7" },
				test = { "Identifier", "#f5c2e7" },
				
				-- Custom colors for cloud security
				security = { "#f38ba8" },
				vulnerability = { "#eba0ac" },
				compliance = { "#89dceb" },
				performance = { "#fab387" },
				review = { "#f9e2af" },
				cloud = { "#89b4fa" },
				deployment = { "#a6e3a1" },
				config = { "#cba6f7" },
				dependencies = { "#f5c2e7" },
				api = { "#94e2d5" },
			},
			
			-- Standard search configuration
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				pattern = [[\b(KEYWORDS):]],
			},
		},
		
		config = function(_, opts)
			require("todo-comments").setup(opts)
			
			-- Enhanced todo management functions
			
			-- Insert todo comment at cursor
			function _G.insert_todo_comment(keyword)
				local ft = vim.bo.filetype
				local comment_string = vim.bo.commentstring or "// %s"
				
				-- Get current line and cursor position
				local line = vim.api.nvim_get_current_line()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				
				-- Get username for assignee
				local username = vim.fn.substitute(vim.fn.system("whoami"), "\n", "", "g")
				
				-- Create todo comment with assignee
				local todo_text = string.format(comment_string, keyword .. "(" .. username .. "): ")
				
				-- Handle different comment styles
				if ft == "lua" then
					todo_text = "-- " .. keyword .. "(" .. username .. "): "
				elseif ft == "python" then
					todo_text = "# " .. keyword .. "(" .. username .. "): "
				elseif ft == "yaml" or ft == "yml" then
					todo_text = "# " .. keyword .. "(" .. username .. "): "
				elseif ft == "go" or ft == "javascript" or ft == "typescript" then
					todo_text = "// " .. keyword .. "(" .. username .. "): "
				elseif ft == "terraform" then
					todo_text = "# " .. keyword .. "(" .. username .. "): "
				elseif ft == "dockerfile" then
					todo_text = "# " .. keyword .. "(" .. username .. "): "
				end
				
				-- Insert the todo comment
				if vim.fn.mode() == "i" then
					-- In insert mode, insert at cursor
					vim.api.nvim_put({todo_text}, "c", false, true)
				else
					-- In normal mode, create new line
					vim.api.nvim_put({todo_text}, "l", true, true)
					vim.cmd("startinsert!")
				end
			end
			
			-- Create todo from visual selection
			function _G.create_todo_from_selection()
				local start_pos = vim.fn.getpos("'<")
				local end_pos = vim.fn.getpos("'>")
				local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
				
				if #lines == 0 then return end
				
				-- Get selected text
				local selected_text = table.concat(lines, " ")
				if #selected_text > 50 then
					selected_text = string.sub(selected_text, 1, 47) .. "..."
				end
				
				-- Prompt for todo type
				vim.ui.select(
					{"TODO", "FIXME", "SECURITY", "PERF", "NOTE", "REVIEW"},
					{ prompt = "Select todo type:" },
					function(choice)
						if choice then
							local username = vim.fn.substitute(vim.fn.system("whoami"), "\n", "", "g")
							local todo_comment = "// " .. choice .. "(" .. username .. "): " .. selected_text
							vim.api.nvim_buf_set_lines(0, start_pos[2] - 2, start_pos[2] - 2, false, {todo_comment})
						end
					end
				)
			end
			
			-- Resolve todo comment (mark as done)
			function _G.resolve_todo_comment()
				local line_num = vim.fn.line(".")
				local line = vim.api.nvim_get_current_line()
				
				-- Check if current line contains a todo
				local keywords = {"TODO", "FIXME", "BUG", "SECURITY", "VULN", "PERF", "NOTE", "REVIEW"}
				local found_keyword = nil
				
				for _, keyword in ipairs(keywords) do
					if string.find(line, keyword) then
						found_keyword = keyword
						break
					end
				end
				
				if found_keyword then
					-- Mark as DONE with timestamp
					local date = os.date("%Y-%m-%d")
					local new_line = string.gsub(line, found_keyword, "DONE[" .. date .. "]")
					vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, {new_line})
					vim.notify("Todo marked as resolved: " .. found_keyword, vim.log.levels.INFO)
				else
					vim.notify("No todo comment found on current line", vim.log.levels.WARN)
				end
			end
			
			-- Add assignee to todo comment
			function _G.add_todo_assignee()
				local line_num = vim.fn.line(".")
				local line = vim.api.nvim_get_current_line()
				
				vim.ui.input({ prompt = "Assignee: " }, function(assignee)
					if assignee then
						-- Find todo keyword and add assignee
						local new_line = string.gsub(line, "(%w+):", "%1(" .. assignee .. "):")
						vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, {new_line})
					end
				end)
			end
			
			-- Add deadline to todo comment
			function _G.add_todo_deadline()
				local line_num = vim.fn.line(".")
				local line = vim.api.nvim_get_current_line()
				
				vim.ui.input({ 
					prompt = "Deadline (YYYY-MM-DD): ",
					default = os.date("%Y-%m-%d", os.time() + 7*24*3600) -- Default to 1 week from now
				}, function(deadline)
					if deadline then
						-- Find todo keyword and add deadline
						local new_line = string.gsub(line, "(%w+):", "%1[" .. deadline .. "]:")
						vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, {new_line})
					end
				end)
			end
			
			-- User commands for todo management
			vim.api.nvim_create_user_command("TodoInsert", function(opts)
				local keyword = opts.args ~= "" and opts.args or "TODO"
				_G.insert_todo_comment(keyword)
			end, { 
				nargs = "?",
				complete = function()
					return {"TODO", "FIXME", "SECURITY", "VULN", "PERF", "NOTE", "REVIEW", "HACK", "WARN"}
				end,
				desc = "Insert todo comment" 
			})
			
			vim.api.nvim_create_user_command("TodoResolve", function()
				_G.resolve_todo_comment()
			end, { desc = "Resolve todo comment" })
			
			vim.api.nvim_create_user_command("TodoStats", function()
				local todos = require("todo-comments.search").search()
				local stats = {}
				
				for _, todo in ipairs(todos) do
					local keyword = todo.tag
					stats[keyword] = (stats[keyword] or 0) + 1
				end
				
				local lines = { "Todo Statistics:" }
				for keyword, count in pairs(stats) do
					table.insert(lines, string.format("  %s: %d", keyword, count))
				end
				table.insert(lines, string.format("Total: %d", #todos))
				
				vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "Todo Comments" })
			end, { desc = "Show todo statistics" })
			
			-- Security-focused todo reports
			vim.api.nvim_create_user_command("SecurityTodos", function()
				local todos = require("todo-comments.search").search()
				local security_todos = {}
				
				for _, todo in ipairs(todos) do
					if vim.tbl_contains({"SECURITY", "VULN", "CVE", "AUDIT", "COMPLIANCE"}, todo.tag) then
						table.insert(security_todos, todo)
					end
				end
				
				if #security_todos == 0 then
					vim.notify("No security todos found!", vim.log.levels.INFO)
					return
				end
				
				-- Open security todos in quickfix
				local qf_items = {}
				for _, todo in ipairs(security_todos) do
					table.insert(qf_items, {
						filename = todo.filename,
						lnum = todo.lnum,
						col = todo.col,
						text = todo.text,
						type = "W",
					})
				end
				
				vim.fn.setqflist(qf_items)
				vim.cmd("copen")
				vim.notify(string.format("Found %d security todos", #security_todos), vim.log.levels.WARN)
			end, { desc = "Show security-related todos" })
		end,
	}
}
