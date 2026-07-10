return {
    "nvim-lualine/lualine.nvim",
    lazy = false, -- Load immediately to ensure status line appears
    priority = 990, -- Load after catppuccin (which has priority 1000)
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "catppuccin/nvim", -- Ensure Catppuccin is loaded first
    },
    config = function()
        -- Small delay to ensure catppuccin is fully loaded
        vim.defer_fn(function()
            -- Ensure statusline is available for lualine
            vim.opt.laststatus = 3 -- Global statusline
            vim.opt.statusline = "" -- Clear any existing statusline
        
        -- Safely get Catppuccin colors for custom components
        local catppuccin_colors = {}
        local ok, catppuccin = pcall(require, "catppuccin.palettes")
        if ok then
            catppuccin_colors = catppuccin.get_palette("mocha")
        else
            -- Fallback colors if Catppuccin isn't available
            catppuccin_colors = {
                text = "#cdd6f4",
                subtext1 = "#bac2de", 
                subtext0 = "#a6adc8",
                overlay1 = "#7f849c",
                blue = "#89b4fa",
                lavender = "#b4befe",
                green = "#a6e3a1",
                peach = "#fab387",
                yellow = "#f9e2af",
                red = "#f38ba8",
                pink = "#f5c2e7",
                mauve = "#cba6f7",
            }
        end
        
        -- Enhanced custom components with Catppuccin integration
        local function get_lsp_clients()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
                return "No LSP"
            end
            local names = {}
            for _, client in ipairs(clients) do
                -- Skip null-ls and other utility clients in display
                if client.name ~= "null-ls" and client.name ~= "copilot" then
                    table.insert(names, client.name)
                end
            end
            if #names == 0 then
                return "No LSP"
            end
            return " " .. table.concat(names, ", ")
        end

        local function get_total_lines()
            return vim.fn.line('$')
        end

        local function get_file_size()
            local size = vim.fn.getfsize(vim.fn.expand('%:p'))
            if size <= 0 then return '' end
            local units = {'B', 'KB', 'MB', 'GB'}
            local i = 1
            while size > 1024 and i < #units do
                size = size / 1024
                i = i + 1
            end
            return string.format('%.1f%s', size, units[i])
        end

        local function get_python_env()
            if vim.bo.filetype ~= 'python' then
                return ''
            end
            local venv = vim.env.VIRTUAL_ENV
            if venv then
                return ' ' .. vim.fn.fnamemodify(venv, ':t')
            end
            return ''
        end

        -- Enhanced Git status with proper icons
        local function get_git_status()
            local git_info = vim.b.gitsigns_status_dict
            if not git_info or git_info.head == "" then
                return ""
            end
            local added = git_info.added and git_info.added ~= 0 and ("+" .. git_info.added) or ""
            local modified = git_info.changed and git_info.changed ~= 0 and ("~" .. git_info.changed) or ""
            local removed = git_info.removed and git_info.removed ~= 0 and ("-" .. git_info.removed) or ""
            return string.format(" %s %s %s %s", git_info.head, added, modified, removed):gsub("%s+", " "):trim()
        end

        -- Working directory with better formatting
        local function get_project_dir()
            local cwd = vim.fn.getcwd()
            local project_name = vim.fn.fnamemodify(cwd, ":t")
            -- Check if we're in a git repository
            local git_dir = vim.fn.finddir(".git", cwd .. ";")
            if git_dir ~= "" then
                return "  " .. project_name
            else
                return " 📁 " .. project_name
            end
        end

        -- Enhanced mode display with better formatting
        local function get_mode_display()
            local mode = vim.fn.mode()
            local mode_map = {
                ['n'] = 'NORMAL',
                ['i'] = 'INSERT',
                ['v'] = 'VISUAL',
                ['V'] = 'V-LINE',
                [''] = 'V-BLOCK',
                ['c'] = 'COMMAND',
                ['s'] = 'SELECT',
                ['S'] = 'S-LINE',
                [''] = 'S-BLOCK',
                ['r'] = 'REPLACE',
                ['R'] = 'REPLACE',
                ['t'] = 'TERMINAL',
            }
            return mode_map[mode] or mode:upper()
        end

        -- LSP progress indicator
        local function get_lsp_progress()
            local messages = vim.lsp.util.get_progress_messages()
            if #messages == 0 then
                return ""
            end
            local status = {}
            for _, msg in pairs(messages) do
                table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
            end
            return " " .. table.concat(status, " | ")
        end

        -- Enhanced diagnostics with Catppuccin colors
        local function get_diagnostics_count()
            local diagnostics = vim.diagnostic.get(0)
            local count = { error = 0, warn = 0, info = 0, hint = 0 }
            for _, diagnostic in ipairs(diagnostics) do
                local severity = diagnostic.severity
                if severity == vim.diagnostic.severity.ERROR then
                    count.error = count.error + 1
                elseif severity == vim.diagnostic.severity.WARN then
                    count.warn = count.warn + 1
                elseif severity == vim.diagnostic.severity.INFO then
                    count.info = count.info + 1
                elseif severity == vim.diagnostic.severity.HINT then
                    count.hint = count.hint + 1
                end
            end
            local result = {}
            if count.error > 0 then table.insert(result, " " .. count.error) end
            if count.warn > 0 then table.insert(result, " " .. count.warn) end
            if count.info > 0 then table.insert(result, " " .. count.info) end
            if count.hint > 0 then table.insert(result, " " .. count.hint) end
            return table.concat(result, " ")
        end

        -- Determine theme - check if catppuccin is available
        local theme = "auto" -- Default fallback
        local catppuccin_ok = pcall(require, "catppuccin")
        if catppuccin_ok then
            -- Check if catppuccin lualine theme is available
            local lualine_theme_ok = pcall(require, "lualine.themes.catppuccin")
            if lualine_theme_ok then
                theme = "catppuccin"
            end
        end

        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = theme, -- Use detected theme
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                disabled_filetypes = {
                    statusline = { "dashboard", "alpha", "starter" },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true, -- Use global statusline for cleaner look
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = { 'lazy', 'mason' }
        })

        -- Auto-refresh lualine when LSP clients change
        vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach" }, {
            callback = function()
                require("lualine").refresh()
            end,
        })

        -- Auto-refresh on git changes
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "GitSignsUpdate",
            callback = function()
                require("lualine").refresh()
            end,
        })
        end, 50) -- 50ms delay to ensure catppuccin is loaded
    end,
}
