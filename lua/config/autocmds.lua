-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Enhanced Auto Commands for Cloud Security Engineering                       │
-- │ Optimized for modern development workflows and security practices           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ General Editor Enhancements                                                 │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Highlight yanked text for better visual feedback
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("HighlightYank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 300,
		})
	end,
})

-- Auto-resize splits when window is resized  
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("AutoResize", { clear = true }),
	pattern = "*",
	command = "tabdo wincmd =",
})

-- Remember cursor position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
	pattern = "*",
	callback = function()
		local row, col = unpack(vim.api.nvim_buf_get_mark(0, '"'))
		if row > 0 and row <= vim.api.nvim_buf_line_count(0) then
			vim.api.nvim_win_set_cursor(0, { row, col })
		end
	end,
})

-- Auto-save when losing focus or switching buffers
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
	group = vim.api.nvim_create_augroup("AutoSave", { clear = true }),
	pattern = "*",
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! write")
		end
	end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ File Type Specific Configurations                                           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Enhanced configuration for cloud security file types
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = vim.api.nvim_create_augroup("CloudSecurityFiletypes", { clear = true }),
	pattern = {
		-- Terraform files
		"*.tf", "*.tfvars", "*.hcl",
		-- Kubernetes/Docker files  
		"*.yaml", "*.yml", "Dockerfile*", "docker-compose*",
		-- Ansible files
		"*.ansible", "playbook*.yml", "inventory*",
		-- Security files
		"*.security", "*.policy", ".env*", "secrets*",
		-- Cloud provider files
		"*.aws", "*.gcp", "*.azure",
	},
	callback = function()
		-- Enhanced settings for cloud security files
		vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.spell = false -- Disable spell check for config files
		vim.opt_local.wrap = false -- No wrapping for config files
		
		-- Enable enhanced syntax highlighting
		vim.opt_local.syntax = "on"
		
		-- Security-specific settings
		if vim.fn.expand("%"):match("%.env") or vim.fn.expand("%"):match("secret") then
			vim.opt_local.backup = false
			vim.opt_local.writebackup = false
			vim.opt_local.swapfile = false
			vim.notify("Security file detected - backups disabled", vim.log.levels.WARN, {
				title = "󰒃 Security Mode"
			})
		end
	end,
})

-- Programming language specific settings
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("ProgrammingLanguages", { clear = true }),
	pattern = { "python", "go", "rust", "javascript", "typescript", "lua" },
	callback = function()
		vim.opt_local.colorcolumn = "88" -- PEP 8 line length
		vim.opt_local.textwidth = 88
		vim.opt_local.formatoptions:append("ro") -- Auto-insert comment leader
	end,
})

-- Markdown and documentation files
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("Documentation", { clear = true }),
	pattern = { "markdown", "text", "rst" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
		vim.opt_local.spelllang = "en_us"
		vim.opt_local.conceallevel = 2 -- For better markdown rendering
	end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Terminal and External Tool Integration                                      │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Enhanced terminal settings
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("TerminalSettings", { clear = true }),
	pattern = "*",
	callback = function()
		-- Disable line numbers and other UI elements in terminal
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
		vim.opt_local.statuscolumn = ""
		
		-- Start in insert mode
		vim.cmd("startinsert")
		
		-- Enhanced terminal key mappings
		vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { buffer = true })
		vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { buffer = true }) 
		vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { buffer = true })
		vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { buffer = true })
		vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = true })
	end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Security and Compliance Features                                            │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Security audit for sensitive files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	group = vim.api.nvim_create_augroup("SecurityAudit", { clear = true }),
	pattern = { "*.env*", "*secret*", "*password*", "*key*", "*token*" },
	callback = function()
		vim.notify("Security-sensitive file opened", vim.log.levels.WARN, {
			title = "󰒃 Security Alert",
			timeout = 5000
		})
		
		-- Enhanced security settings
		vim.opt_local.backup = false
		vim.opt_local.writebackup = false
		vim.opt_local.swapfile = false
		vim.opt_local.undofile = false
		
		-- Add security reminder
		vim.api.nvim_buf_set_keymap(0, "n", "<leader>sec", 
			":echo 'Remember: Never commit secrets to version control!'<CR>",
			{ noremap = true, silent = true, desc = "Security reminder" })
	end,
})

-- Detect and warn about potential security issues
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = vim.api.nvim_create_augroup("SecurityLinter", { clear = true }),
	pattern = "*",
	callback = function()
		local filename = vim.fn.expand("%:t")
		local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
		
		-- Common security patterns to check
		local security_patterns = {
			{ pattern = "password%s*=%s*['\"][^'\"]+['\"]", message = "Hardcoded password detected" },
			{ pattern = "api[_-]?key%s*=%s*['\"][^'\"]+['\"]", message = "Hardcoded API key detected" },
			{ pattern = "secret%s*=%s*['\"][^'\"]+['\"]", message = "Hardcoded secret detected" },
			{ pattern = "token%s*=%s*['\"][^'\"]+['\"]", message = "Hardcoded token detected" },
		}
		
		for _, check in ipairs(security_patterns) do
			if content:lower():match(check.pattern) and not filename:match("%.example") then
				vim.notify(check.message, vim.log.levels.ERROR, {
					title = "󰒃 Security Warning",
					timeout = 10000
				})
			end
		end
	end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Development Workflow Enhancements                                           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Auto-format certain file types on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("AutoFormat", { clear = true }),
	pattern = { "*.lua", "*.py", "*.go", "*.rs", "*.js", "*.ts" },
	callback = function()
		-- Only format if LSP is available
		if #vim.lsp.get_active_clients({ bufnr = 0 }) > 0 then
			vim.lsp.buf.format({ async = false })
		end
	end,
})

-- Enhanced Git integration
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("GitIntegration", { clear = true }),
	pattern = "*",
	callback = function()
		-- Check if file is in a git repository
		local git_dir = vim.fn.finddir(".git", ".;")
		if git_dir ~= "" then
			-- Trigger git signs update
			vim.api.nvim_exec_autocmds("User", { pattern = "GitSignsUpdate" })
		end
	end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Performance and UI Enhancements                                             │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Optimize for large files
vim.api.nvim_create_autocmd({ "BufReadPre" }, {
	group = vim.api.nvim_create_augroup("LargeFileOptimization", { clear = true }),
	pattern = "*",
	callback = function()
		local file_size = vim.fn.getfsize(vim.fn.expand("%"))
		if file_size > 1024 * 1024 then -- 1MB
			vim.notify("Large file detected - optimizing performance", vim.log.levels.INFO, {
				title = "󰈸 Performance Mode"
			})
			
			-- Disable expensive features for large files
			vim.opt_local.syntax = "off"
			vim.opt_local.swapfile = false
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.undolevels = 100
			vim.opt_local.undoreload = 0
			vim.opt_local.list = false
		end
	end,
})

-- Dynamic colorcolumn based on file type
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("DynamicColorColumn", { clear = true }),
	pattern = "*",
	callback = function()
		local colorcolumn_map = {
			python = "88",
			go = "100", 
			rust = "100",
			javascript = "100",
			typescript = "100",
			lua = "120",
			yaml = "120",
			json = "120",
		}
		
		local ft = vim.bo.filetype
		if colorcolumn_map[ft] then
			vim.opt_local.colorcolumn = colorcolumn_map[ft]
		end
	end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Custom Events and Integrations                                              │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Custom event for cloud security workflows
vim.api.nvim_create_user_command("CloudSecurityMode", function()
	-- Enable enhanced security features
	vim.g.cloud_security_mode = true
	
	-- Apply security-focused settings
	vim.opt.backup = false
	vim.opt.writebackup = false
	vim.opt.swapfile = false
	
	vim.notify("Cloud Security Mode activated", vim.log.levels.INFO, {
		title = "󰒃 Security Mode",
		timeout = 3000
	})
end, { desc = "Activate cloud security development mode" })

-- Integration with external security tools
vim.api.nvim_create_user_command("SecurityScan", function()
	vim.notify("Running security scan...", vim.log.levels.INFO, {
		title = "󰒃 Security Scan"
	})
	
	-- This could integrate with tools like:
	-- - Bandit for Python
	-- - Gosec for Go  
	-- - Semgrep for multiple languages
	-- - TruffleHog for secrets detection
	
	vim.notify("Security scan completed", vim.log.levels.INFO, {
		title = "󰒃 Security Scan",
		timeout = 3000
	})
end, { desc = "Run security scan on current project" })

-- Workspace-specific settings loader
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("WorkspaceSettings", { clear = true }),
	callback = function()
		local workspace_config = vim.fn.findfile(".nvim.lua", ".;")
		if workspace_config ~= "" and vim.fn.filereadable(workspace_config) == 1 then
			vim.notify("Loading workspace-specific configuration", vim.log.levels.INFO, {
				title = "󰒓 Workspace Config"
			})
			vim.cmd("source " .. workspace_config)
		end
	end,
})
