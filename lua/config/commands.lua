-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Enhanced User Commands for Cloud Security Engineering                      │
-- │ Professional custom commands for modern development workflows               │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Buffer and File Management Commands                                         │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Enhanced buffer commands
vim.api.nvim_create_user_command("BufferInfo", function()
	local buffers = utils.get_buffer_info()
	local info = {}
	
	for _, buf in ipairs(buffers) do
		local status = buf.modified and "[+]" or ""
		local sensitive = buf.is_sensitive and "🔒" or ""
		table.insert(info, string.format("%d: %s %s %s", buf.bufnr, buf.basename, status, sensitive))
	end
	
	if #info == 0 then
		vim.notify("No buffers loaded", vim.log.levels.INFO)
	else
		vim.notify(table.concat(info, "\n"), vim.log.levels.INFO, { title = "Buffer Information" })
	end
end, { desc = "Show detailed buffer information" })

vim.api.nvim_create_user_command("CloseOtherBuffers", function()
	utils.close_other_buffers()
end, { desc = "Close all buffers except current" })

vim.api.nvim_create_user_command("ReloadBuffer", function()
	utils.reload_buffer()
end, { desc = "Reload current buffer from disk" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Development and LSP Commands                                                │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Smart formatting command
vim.api.nvim_create_user_command("Format", function()
	utils.smart_format()
end, { desc = "Smart format current buffer" })

-- Toggle diagnostics
vim.api.nvim_create_user_command("DiagnosticToggle", function()
	utils.toggle_diagnostics()
end, { desc = "Toggle LSP diagnostics" })

-- LSP information
vim.api.nvim_create_user_command("LspInfo", function()
	local clients = utils.get_lsp_clients()
	if #clients == 0 then
		vim.notify("No LSP clients attached", vim.log.levels.WARN)
	else
		vim.notify("LSP clients: " .. table.concat(clients, ", "), vim.log.levels.INFO, {
			title = "LSP Information"
		})
	end
end, { desc = "Show LSP client information" })

-- Code action command
vim.api.nvim_create_user_command("CodeAction", function()
	if utils.has_lsp() then
		vim.lsp.buf.code_action()
	else
		vim.notify("No LSP client available", vim.log.levels.WARN)
	end
end, { desc = "Trigger LSP code actions" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Git Integration Commands                                                    │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Git status information
vim.api.nvim_create_user_command("GitStatus", function()
	if not utils.is_git_repo() then
		vim.notify("Not in a git repository", vim.log.levels.WARN)
		return
	end
	
	local branch = utils.get_git_branch()
	local status = utils.get_git_status()
	
	local info = {
		"Branch: " .. (branch or "unknown"),
		"Staged: " .. status.staged,
		"Unstaged: " .. status.unstaged,
		"Untracked: " .. status.untracked,
	}
	
	if status.conflicts > 0 then
		table.insert(info, "Conflicts: " .. status.conflicts)
	end
	
	vim.notify(table.concat(info, "\n"), vim.log.levels.INFO, { title = "Git Status" })
end, { desc = "Show git repository status" })

-- Git branch command
vim.api.nvim_create_user_command("GitBranch", function()
	local branch = utils.get_git_branch()
	if branch then
		vim.notify("Current branch: " .. branch, vim.log.levels.INFO)
	else
		vim.notify("Not in a git repository or no branch", vim.log.levels.WARN)
	end
end, { desc = "Show current git branch" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Security and Cloud Engineering Commands                                     │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Security scan command
vim.api.nvim_create_user_command("SecurityScan", function()
	local score = utils.calculate_security_score()
	local level = score > 20 and vim.log.levels.ERROR or 
	             score > 10 and vim.log.levels.WARN or 
	             vim.log.levels.INFO
	
	vim.notify(string.format("Security score: %d/100", score), level, {
		title = "󰒃 Security Scan"
	})
	
	if utils.is_sensitive_file() then
		vim.notify("This file contains sensitive information", vim.log.levels.WARN, {
			title = "󰒃 Sensitive File"
		})
	end
end, { desc = "Run security scan on current buffer" })

-- Cloud provider detection
vim.api.nvim_create_user_command("CloudProvider", function()
	local provider = utils.detect_cloud_provider()
	if provider then
		vim.notify("Detected cloud provider: " .. provider, vim.log.levels.INFO, {
			title = "☁️ Cloud Detection"
		})
	else
		vim.notify("No cloud provider detected", vim.log.levels.INFO)
	end
end, { desc = "Detect cloud provider from current file" })

-- Security template insertion
vim.api.nvim_create_user_command("SecurityTemplate", function(opts)
	local template = opts.args
	if template == "" then
		local templates = {}
		for name, _ in pairs(utils.security_templates) do
			table.insert(templates, name)
		end
		vim.notify("Available templates: " .. table.concat(templates, ", "), vim.log.levels.INFO)
	else
		utils.insert_security_template(template)
	end
end, {
	desc = "Insert security template",
	nargs = "?",
	complete = function()
		local templates = {}
		for name, _ in pairs(utils.security_templates) do
			table.insert(templates, name)
		end
		return templates
	end
})

-- Generate secure string
vim.api.nvim_create_user_command("SecureString", function(opts)
	local length = tonumber(opts.args) or 32
	local secure_string = utils.generate_secure_string(length)
	
	-- Insert at cursor position
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { secure_string })
	
	vim.notify(string.format("Generated %d-character secure string", length), vim.log.levels.INFO, {
		title = "󰒃 Secure String"
	})
end, {
	desc = "Generate and insert secure random string",
	nargs = "?",
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ UI and Visual Enhancement Commands                                          │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Toggle visual features
vim.api.nvim_create_user_command("ToggleNumbers", function()
	utils.toggle_line_numbers()
end, { desc = "Toggle between relative and absolute line numbers" })

vim.api.nvim_create_user_command("ToggleColorColumn", function()
	utils.toggle_colorcolumn()
end, { desc = "Toggle color column visibility" })

-- Highlight group information
vim.api.nvim_create_user_command("HighlightInfo", function()
	utils.get_highlight_group()
end, { desc = "Show highlight group under cursor" })

-- Center cursor
vim.api.nvim_create_user_command("Center", function()
	utils.center_cursor()
end, { desc = "Center cursor in window" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Performance and Debug Commands                                              │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Performance commands
vim.api.nvim_create_user_command("StartupTime", function()
	utils.startup_time()
end, { desc = "Measure and profile startup time" })

vim.api.nvim_create_user_command("MemoryUsage", function()
	utils.memory_usage()
end, { desc = "Show memory usage information" })

-- Plugin management shortcuts
vim.api.nvim_create_user_command("LazyStatus", function()
	vim.cmd("Lazy")
end, { desc = "Open Lazy plugin manager" })

vim.api.nvim_create_user_command("LazySync", function()
	vim.cmd("Lazy sync")
	vim.notify("Syncing plugins...", vim.log.levels.INFO, { title = "󰒲 Lazy.nvim" })
end, { desc = "Sync all plugins" })

vim.api.nvim_create_user_command("LazyClean", function()
	vim.cmd("Lazy clean")
	vim.notify("Cleaning unused plugins...", vim.log.levels.INFO, { title = "󰒲 Lazy.nvim" })
end, { desc = "Clean unused plugins" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Project Management Commands                                                 │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Project root detection
vim.api.nvim_create_user_command("ProjectRoot", function()
	local root = utils.get_project_root()
	vim.notify("Project root: " .. root, vim.log.levels.INFO)
	
	-- Optionally change to project root
	local choice = vim.fn.input("Change to project root? (y/N): ")
	if choice:lower() == "y" then
		vim.cmd("cd " .. root)
		vim.notify("Changed to project root", vim.log.levels.INFO)
	end
end, { desc = "Show and optionally change to project root" })

-- File type information
vim.api.nvim_create_user_command("FileInfo", function()
	local file = vim.fn.expand("%:t")
	local extension = utils.get_file_extension(file)
	local filetype = vim.bo.filetype
	local is_large = utils.is_large_file()
	local is_sensitive = utils.is_sensitive_file()
	local provider = utils.detect_cloud_provider()
	
	local info = {
		"File: " .. file,
		"Extension: " .. (extension ~= "" and extension or "none"),
		"Filetype: " .. (filetype ~= "" and filetype or "none"),
		"Large file: " .. (is_large and "yes" or "no"),
		"Sensitive: " .. (is_sensitive and "yes" or "no"),
	}
	
	if provider then
		table.insert(info, "Cloud provider: " .. provider)
	end
	
	vim.notify(table.concat(info, "\n"), vim.log.levels.INFO, { title = "File Information" })
end, { desc = "Show detailed file information" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Workspace and Session Commands                                              │
-- ╰─────────────────────────────────────────────────────────────────────────────╮

-- Workspace information
vim.api.nvim_create_user_command("WorkspaceInfo", function()
	local cwd = vim.fn.getcwd()
	local git_repo = utils.is_git_repo()
	local git_branch = utils.get_git_branch()
	local lsp_clients = utils.get_lsp_clients()
	local buffers = utils.get_buffer_info()
	
	local info = {
		"Working directory: " .. cwd,
		"Git repository: " .. (git_repo and "yes" or "no"),
	}
	
	if git_branch then
		table.insert(info, "Git branch: " .. git_branch)
	end
	
	if #lsp_clients > 0 then
		table.insert(info, "LSP clients: " .. table.concat(lsp_clients, ", "))
	end
	
	table.insert(info, "Open buffers: " .. #buffers)
	
	vim.notify(table.concat(info, "\n"), vim.log.levels.INFO, { title = "Workspace Information" })
end, { desc = "Show workspace information" })

-- Clear all notifications
vim.api.nvim_create_user_command("ClearNotifications", function()
	if pcall(require, "notify") then
		require("notify").dismiss({ silent = true, pending = true })
		vim.notify("Notifications cleared", vim.log.levels.INFO)
	else
		vim.notify("Notify plugin not available", vim.log.levels.WARN)
	end
end, { desc = "Clear all notifications" })

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Configuration and Help Commands                                             │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Quick configuration editing
vim.api.nvim_create_user_command("ConfigEdit", function(opts)
	local config_files = {
		init = "~/.config/nvim/init.lua",
		options = "~/.config/nvim/lua/core/options.lua",
		keymaps = "~/.config/nvim/lua/core/keymaps.lua",
		utils = "~/.config/nvim/lua/config/utils.lua",
		autocmds = "~/.config/nvim/lua/config/autocmds.lua",
	}
	
	local file = opts.args
	if file == "" then
		local files = {}
		for name, _ in pairs(config_files) do
			table.insert(files, name)
		end
		vim.notify("Available configs: " .. table.concat(files, ", "), vim.log.levels.INFO)
	else
		local path = config_files[file]
		if path then
			vim.cmd("edit " .. vim.fn.expand(path))
		else
			vim.notify("Config not found: " .. file, vim.log.levels.ERROR)
		end
	end
end, {
	desc = "Edit configuration file",
	nargs = "?",
	complete = function()
		return { "init", "options", "keymaps", "utils", "autocmds" }
	end
})

-- Help and documentation
vim.api.nvim_create_user_command("Help", function(opts)
	local topic = opts.args
	if topic == "" then
		vim.cmd("help")
	else
		vim.cmd("help " .. topic)
	end
end, {
	desc = "Enhanced help command",
	nargs = "?",
	complete = "help"
})
