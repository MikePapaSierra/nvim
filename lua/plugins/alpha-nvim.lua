return {
    'goolord/alpha-nvim',
    lazy = false, -- Load immediately for better startup experience
    priority = 998, -- High priority but after theme
    dependencies = { 
        'nvim-tree/nvim-web-devicons',
        'catppuccin/nvim', -- Ensure theme is loaded first
    },
    config = function()
        local alpha = require('alpha')
        local startify = require('alpha.themes.startify')

        -- Enhanced ASCII header with MPS branding
        startify.section.header.val = {
            "",
            "   ███╗   ███╗██████╗ ███████╗",
            "   ████╗ ████║██╔══██╗██╔════╝",
            "   ██╔████╔██║██████╔╝███████╗",
            "   ██║╚██╔╝██║██╔═══╝ ╚════██║",
            "   ██║ ╚═╝ ██║██║     ███████║",
            "   ╚═╝     ╚═╝╚═╝     ╚══════╝",
            "",
        }

        -- Enhanced header highlighting with Catppuccin integration
        startify.section.header.opts.hl = "AlphaHeader"
        startify.section.header.opts.position = "center"

        -- Enhanced button creation with better icons and functionality
        local function create_button(sc, txt, keybind, keybind_opts)
            local button = startify.button(sc, txt, keybind, keybind_opts)
            button.opts.hl = "AlphaButtons"
            button.opts.hl_shortcut = "AlphaShortcut"
            button.opts.position = "center"
            button.opts.width = 50
            return button
        end

        -- Enhanced section for quick actions with modern icons
        startify.section.bottom_buttons = {
            type = "group",
            val = {
                create_button("e", "  New File", "<cmd>ene<CR>"),
                create_button("f", "󰈞  Find Files", "<cmd>Telescope find_files<CR>"),
                create_button("r", "  Recent Files", "<cmd>Telescope oldfiles<CR>"),
                create_button("w", "  Find Word", "<cmd>Telescope live_grep<CR>"),
                create_button("b", "  Browse Files", "<cmd>Telescope file_browser<CR>"),
                create_button("c", "  Configuration", "<cmd>edit ~/.config/nvim/init.lua<CR>"),
                create_button("s", "  Sessions", "<cmd>Telescope session-lens search_session<CR>"),
                create_button("l", "󰒲  Lazy Manager", "<cmd>Lazy<CR>"),
                create_button("m", "  Mason LSP", "<cmd>Mason<CR>"),
                create_button("h", "  Health Check", "<cmd>checkhealth<CR>"),
                create_button("q", "󰅚  Quit Neovim", "<cmd>qa<CR>"),
            },
            opts = {
                spacing = 1,
                position = "center",
            }
        }

        -- Enhanced footer with comprehensive system information
        local function get_footer()
            local lazy_ok, lazy = pcall(require, "lazy")
            local stats = lazy_ok and lazy.stats() or { loaded = 0, count = 0 }
            
            -- Get actual startup time
            local startup_time = ""
            if vim.g.start_time then
                -- Use our captured start time
                local elapsed = vim.fn.reltimefloat(vim.fn.reltime(vim.g.start_time)) * 1000
                startup_time = string.format("⚡ %.1fms", elapsed)
            elseif lazy_ok and stats.startuptime and stats.startuptime > 0 then
                startup_time = string.format("⚡ %.1fms", stats.startuptime)
            else
                -- Fallback: estimate from current time
                local estimated_time = vim.loop.hrtime() / 1000000 -- Convert to ms
                if estimated_time < 10000 then -- Only if reasonable (less than 10 seconds)
                    startup_time = string.format("⚡ ~%.0fms", estimated_time)
                else
                    startup_time = "⚡ Ready"
                end
            end
            
            -- Get Neovim version
            local version = vim.version()
            local nvim_version = string.format("󰀘 v%d.%d.%d", version.major, version.minor, version.patch)
            
            -- Plugin information
            local plugin_info = string.format("🔌 %d plugins loaded", stats.loaded or 0)
            
            -- Git branch info if in a git repo
            local git_branch = ""
            local git_cmd = vim.fn.system("git branch --show-current 2>/dev/null")
            if vim.v.shell_error == 0 and git_cmd ~= "" then
                git_branch = " │ 🌿 " .. git_cmd:gsub("\n", "")
            end
            
            -- Compose footer lines (removed date)
            local footer_lines = {
                "",
                nvim_version .. " │ " .. plugin_info .. " │ " .. startup_time .. git_branch,
                "",
                "💡 Tip: Press 'f' to find files, 'r' for recent files, 'q' to quit",
            }
            
            return footer_lines
        end

        startify.section.footer = {
            type = "text",
            val = get_footer(),
            opts = {
                position = "center",
                hl = "AlphaFooter",
            }
        }

        -- Configure the layout with responsive design
        local function get_header_padding()
            local height = vim.fn.winheight(0)
            return math.max(1, math.floor((height - 35) / 2))
        end

        startify.config.layout = {
            { type = "padding", val = get_header_padding },
            startify.section.header,
            { type = "padding", val = 2 },
            startify.section.bottom_buttons,
            { type = "padding", val = 2 },
            startify.section.footer,
        }

        -- Enhanced window options with Catppuccin integration
        startify.config.opts = {
            margin = 5,
            redraw_on_resize = true,
            setup = function()
                -- Enhanced highlight groups that sync with Catppuccin
                vim.cmd([[
                    augroup alpha_catppuccin
                        autocmd!
                        autocmd ColorScheme * hi! link AlphaHeader Function
                        autocmd ColorScheme * hi! link AlphaButtons String  
                        autocmd ColorScheme * hi! link AlphaShortcut Keyword
                        autocmd ColorScheme * hi! link AlphaFooter Comment
                    augroup END
                    
                    " Apply immediately
                    hi! link AlphaHeader Function
                    hi! link AlphaButtons String
                    hi! link AlphaShortcut Keyword  
                    hi! link AlphaFooter Comment
                ]])
            end,
        }

        -- Enhanced UI management for clean dashboard experience
        vim.api.nvim_create_autocmd("User", {
            pattern = "AlphaReady",
            desc = "Disable status and tabline for Alpha",
            callback = function()
                vim.opt.showtabline = 0
                vim.opt.laststatus = 0
                vim.opt.ruler = false
                vim.opt.showcmd = false
                vim.opt.showmode = false
                -- Hide cursor line for cleaner look
                vim.opt.cursorline = false
                -- Disable line numbers for dashboard
                vim.opt.number = false
                vim.opt.relativenumber = false
                vim.opt.signcolumn = "no"
            end,
        })

        vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            desc = "Restore UI elements when leaving Alpha",
            callback = function()
                vim.opt.showtabline = 2
                vim.opt.laststatus = 3
                vim.opt.ruler = true
                vim.opt.showcmd = true
                vim.opt.showmode = true
                vim.opt.cursorline = true
                vim.opt.number = true
                vim.opt.relativenumber = true
                vim.opt.signcolumn = "yes"
            end,
        })

        -- Setup alpha with enhanced configuration
        alpha.setup(startify.config)
        
        -- Add keyboard shortcuts for common actions
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "alpha",
            callback = function()
                local opts = { buffer = true, silent = true }
                vim.keymap.set("n", "u", "<cmd>Lazy update<CR>", opts)
                vim.keymap.set("n", "i", "<cmd>Lazy install<CR>", opts) 
                vim.keymap.set("n", "x", "<cmd>Lazy clean<CR>", opts)
                vim.keymap.set("n", "<C-c>", "<cmd>qa<CR>", opts)
            end,
        })
    end,
}
