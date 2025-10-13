return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false, -- Load immediately on startup
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/personalObsidianVault",
            },
        },
        
        -- Daily notes configuration
        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "dailies",
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = "%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            alias_format = "%B %-d, %Y",
            -- Optional, default tags to add to each new daily note created.
            default_tags = { "daily-notes" },
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = "TPL_Daily.md"
        },

        -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
        completion = {
            nvim_cmp = true,
            min_chars = 2,
        },

        -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
        -- way then set 'mappings = {}'.
        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
            -- Smart action depending on context, either follow link or toggle checkbox.
            ["<cr>"] = {
                action = function()
                    return require("obsidian").util.smart_action()
                end,
                opts = { buffer = true, expr = true },
            }
        },

        -- Where to put new notes. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "notes_subdir",

        -- Optional, customize how note IDs are generated given an optional title.
        ---@param title string|?
        ---@return string
        note_id_func = function(title)
            -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
            -- In this case a note with the title 'My new note' will be given an ID that looks
            -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
            local suffix = ""
            if title ~= nil then
                -- If title is given, transform it into valid file name.
                suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
                -- If title is nil, just add 4 random uppercase letters to the suffix.
                for _ = 1, 4 do
                    suffix = suffix .. string.char(math.random(65, 90))
                end
            end
            return tostring(os.time()) .. "-" .. suffix
        end,

        -- Optional, customize how note file names are generated given the ID, target directory, and title.
        ---@param spec { id: string, dir: obsidian.Path, title: string|? }
        ---@return string|obsidian.Path The full path to the new note.
        note_path_func = function(spec)
            -- This is equivalent to the default behavior.
            local path = spec.dir / tostring(spec.id)
            return path:with_suffix(".md")
        end,

        -- Optional, customize how wiki links are formatted. You can set this to one of:
        --  * "use_alias_only", e.g. '[[Foo Bar]]'
        --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
        --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
        --  * "use_path_only", e.g. '[[foo-bar.md]]'
        -- Or you can set it to a function that takes a table with the following fields:
        -- - path: string, the absolute path to the note
        -- - ref: string, the reference text
        -- - label: string|nil, the label text (if any)
        -- See "Follow links" section below for more info.
        wiki_link_func = "use_alias_only",

        -- Optional, alternatively you can customize the frontmatter data.
        ---@return table
        note_frontmatter_func = function(note)
            -- Add the title of the note as an alias.
            if note.title then
                note:add_alias(note.title)
            end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,

        -- Optional, for templates (see below).
        templates = {
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            -- A map for custom variables, the key should be the variable and the value a function
            substitutions = {
                yesterday = function()
                    return os.date("%Y-%m-%d", os.time() - 86400)
                end,
                tomorrow = function()  
                    return os.date("%Y-%m-%d", os.time() + 86400)
                end,
            },
        },
    },
    config = function(_, opts)
        -- Ensure the workspace path is expanded
        for _, workspace in ipairs(opts.workspaces) do
            workspace.path = vim.fn.expand(workspace.path)
        end
        
        -- Setup obsidian with error handling
        local ok, err = pcall(require("obsidian").setup, opts)
        if not ok then
            vim.notify("Obsidian setup failed: " .. tostring(err), vim.log.levels.ERROR)
            return
        end
        
        -- Set up keybindings
        vim.keymap.set("n", "<leader>nt", "<cmd>ObsidianToday<cr>", { desc = "Create/Open today's note" })
        vim.keymap.set("n", "<leader>ny", "<cmd>ObsidianYesterday<cr>", { desc = "Create/Open yesterday's note" })
        vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianNew<cr>", { desc = "Create new note" })
        vim.keymap.set("n", "<leader>nf", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Find notes" })
        vim.keymap.set("n", "<leader>ns", "<cmd>ObsidianSearch<cr>", { desc = "Search in notes" })
        vim.keymap.set("n", "<leader>nb", "<cmd>ObsidianBacklinks<cr>", { desc = "Show backlinks" })
        vim.keymap.set("n", "<leader>nl", "<cmd>ObsidianLinks<cr>", { desc = "Show links" })
        vim.keymap.set("n", "<leader>nO", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian app" })
        
        -- Create custom command 'nt' for creating today's note
        vim.api.nvim_create_user_command("Nt", function()
            vim.cmd("ObsidianToday")
        end, { desc = "Create/Open today's note" })
        
        -- Verify template exists
        local template_path = vim.fn.expand("~/Documents/personalObsidianVault/templates/TPL_Daily.md")
        if vim.fn.filereadable(template_path) == 0 then
            vim.notify("Warning: Daily template not found at " .. template_path, vim.log.levels.WARN)
        else
            vim.notify("Obsidian.nvim loaded successfully with template: " .. template_path, vim.log.levels.INFO)
        end
    end,
}
