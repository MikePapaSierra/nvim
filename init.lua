-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Enhanced Neovim Configuration for Cloud Security Engineering               │
-- │ Loading plugins from plugins directory with proper error handling          │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Capture startup time as early as possible
vim.g.start_time = vim.fn.reltime()

-- Set leader keys first
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins from the plugins directory
require("lazy").setup("plugins", {
	-- Optimized lazy.nvim configuration for faster startup
	defaults = {
		lazy = true, -- Default to lazy loading
		version = false, -- Don't use version constraints by default
	},
	ui = {
		border = "rounded",
		backdrop = 60, -- Backdrop for floating windows
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- Reset packpath to improve startup time
		rtp = {
			reset = true, -- Reset runtimepath to improve startup time
			paths = {}, -- Add any extra paths here
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"logipat",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
			},
		},
	},
	-- Speed up loading by reducing git operations
	git = {
		log = { "-8" }, -- Show only last 8 commits
		timeout = 120,
	},
	-- Faster installation/updates
	install = {
		missing = true,
		colorscheme = { "catppuccin", "habamax" },
	},
	-- Reduce startup time by deferring checker
	checker = {
		enabled = false, -- Disable automatic updates for faster startup
		notify = false,
	},
	change_detection = {
		enabled = false, -- Disable file change detection for better performance
		notify = false,
	},
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Load Configuration Modules (Optimized for Performance)                     │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Load essential modules first (synchronously)
local essential_modules = {
	"config.options",    -- Core Neovim options (critical)
}

-- Load optional modules (can defer or fail gracefully)
local optional_modules = {
	"config.utils",      -- Utility functions
	"config.keymaps",    -- Key mappings
	"config.autocmds",   -- Auto commands
	"config.commands",   -- Custom commands
}

-- Load essential modules synchronously
for _, module in ipairs(essential_modules) do
	local ok, err = pcall(require, module)
	if not ok then
		-- Essential modules failing is critical
		vim.notify(
			string.format("CRITICAL: Failed to load essential module %s: %s", module, err),
			vim.log.levels.ERROR,
			{ title = "Configuration Error" }
		)
	end
end

-- Load optional modules asynchronously for better startup time
vim.defer_fn(function()
	for _, module in ipairs(optional_modules) do
		local ok, err = pcall(require, module)
		if not ok then
			-- Only show warning for optional modules
			vim.notify(
				string.format("Warning: Failed to load optional module %s: %s", module, err),
				vim.log.levels.WARN,
				{ title = "Configuration Warning" }
			)
		end
	end
end, 0) -- Load immediately but asynchronously

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Post-initialization Setup (Optimized)                                      │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Fast fallback options if config.options failed to load
if not pcall(require, "config.options") then
	-- Essential options only for faster startup
	vim.opt.number = true
	vim.opt.expandtab = true
	vim.opt.shiftwidth = 2
	vim.opt.tabstop = 2
	vim.opt.smartindent = true
	vim.opt.ignorecase = true
	vim.opt.smartcase = true
	vim.opt.updatetime = 250
	vim.opt.timeoutlen = 300
	vim.opt.termguicolors = true
end

-- Optimized colorscheme loading - only set after plugins are loaded
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	callback = function()
		-- Only set colorscheme if it's not already set
		if vim.g.colors_name == nil then
			-- Try to set catppuccin, fallback to default if needed
			local ok = pcall(vim.cmd.colorscheme, "catppuccin")
			if not ok then
				vim.cmd.colorscheme("default")
				vim.notify("Catppuccin not available, using default colorscheme", vim.log.levels.WARN)
			end
		end
	end,
})

-- Performance monitoring (optional, can be disabled in production)
if vim.env.NVIM_PROFILE then
	vim.api.nvim_create_autocmd("User", {
		pattern = "LazyDone", 
		callback = function()
			local elapsed = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000
			vim.notify(string.format("Neovim loaded in %.1fms", elapsed), vim.log.levels.INFO)
		end,
	})
end
