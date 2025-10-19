-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Debugging Utilities for Cloud Security Engineering                         │
-- │ Additional utilities and configurations for enhanced debugging experience  │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

local M = {}

-- Debugging configuration templates
M.templates = {
	go_cloud_service = {
		type = "go",
		name = "Debug Cloud Service",
		request = "launch",
		program = "${workspaceFolder}/cmd/main.go",
		args = {},
		env = {
			GO_ENV = "development",
			LOG_LEVEL = "debug",
			PORT = "8080",
		},
		buildFlags = "-tags=netgo,osusergo",
		showLog = true,
		logOutput = "rpc",
	},
	
	go_microservice = {
		type = "go",
		name = "Debug Microservice",
		request = "launch",
		program = "${workspaceFolder}",
		args = {},
		env = {
			ENVIRONMENT = "local",
			LOG_LEVEL = "debug",
			DATABASE_URL = "postgres://localhost/testdb",
		},
		buildFlags = "-tags=netgo,osusergo",
		showLog = true,
	},
	
	python_flask_api = {
		type = "python",
		request = "launch",
		name = "Debug Flask API",
		program = "${workspaceFolder}/app.py",
		env = {
			FLASK_ENV = "development",
			FLASK_DEBUG = "1",
			PYTHONPATH = "${workspaceFolder}",
		},
		console = "integratedTerminal",
		django = false,
	},
	
	python_fastapi = {
		type = "python",
		request = "launch",
		name = "Debug FastAPI",
		module = "uvicorn",
		args = { "main:app", "--reload", "--host", "0.0.0.0", "--port", "8000" },
		env = {
			ENVIRONMENT = "development",
			LOG_LEVEL = "debug",
		},
		console = "integratedTerminal",
	},
	
	nodejs_express = {
		type = "pwa-node",
		request = "launch",
		name = "Debug Express Server",
		program = "${workspaceFolder}/server.js",
		env = {
			NODE_ENV = "development",
			DEBUG = "*",
		},
		runtimeArgs = { "--inspect" },
		console = "integratedTerminal",
	},
}

-- Security-focused debugging configurations
M.security_configs = {
	network_analysis = {
		name = "Network Security Analysis",
		env_vars = {
			ENABLE_NETWORK_LOGGING = "true",
			SECURITY_AUDIT_MODE = "enabled",
			LOG_NETWORK_TRAFFIC = "true",
		},
		breakpoints = {
			"Network request validation",
			"Authentication middleware",
			"Authorization checks",
			"Data encryption/decryption",
		},
	},
	
	cloud_security = {
		name = "Cloud Security Debugging",
		env_vars = {
			AWS_PROFILE = "debug",
			CLOUD_DEBUG_MODE = "true",
			SECURITY_VERBOSE = "true",
		},
		breakpoints = {
			"IAM policy checks",
			"Resource access validation",
			"Cloud API authentication",
			"Security group rules",
		},
	},
}

-- Show debugging help
function M.show_help()
	local help_text = {
		"── 🛠️  Essential Controls ──",
		"F5 - Continue/Start debugging",
		"F10 - Step over",
		"F11 - Step into", 
		"F12 - Step out",
		"",
		"── 🔴 Breakpoint Management ──",
		"<leader>db - Toggle breakpoint",
		"<leader>dB - Conditional breakpoint",
		"<leader>dlp - Log point",
		"<leader>dcb - Clear all breakpoints",
		":DapBreakpointConditional - Set conditional breakpoint",
		":DapLogPoint - Set log point",
		"",
		"── 🎮 Session Control ──",
		"<leader>dc - Continue",
		"<leader>dC - Run to cursor",
		"<leader>ds - Stop/Terminate",
		"<leader>dS - Stop & Close UI",
		"<leader>dr - Restart",
		"<leader>dp - Pause",
		"<leader>dl - Run last",
		"",
		"── 🔍 UI & Navigation ──",
		"<leader>du - Toggle debug UI",
		"<leader>dw - Watches window",
		"<leader>df - Scopes window",
		"<leader>dh - Hover variables",
		"<leader>de - Evaluate expression",
		"<leader>dR - Open REPL",
		"",
		"── 🔭 Telescope Integration ──",
		"<leader>dtb - List breakpoints",
		"<leader>dtv - Variables",
		"<leader>dtf - Stack frames",
		"<leader>dtc - DAP commands",
		"<leader>dtg - Configurations",
		"",
		"── 🐹 Go Debugging ──",
		"<leader>dgt - Debug Go test",
		"<leader>dgl - Debug last Go test",
		"",
		"── 🐍 Python Debugging ──",
		"<leader>dpt - Debug Python test method",
		"<leader>dpc - Debug Python test class",
		"<leader>dps - Debug Python selection",
		"",
		"── 📦 Utility Commands ──",
		":DapClearAll - Clear all breakpoints",
		":DapToggleRepl - Toggle DAP REPL",
		":DapHelp - Show this help",
	}
	
	vim.notify(table.concat(help_text, "\n"), vim.log.levels.INFO, {
		title = "󰃤 Debugging Help",
		timeout = false, -- Don't auto-close
	})
end

-- Setup debugging for cloud security projects
function M.setup_cloud_debugging()
	local dap = require("dap")
	
	-- Add cloud security templates to configurations
	for lang, config in pairs(M.templates) do
		if not dap.configurations[lang:match("^(%w+)")] then
			dap.configurations[lang:match("^(%w+)")] = {}
		end
		table.insert(dap.configurations[lang:match("^(%w+)")], config)
	end
	
	vim.notify("Cloud security debugging configurations loaded", vim.log.levels.INFO, {
		title = "☁️  Cloud Debug Setup"
	})
end

-- Enhanced breakpoint with security context
function M.security_breakpoint()
	local security_contexts = {
		"Authentication check",
		"Authorization validation", 
		"Input sanitization",
		"Data encryption",
		"Network request",
		"Database query",
		"File system access",
		"Environment variable access",
		"API key validation",
		"Token verification",
	}
	
	vim.ui.select(security_contexts, {
		prompt = "Select security context for breakpoint:",
	}, function(choice)
		if choice then
			local dap = require("dap")
			dap.set_breakpoint(nil, nil, "Security: " .. choice)
			vim.notify("Security breakpoint set: " .. choice, vim.log.levels.INFO, {
				title = "🔒 Security Breakpoint"
			})
		end
	end)
end

-- Performance profiling setup
function M.setup_performance_debugging()
	local dap = require("dap")
	
	-- Go performance debugging
	table.insert(dap.configurations.go or {}, {
		type = "go",
		name = "Debug with CPU Profiling",
		request = "launch",
		program = "${workspaceFolder}",
		args = { "-cpuprofile", "cpu.prof" },
		env = {
			GOMAXPROCS = "1",
			GODEBUG = "gctrace=1",
		},
		buildFlags = "-race",
		showLog = true,
	})
	
	-- Python performance debugging
	table.insert(dap.configurations.python or {}, {
		type = "python",
		request = "launch",
		name = "Debug with cProfile",
		program = "${file}",
		args = {},
		env = {
			PYTHONPATH = "${workspaceFolder}",
			PYTHONASYNCIODEBUG = "1",
		},
		console = "integratedTerminal",
		module = "cProfile",
	})
	
	vim.notify("Performance debugging configurations added", vim.log.levels.INFO, {
		title = "⚡ Performance Debug"
	})
end

-- Container debugging setup
function M.setup_container_debugging()
	local dap = require("dap")
	
	-- Docker container debugging
	table.insert(dap.configurations.go or {}, {
		type = "go",
		name = "Debug in Container",
		request = "attach",
		mode = "remote",
		remotePath = "/app",
		port = 2345,
		host = "127.0.0.1",
		showLog = true,
	})
	
	vim.notify("Container debugging configurations added", vim.log.levels.INFO, {
		title = "🐳 Container Debug"
	})
end

-- Debugging session analytics
function M.show_session_stats()
	local dap = require("dap")
	local session = dap.session()
	
	if not session then
		vim.notify("No active debugging session", vim.log.levels.WARN, {
			title = "📊 Debug Stats"
		})
		return
	end
	
	local stats = {
		"── 📊 Debug Session Statistics ──",
		"Session ID: " .. (session.id or "N/A"),
		"Adapter: " .. (session.adapter and session.adapter.name or "N/A"),
		"Status: " .. (session.status or "N/A"),
		"",
		"Use :lua require('dap').status() for more details",
	}
	
	vim.notify(table.concat(stats, "\n"), vim.log.levels.INFO, {
		title = "📊 Debug Session Stats"
	})
end

return M
