-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Go Development Environment Validator                                        │
-- │ Validates Go tools and configuration for cloud security development        │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

local M = {}

-- Required Go tools for enhanced development
local go_tools = {
	{ cmd = "gopls", desc = "Go Language Server" },
	{ cmd = "gofumpt", desc = "Enhanced Go formatter" },
	{ cmd = "gomodifytags", desc = "Struct tag modifier" },
	{ cmd = "gotests", desc = "Test generator" },
	{ cmd = "impl", desc = "Interface implementation generator" },
	{ cmd = "iferr", desc = "If err snippet generator" },
	{ cmd = "staticcheck", desc = "Go static analysis tool" },
	{ cmd = "golangci-lint", desc = "Go linter aggregator" },
}

-- Cloud security specific tools (optional but recommended)
local security_tools = {
	{ cmd = "gosec", desc = "Go security analyzer" },
	{ cmd = "govulncheck", desc = "Go vulnerability scanner" },
	{ cmd = "nancy", desc = "Dependency vulnerability scanner" },
}

-- Check if a command is available
local function is_available(cmd)
	local handle = io.popen("which " .. cmd .. " 2>/dev/null")
	if handle then
		local result = handle:read("*a")
		handle:close()
		return result ~= ""
	end
	return false
end

-- Validate Go installation and tools
function M.validate_setup()
	local results = {
		go_installed = false,
		tools_status = {},
		security_tools_status = {},
		missing_tools = {},
		missing_security_tools = {},
	}
	
	-- Check Go installation
	results.go_installed = is_available("go")
	
	-- Check essential tools
	for _, tool in ipairs(go_tools) do
		local available = is_available(tool.cmd)
		results.tools_status[tool.cmd] = available
		if not available then
			table.insert(results.missing_tools, tool)
		end
	end
	
	-- Check security tools
	for _, tool in ipairs(security_tools) do
		local available = is_available(tool.cmd)
		results.security_tools_status[tool.cmd] = available
		if not available then
			table.insert(results.missing_security_tools, tool)
		end
	end
	
	return results
end

-- Display validation results
function M.show_status()
	local results = M.validate_setup()
	
	-- Header
	vim.notify("Go Development Environment Status", vim.log.levels.INFO, {
		title = "󰟓 Go Setup Validation"
	})
	
	-- Go installation status
	if results.go_installed then
		vim.notify("✅ Go is installed", vim.log.levels.INFO)
	else
		vim.notify("❌ Go is not installed", vim.log.levels.ERROR)
		return
	end
	
	-- Essential tools status
	local installed_count = 0
	for _, tool in ipairs(go_tools) do
		if results.tools_status[tool.cmd] then
			installed_count = installed_count + 1
		end
	end
	
	vim.notify(
		string.format("📦 Essential tools: %d/%d installed", installed_count, #go_tools),
		installed_count == #go_tools and vim.log.levels.INFO or vim.log.levels.WARN
	)
	
	-- Security tools status
	local security_installed = 0
	for _, tool in ipairs(security_tools) do
		if results.security_tools_status[tool.cmd] then
			security_installed = security_installed + 1
		end
	end
	
	vim.notify(
		string.format("🔒 Security tools: %d/%d installed", security_installed, #security_tools),
		security_installed > 0 and vim.log.levels.INFO or vim.log.levels.WARN
	)
	
	-- Show missing tools if any
	if #results.missing_tools > 0 then
		local missing_names = {}
		for _, tool in ipairs(results.missing_tools) do
			table.insert(missing_names, tool.cmd)
		end
		vim.notify(
			"Missing essential tools: " .. table.concat(missing_names, ", "),
			vim.log.levels.WARN,
			{ title = "⚠️  Missing Tools" }
		)
	end
	
	if #results.missing_security_tools > 0 then
		local missing_names = {}
		for _, tool in ipairs(results.missing_security_tools) do
			table.insert(missing_names, tool.cmd)
		end
		vim.notify(
			"Missing security tools: " .. table.concat(missing_names, ", "),
			vim.log.levels.WARN,
			{ title = "🔒 Security Tools" }
		)
	end
end

-- Install missing essential tools
function M.install_tools()
	local results = M.validate_setup()
	
	if not results.go_installed then
		vim.notify("Go is not installed. Please install Go first.", vim.log.levels.ERROR)
		return
	end
	
	if #results.missing_tools == 0 then
		vim.notify("All essential tools are already installed!", vim.log.levels.INFO)
		return
	end
	
	vim.notify("Installing missing Go tools...", vim.log.levels.INFO, {
		title = "📦 Tool Installation"
	})
	
	-- Install commands for missing tools
	local install_commands = {
		gopls = "go install golang.org/x/tools/gopls@latest",
		gofumpt = "go install mvdan.cc/gofumpt@latest",
		gomodifytags = "go install github.com/fatih/gomodifytags@latest",
		gotests = "go install github.com/cweill/gotests/...@latest",
		impl = "go install github.com/josharian/impl@latest",
		iferr = "go install github.com/koron/iferr@latest",
		staticcheck = "go install honnef.co/go/tools/cmd/staticcheck@latest",
		["golangci-lint"] = "go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest",
	}
	
	for _, tool in ipairs(results.missing_tools) do
		local cmd = install_commands[tool.cmd]
		if cmd then
			vim.fn.jobstart(cmd, {
				on_exit = function(_, code)
					if code == 0 then
						vim.notify("✅ Installed " .. tool.cmd, vim.log.levels.INFO)
					else
						vim.notify("❌ Failed to install " .. tool.cmd, vim.log.levels.ERROR)
					end
				end,
			})
		end
	end
	
	vim.defer_fn(function()
		vim.notify("Tool installation completed. Run :GoSetupStatus to verify.", vim.log.levels.INFO, {
			title = "📦 Installation Complete"
		})
	end, 5000)
end

-- Install security tools
function M.install_security_tools()
	vim.notify("Installing Go security tools...", vim.log.levels.INFO, {
		title = "🔒 Security Tools"
	})
	
	local security_commands = {
		"go install github.com/securecodewarrior/gosec/v2/cmd/gosec@latest",
		"go install golang.org/x/vuln/cmd/govulncheck@latest",
		"go install github.com/sonatypecommunity/nancy@latest",
	}
	
	for _, cmd in ipairs(security_commands) do
		vim.fn.jobstart(cmd, {
			on_exit = function(_, code)
				local tool_name = cmd:match("([^/]+)@latest"):gsub("@latest", "")
				if code == 0 then
					vim.notify("✅ Installed " .. tool_name, vim.log.levels.INFO)
				else
					vim.notify("❌ Failed to install " .. tool_name, vim.log.levels.ERROR)
				end
			end,
		})
	end
end

return M
