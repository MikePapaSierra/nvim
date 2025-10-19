-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Enhanced Utility Functions for Cloud Security Engineering                  │
-- │ Professional helper functions for modern development workflows              │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

local M = {}

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ File and Directory Utilities                                                │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Check if a file exists
function M.file_exists(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "file"
end

-- Check if a directory exists
function M.dir_exists(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "directory"
end

-- Get file extension
function M.get_file_extension(filename)
	return filename:match("^.+%.(.+)$") or ""
end

-- Check if current buffer is a large file (>1MB)
function M.is_large_file(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(bufnr)
	if file == "" then return false end
	
	local size = vim.fn.getfsize(file)
	return size > 1024 * 1024 -- 1MB threshold
end

-- Get project root directory
function M.get_project_root()
	local markers = {".git", ".svn", ".hg", "Cargo.toml", "package.json", "go.mod", "pyproject.toml"}
	local current_dir = vim.fn.expand("%:p:h")
	
	for _, marker in ipairs(markers) do
		local found = vim.fn.finddir(marker, current_dir .. ";")
		if found ~= "" then
			return vim.fn.fnamemodify(found, ":h")
		end
		
		local found_file = vim.fn.findfile(marker, current_dir .. ";")
		if found_file ~= "" then
			return vim.fn.fnamemodify(found_file, ":h")
		end
	end
	
	return current_dir
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Security and Cloud Engineering Utilities                                    │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Detect if file contains sensitive information
function M.is_sensitive_file(filename)
	filename = filename or vim.fn.expand("%:t")
	local sensitive_patterns = {
		"%.env", "%.env%.", "secret", "password", "key", "token", "credential",
		"%.pem", "%.key", "%.crt", "%.p12", "%.pfx"
	}
	
	for _, pattern in ipairs(sensitive_patterns) do
		if filename:lower():match(pattern) then
			return true
		end
	end
	return false
end

-- Detect cloud provider files
function M.detect_cloud_provider(filename)
	filename = filename or vim.fn.expand("%:t"):lower()
	
	local providers = {
		aws = {"%.aws", "cloudformation", "cdk", "sam%-template", "serverless%.yml"},
		gcp = {"%.gcp", "deployment%-manager", "cloud%-build", "app%.yaml"},
		azure = {"%.azure", "arm%-template", "bicep", "azure%-pipelines"},
		kubernetes = {"deployment%.ya?ml", "service%.ya?ml", "ingress%.ya?ml", "configmap%.ya?ml"},
		terraform = {"%.tf", "%.tfvars", "%.hcl", "terraform%."},
		docker = {"dockerfile", "docker%-compose", "%.dockerignore"}
	}
	
	for provider, patterns in pairs(providers) do
		for _, pattern in ipairs(patterns) do
			if filename:match(pattern) then
				return provider
			end
		end
	end
	
	return nil
end

-- Security score for file based on content
function M.calculate_security_score(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local content = table.concat(lines, "\n"):lower()
	
	local security_issues = {
		{ pattern = "password%s*=%s*['\"][^'\"]+['\"]", weight = 10 },
		{ pattern = "api[_-]?key%s*=%s*['\"][^'\"]+['\"]", weight = 10 },
		{ pattern = "secret%s*=%s*['\"][^'\"]+['\"]", weight = 8 },
		{ pattern = "token%s*=%s*['\"][^'\"]+['\"]", weight = 8 },
		{ pattern = "http://", weight = 3 },
		{ pattern = "todo", weight = 1 },
		{ pattern = "fixme", weight = 2 },
		{ pattern = "hack", weight = 3 },
	}
	
	local score = 0
	for _, issue in ipairs(security_issues) do
		local count = 0
		for match in content:gmatch(issue.pattern) do
			count = count + 1
		end
		score = score + (count * issue.weight)
	end
	
	return math.min(score, 100) -- Cap at 100
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Buffer and Window Management                                                 │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Get all open buffers with useful information
function M.get_buffer_info()
	local buffers = {}
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			local name = vim.api.nvim_buf_get_name(bufnr)
			local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
			local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
			
			table.insert(buffers, {
				bufnr = bufnr,
				name = name,
				basename = vim.fn.fnamemodify(name, ":t"),
				modified = modified,
				filetype = filetype,
				is_sensitive = M.is_sensitive_file(name)
			})
		end
	end
	return buffers
end

-- Smart buffer switching with enhanced filtering
function M.smart_buffer_switch()
	local buffers = M.get_buffer_info()
	local current_buf = vim.api.nvim_get_current_buf()
	
	-- Filter out current buffer and special buffers
	local filtered = {}
	for _, buf in ipairs(buffers) do
		if buf.bufnr ~= current_buf and buf.name ~= "" then
			table.insert(filtered, buf)
		end
	end
	
	if #filtered == 0 then
		vim.notify("No other buffers available", vim.log.levels.WARN)
		return
	end
	
	-- Switch to most recently used buffer
	vim.cmd("buffer " .. filtered[1].bufnr)
end

-- Close all buffers except current
function M.close_other_buffers()
	local current = vim.api.nvim_get_current_buf()
	local buffers = M.get_buffer_info()
	
	for _, buf in ipairs(buffers) do
		if buf.bufnr ~= current and buf.name ~= "" then
			if buf.modified then
				vim.notify("Skipping modified buffer: " .. buf.basename, vim.log.levels.WARN)
			else
				vim.api.nvim_buf_delete(buf.bufnr, { force = false })
			end
		end
	end
	
	vim.notify("Closed other buffers", vim.log.levels.INFO)
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Git Integration Utilities                                                   │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Check if current directory is a git repository
function M.is_git_repo()
	local git_dir = vim.fn.finddir(".git", ".;")
	return git_dir ~= ""
end

-- Get current git branch
function M.get_git_branch()
	if not M.is_git_repo() then return nil end
	
	local handle = io.popen("git branch --show-current 2>/dev/null")
	if handle then
		local branch = handle:read("*a"):gsub("\n", "")
		handle:close()
		return branch ~= "" and branch or nil
	end
	return nil
end

-- Get git status information
function M.get_git_status()
	if not M.is_git_repo() then return {} end
	
	local status = {
		staged = 0,
		unstaged = 0,
		untracked = 0,
		conflicts = 0
	}
	
	local handle = io.popen("git status --porcelain 2>/dev/null")
	if handle then
		for line in handle:lines() do
			local staged_status = line:sub(1, 1)
			local unstaged_status = line:sub(2, 2)
			
			if staged_status == "U" or unstaged_status == "U" then
				status.conflicts = status.conflicts + 1
			elseif staged_status ~= " " and staged_status ~= "?" then
				status.staged = status.staged + 1
			elseif unstaged_status ~= " " then
				status.unstaged = status.unstaged + 1
			elseif staged_status == "?" then
				status.untracked = status.untracked + 1
			end
		end
		handle:close()
	end
	
	return status
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ LSP and Development Utilities                                               │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Check if LSP is available for current buffer
function M.has_lsp()
	return #vim.lsp.get_active_clients({ bufnr = 0 }) > 0
end

-- Get LSP client names for current buffer
function M.get_lsp_clients()
	local clients = vim.lsp.get_active_clients({ bufnr = 0 })
	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return names
end

-- Smart formatting with fallback
function M.smart_format()
	if M.has_lsp() then
		vim.lsp.buf.format({ async = false })
		vim.notify("Formatted with LSP", vim.log.levels.INFO)
	else
		-- Fallback to basic formatting
		vim.cmd("normal! gg=G``")
		vim.notify("Formatted with basic indentation", vim.log.levels.INFO)
	end
end

-- Toggle diagnostics
function M.toggle_diagnostics()
	local is_enabled = vim.diagnostic.is_disabled(0)
	if is_enabled then
		vim.diagnostic.enable(0)
		vim.notify("Diagnostics enabled", vim.log.levels.INFO)
	else
		vim.diagnostic.disable(0)
		vim.notify("Diagnostics disabled", vim.log.levels.INFO)
	end
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ UI and Visual Enhancement Utilities                                         │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Center current line in window
function M.center_cursor()
	vim.cmd("normal! zz")
end

-- Toggle between relative and absolute line numbers
function M.toggle_line_numbers()
	if vim.opt.relativenumber:get() then
		vim.opt.relativenumber = false
		vim.opt.number = true
		vim.notify("Absolute line numbers", vim.log.levels.INFO)
	else
		vim.opt.relativenumber = true
		vim.notify("Relative line numbers", vim.log.levels.INFO)
	end
end

-- Toggle color column
function M.toggle_colorcolumn()
	local current = vim.opt.colorcolumn:get()
	if #current > 0 then
		vim.opt.colorcolumn = ""
		vim.notify("Color column disabled", vim.log.levels.INFO)
	else
		vim.opt.colorcolumn = "88"
		vim.notify("Color column enabled", vim.log.levels.INFO)
	end
end

-- Get syntax highlighting group under cursor
function M.get_highlight_group()
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local hi_group = vim.fn.synIDattr(vim.fn.synID(line, col, 1), "name")
	local trans_group = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.synID(line, col, 1)), "name")
	
	local message = string.format("Hi: %s, Trans: %s", hi_group, trans_group)
	vim.notify(message, vim.log.levels.INFO, { title = "Highlight Info" })
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Cloud Security Specific Functions                                           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Generate secure random string (for configs/templates)
function M.generate_secure_string(length)
	length = length or 32
	local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local result = ""
	
	for i = 1, length do
		local rand = math.random(1, #chars)
		result = result .. chars:sub(rand, rand)
	end
	
	return result
end

-- Security-focused code templates
M.security_templates = {
	env_template = function()
		return {
			"# Environment Configuration",
			"# Generated: " .. os.date("%Y-%m-%d %H:%M:%S"),
			"# Security: Do not commit this file to version control",
			"",
			"# Database Configuration",
			"DB_HOST=localhost",
			"DB_PORT=5432",
			"DB_NAME=myapp",
			"DB_USER=myuser",
			"DB_PASSWORD=" .. M.generate_secure_string(24),
			"",
			"# API Configuration", 
			"API_KEY=" .. M.generate_secure_string(32),
			"JWT_SECRET=" .. M.generate_secure_string(48),
			"",
			"# Security Configuration",
			"ENCRYPTION_KEY=" .. M.generate_secure_string(32),
			"SESSION_SECRET=" .. M.generate_secure_string(24),
		}
	end,
	
	gitignore_security = function()
		return {
			"# Security and Sensitive Files",
			".env*",
			"!.env.example", 
			"secrets/",
			"*.key",
			"*.pem",
			"*.p12",
			"*.pfx",
			"credentials.json",
			"service-account.json",
			"",
			"# Cloud Provider Configs",
			".aws/credentials",
			".gcp/credentials.json",
			".azure/credentials",
			"",
			"# IDE and Editor",
			".vscode/settings.json",
			".idea/",
			"",
			"# Terraform",
			"*.tfstate*",
			".terraform/",
			"terraform.tfvars",
			"!terraform.tfvars.example",
		}
	end
}

-- Insert security template
function M.insert_security_template(template_name)
	local templates = M.security_templates
	if not templates[template_name] then
		vim.notify("Template not found: " .. template_name, vim.log.levels.ERROR)
		return
	end
	
	local lines = templates[template_name]()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, lines)
	
	vim.notify("Inserted " .. template_name .. " template", vim.log.levels.INFO, {
		title = "󰒃 Security Template"
	})
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Performance and Debug Utilities                                             │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Measure startup time
function M.startup_time()
	local stats = vim.api.nvim_exec("profile start /tmp/nvim-startup.log\nprofile file *\nprofile func *", true)
	vim.notify("Profiling started. Restart Neovim to see results in /tmp/nvim-startup.log", vim.log.levels.INFO)
end

-- Get memory usage information
function M.memory_usage()
	local mem_usage = vim.api.nvim_exec("memory", true)
	vim.notify(mem_usage, vim.log.levels.INFO, { title = "Memory Usage" })
end

-- Reload current buffer from disk
function M.reload_buffer()
	if vim.bo.modified then
		vim.notify("Buffer has unsaved changes", vim.log.levels.WARN)
		return
	end
	
	vim.cmd("edit!")
	vim.notify("Buffer reloaded from disk", vim.log.levels.INFO)
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Global Utility Functions (for keymaps and commands)                         │ 
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Make functions globally available
_G.utils = M

-- Convenient global functions for keymaps
_G.smart_format = M.smart_format
_G.toggle_diagnostics = M.toggle_diagnostics
_G.smart_buffer_switch = M.smart_buffer_switch
_G.close_other_buffers = M.close_other_buffers
_G.center_cursor = M.center_cursor
_G.toggle_line_numbers = M.toggle_line_numbers

return M
