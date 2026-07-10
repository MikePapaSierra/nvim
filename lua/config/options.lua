-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Enhanced Core Neovim Options for Cloud Security Engineering                │
-- │ Professional settings optimized for modern development workflows           │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Core Editor Settings                                                        │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Encoding and character handling
vim.opt.encoding = "utf-8"               -- Set default encoding
vim.scriptencoding = "utf-8"             -- Script encoding
vim.opt.fileencoding = "utf-8"           -- File encoding
vim.opt.iskeyword:append("-")            -- Consider - as part of keyword

-- Line numbers and display
vim.opt.number = true                    -- Show absolute line numbers
vim.opt.relativenumber = true            -- Show relative line numbers
vim.opt.signcolumn = "yes"               -- Always show sign column
vim.opt.colorcolumn = "88"               -- Highlight column at 88 characters
vim.opt.cursorline = true                -- Highlight current line
vim.opt.showmode = false                 -- Don't show mode (we have statusline)
vim.opt.title = true                     -- Set window title

-- Indentation and formatting
vim.opt.expandtab = true                 -- Use spaces instead of tabs
vim.opt.shiftwidth = 2                   -- Size of an indent
vim.opt.tabstop = 2                      -- Number of spaces tabs count for
vim.opt.softtabstop = 2                  -- Number of spaces tabs count for in insert mode
vim.opt.smartindent = true               -- Smart autoindenting
vim.opt.autoindent = true                -- Copy indent from current line
vim.opt.shiftround = true                -- Round indent to multiple of shiftwidth
vim.opt.smarttab = true                  -- Smart tab handling

-- Text behavior
vim.opt.wrap = false                     -- Don't wrap lines
vim.opt.linebreak = true                 -- Break lines at word boundaries
vim.opt.breakindent = true               -- Preserve indentation in wrapped text
vim.opt.textwidth = 0                    -- No automatic line breaking
vim.opt.formatoptions:remove("t")        -- Don't auto-wrap text using textwidth

-- Search settings
vim.opt.ignorecase = true                -- Ignore case in search
vim.opt.smartcase = true                 -- Override ignorecase if search contains uppercase
vim.opt.hlsearch = true                  -- Highlight search matches
vim.opt.incsearch = true                 -- Show search matches as you type
vim.opt.gdefault = true                  -- Add g flag to search/replace by default

-- Performance and responsiveness
vim.opt.updatetime = 250                 -- Faster completion (default 4000ms)
vim.opt.timeoutlen = 300                 -- Faster which-key popup (default 1000ms)
vim.opt.redrawtime = 10000               -- More time for syntax highlighting large files
vim.opt.synmaxcol = 500                  -- Don't highlight very long lines
vim.opt.lazyredraw = false               -- Don't redraw during macros (can cause issues)

-- File handling
vim.opt.backup = false                   -- Don't create backup files
vim.opt.writebackup = false              -- Don't create backup before overwriting
vim.opt.swapfile = false                 -- Don't create swap files
vim.opt.undofile = true                  -- Enable persistent undo
vim.opt.undolevels = 10000               -- Maximum number of undos
vim.opt.undoreload = 10000               -- Maximum lines to save for undo on buffer reload

-- Window and buffer behavior  
vim.opt.splitbelow = true                -- Horizontal splits go below
vim.opt.splitright = true               -- Vertical splits go right
vim.opt.switchbuf = "useopen,usetab"     -- Use existing windows/tabs when switching buffers
vim.opt.hidden = true                    -- Allow hidden buffers with unsaved changes
vim.opt.confirm = true                   -- Ask for confirmation instead of error

-- Visual and UI settings
vim.opt.termguicolors = true             -- Enable 24-bit RGB color
vim.opt.background = "dark"              -- Dark background
vim.opt.pumheight = 10                   -- Maximum items in popup menu (reduced for better UX)
vim.opt.pumblend = 0                     -- Disable popup transparency for better readability
vim.opt.winblend = 0                     -- Window transparency (0 = opaque)
vim.opt.cmdheight = 1                    -- Height of command line
vim.opt.showtabline = 2                  -- Always show tabline
vim.opt.laststatus = 2                   -- Always show statusline (per window)
vim.opt.clipboard = "unnamedplus"        -- Use system clipboard

-- Scrolling and movement
vim.opt.scrolloff = 10                   -- Keep 10 lines above/below cursor (increased for better context)
vim.opt.sidescrolloff = 8                -- Keep 8 columns left/right of cursor
vim.opt.smoothscroll = true              -- Smooth scrolling for wrapped lines

-- Completion and wildmenu
vim.opt.wildmode = "list:longest,full"   -- Show list, then complete longest common match, then full completion on Tab
vim.opt.wildmenu = true                  -- Enhanced command line completion
vim.opt.wildoptions = "pum"              -- Use popup menu for wildmenu completions
vim.opt.wildignore:append({
	"*.o", "*.obj", "*.dylib", "*.bin", "*.dll", "*.exe",
	"*/.git/*", "*/.svn/*", "*/__pycache__/*", "*/node_modules/*",
	"*.jpg", "*.png", "*.jpeg", "*.gif", "*.ico", "*.pdf",
	"*.avi", "*.mkv", "*.mp4", "*.mp3"
})
vim.opt.completeopt = "menu,menuone,noselect" -- Completion options

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Security and Privacy Settings                                               │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Security settings for cloud security engineering
vim.opt.modeline = false                 -- Disable modelines for security
vim.opt.exrc = false                     -- Don't load local config files
vim.opt.secure = true                    -- Secure mode for shell commands

-- Privacy settings
vim.opt.viminfo = ""                     -- Don't save command history
vim.opt.history = 0                      -- Don't save command history

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Cloud Security Engineering Specific Settings                                │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- File type specific settings for cloud configs
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "yaml", "yml" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.conceallevel = 0  -- Don't hide quotes in JSON
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "terraform" },
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.commentstring = "# %s"
	end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Advanced Editor Features                                                    │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Enhanced diff settings
vim.opt.diffopt:append("linematch:60")   -- Better diff algorithm
vim.opt.diffopt:append("algorithm:patience")

-- Better display for messages
vim.opt.shortmess:append("c")            -- Don't show completion messages
vim.opt.shortmess:append("I")            -- Don't show intro message
vim.opt.shortmess:append("W")            -- Don't show "written" when writing

-- Mouse support
vim.opt.mouse = "a"                      -- Enable mouse in all modes
vim.opt.mousemodel = "popup"             -- Right click opens popup menu

-- File explorer (disable netrw for nvim-tree)
vim.g.loaded_netrw = 1                   -- Disable netrw
vim.g.loaded_netrwPlugin = 1             -- Disable netrw plugin

-- Whitespace visualization
vim.opt.listchars = "space:.,tab:> ,trail:-,eol:↴"  -- Configure visible whitespace
vim.opt.list = true                      -- Show whitespace characters

-- Obsidian plugin settings
vim.opt.conceallevel = 1                 -- Conceal level for obsidian markdown

-- Cursor styling
vim.opt.guicursor = {
	"n-v-c:block",                       -- Normal, visual, command modes: block cursor
	"i-ci-ve:ver25",                     -- Insert modes: vertical line cursor
	"r-cr:hor20",                        -- Replace modes: horizontal line cursor
	"o:hor50",                           -- Operator-pending: horizontal line cursor
	"a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",  -- All modes: blinking
	"sm:block-blinkwait175-blinkoff150-blinkon175",          -- Showmatch: block cursor
}

-- Spell checking
vim.opt.spell = false                    -- Disable spell checking by default
vim.opt.spelllang = "en_us"              -- Use US English for spell checking

-- Folding
vim.opt.foldmethod = "expr"              -- Use expression folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"  -- Use treesitter for folding
vim.opt.foldlevel = 99                   -- Start with all folds open
vim.opt.foldlevelstart = 99              -- Start with all folds open

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Performance Optimizations                                                   │ 
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Optimize for large files
vim.g.large_file = 1024 * 1024 * 1.5    -- 1.5MB

vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function()
		local file_size = vim.fn.getfsize(vim.fn.expand("<afile>"))
		if file_size > vim.g.large_file then
			vim.opt_local.foldmethod = "manual"
			vim.opt_local.syntax = "off"
			vim.opt_local.swapfile = false
			vim.opt_local.undofile = false
			vim.opt_local.loadplugins = false
			vim.cmd("syntax clear")
		end
	end,
})

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Global Variables and Providers                                              │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Theme settings
vim.g.catppuccin_flavour = "mocha"       -- Set Catppuccin flavour globally

-- Disable unused providers for faster startup
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Python provider (keep enabled for plugins that need it)
if vim.fn.executable("python3") == 1 then
	vim.g.python3_host_prog = vim.fn.exepath("python3")
else
	vim.g.loaded_python3_provider = 0
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Diagnostic Configuration                                                    │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Enhanced diagnostic display
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		spacing = 2,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

-- Diagnostic signs
local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ AI Integration Startup Optimization                                         │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- Disable AI plugin startup notifications for clean experience
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	callback = function()
		-- Suppress AI plugin startup messages
		local suppress_patterns = {
			"Copilot.*enabled",
			"Copilot.*ready",
			"Copilot.*loaded",
			"Avante.*loaded",
			"Avante.*ready",
			"Avante.*assistant.*ready",
			"ChatGPT.*configured",
			"ChatGPT.*ready",
			"AI.*integration.*ready",
			".*AI.*ready",
			".*assistant.*ready",
			"GitHub.*Copilot.*ready",
		}
		
		-- Override notify for AI plugin messages
		local original_notify = vim.notify
		vim.notify = function(msg, level, opts)
			if type(msg) == "string" then
				for _, pattern in ipairs(suppress_patterns) do
					if msg:match(pattern) then
						return -- Suppress AI startup notifications
					end
				end
			end
			return original_notify(msg, level, opts)
		end
		
		-- Restore original notify after 2 seconds
		vim.defer_fn(function()
			vim.notify = original_notify
		end, 2000)
	end,
})

-- Create VS Code-like command palette entries for AI features
vim.api.nvim_create_user_command("AIChat", function()
	if vim.fn.exists(":AvanteAsk") == 2 then
		vim.cmd("AvanteAsk")
	elseif vim.fn.exists(":CopilotChatToggle") == 2 then
		vim.cmd("CopilotChatToggle")
	else
		vim.notify("No AI chat available", vim.log.levels.WARN)
	end
end, { desc = "Open AI Chat (VS Code-like)" })

vim.api.nvim_create_user_command("AIExplain", function()
	if vim.api.nvim_get_mode().mode == "v" then
		vim.cmd("CopilotChatExplain")
	else
		vim.notify("Select code to explain", vim.log.levels.INFO)
	end
end, { desc = "Explain selected code with AI" })

vim.api.nvim_create_user_command("AIReview", function()
	if vim.api.nvim_get_mode().mode == "v" then
		vim.cmd("CopilotChatReview")
	else
		vim.cmd("CopilotChatBuffer Review this code for security and best practices")
	end
end, { desc = "Review code with AI" })
