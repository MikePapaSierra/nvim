return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = true, -- Enable for VS Code-like Copilot Chat experience
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- Enable copilot.lua for better integration
            { "nvim-lua/plenary.nvim", branch = "master" },
            { "nvim-telescope/telescope.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            debug = false, -- Disable debug for production use
            show_help = true,
            question_header = "## User ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
            separator = " ",
            window = {
                layout = "vertical", -- VS Code-like vertical layout
                width = 0.35, -- Sidebar width similar to VS Code
                height = 0.8,
                relative = "editor",
                border = "rounded",
                title = " GitHub Copilot Chat ",
                footer = nil,
                zindex = 1,
            },
            chat = {
                welcome_message = "", -- Disable welcome message for clean startup
                question_header = "### You\n",
                answer_header = "### Copilot\n",
            },
            auto_follow_cursor = false,
            show_folds = true,
            highlight_selection = true,
            context = "buffers", -- Use buffer context like VS Code
            prompts = {
                -- Cloud Security Engineering focused prompts
                Explain = {
                    prompt = "/COPILOT_EXPLAIN\n\nWrite an explanation for the active selection as paragraphs of text.",
                },
                Review = {
                    prompt = "/COPILOT_REVIEW\n\nReview the selected code focusing on security, performance, and maintainability. Provide specific improvement suggestions.",
                },
                Fix = {
                    prompt = "/COPILOT_GENERATE\n\nThere is a problem in this code. Rewrite the code to show it with the bug fixed.",
                },
                Optimize = {
                    prompt = "/COPILOT_GENERATE\n\nOptimize the selected code for better performance and security. Focus on cloud security best practices.",
                },
                Docs = {
                    prompt = "/COPILOT_GENERATE\n\nPlease add documentation comments to the selected code. Include security considerations and usage examples.",
                },
                Tests = {
                    prompt = "/COPILOT_GENERATE\n\nPlease generate unit tests for the selected code. Include security and edge case testing.",
                },
                Commit = {
                    prompt = "Write a concise commit message for the changes using conventional commits format. Focus on security and functionality changes.",
                    selection = function(source)
                        return require("CopilotChat.select").gitdiff(source, false)
                    end,
                },
                CommitStaged = {
                    prompt = "Write a concise commit message for the staged changes using conventional commits format.",
                    selection = function(source)
                        return require("CopilotChat.select").gitdiff(source, true)
                    end,
                },
                SecurityReview = {
                    prompt = "Review this code for security vulnerabilities and provide recommendations for cloud security best practices.",
                    selection = function(source)
                        return require("CopilotChat.select").visual(source) or require("CopilotChat.select").buffer(source)
                    end,
                },
                CloudOptimize = {
                    prompt = "Optimize this code for cloud deployment. Consider performance, cost, security, and scalability.",
                    selection = function(source)
                        return require("CopilotChat.select").visual(source) or require("CopilotChat.select").buffer(source)
                    end,
                },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            local select = require("CopilotChat.select")
            
            -- Use buffer selection by default for better context
            opts.selection = select.buffer
            
            chat.setup(opts)

            -- VS Code-like commands
            vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
                chat.ask(args.args, { selection = select.visual })
            end, { nargs = "*", range = true })

            vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
                chat.ask(args.args, { selection = select.buffer })
            end, { nargs = "*", range = true })

            -- Inline floating chat (VS Code-like quick fix)
            vim.api.nvim_create_user_command("CopilotChatInline", function(args)
                chat.ask(args.args, {
                    selection = select.visual,
                    window = {
                        layout = "float",
                        relative = "cursor",
                        width = 0.8,
                        height = 0.6,
                        row = 1,
                        col = 0,
                        border = "rounded",
                        title = " Copilot Chat ",
                    },
                })
            end, { nargs = "*", range = true })

            -- Auto-format after applying suggestions (VS Code behavior)
            vim.api.nvim_create_autocmd("User", {
                pattern = "CopilotChatApply",
                callback = function()
                    vim.defer_fn(function()
                        if vim.bo.filetype ~= "" then
                            pcall(vim.lsp.buf.format, { async = false })
                        end
                    end, 100)
                end,
            })

            -- Set up VS Code-like sidebar behavior
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "copilot-chat",
                callback = function()
                    vim.opt_local.wrap = true
                    vim.opt_local.linebreak = true
                    vim.opt_local.showbreak = "↪ "
                    vim.opt_local.breakindent = true
                end,
            })
        end,
        event = "VeryLazy",
        keys = {
            -- VS Code-like Copilot Chat shortcuts
            { "<C-k><C-i>", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat" },
            { "<C-k><C-e>", ":CopilotChatExplain<cr>", mode = "v", desc = "Copilot Explain" },
            { "<C-k><C-r>", ":CopilotChatReview<cr>", mode = "v", desc = "Copilot Review" },
            { "<C-k><C-f>", ":CopilotChatFix<cr>", mode = "v", desc = "Copilot Fix" },
            { "<C-k><C-d>", ":CopilotChatDocs<cr>", mode = "v", desc = "Copilot Document" },
            { "<C-k><C-t>", ":CopilotChatTests<cr>", mode = "v", desc = "Copilot Tests" },
            
            -- Traditional keybindings
            {
                "<leader>cch",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
                end,
                desc = "CopilotChat - Help actions",
            },
            -- Show prompts actions with telescope
            {
                "<leader>ccp",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - Prompt actions",
            },
            -- Code related commands
            { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Copilot - Explain code" },
            { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Copilot - Generate tests" },
            { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "Copilot - Review code" },
            { "<leader>ccf", "<cmd>CopilotChatFix<cr>", desc = "Copilot - Fix code" },
            { "<leader>cco", "<cmd>CopilotChatOptimize<cr>", desc = "Copilot - Optimize code" },
            { "<leader>ccd", "<cmd>CopilotChatDocs<cr>", desc = "Copilot - Generate docs" },
            
            -- Cloud Security specific prompts
            { "<leader>ccs", "<cmd>CopilotChat SecurityReview<cr>", desc = "Copilot - Security Review" },
            { "<leader>ccC", "<cmd>CopilotChat CloudOptimize<cr>", desc = "Copilot - Cloud Optimize" },
            -- Chat with Copilot in visual mode
            {
                "<leader>ccv",
                ":CopilotChatVisual",
                mode = "x",
                desc = "Copilot - Chat with selection",
            },
            {
                "<leader>ccx",
                ":CopilotChatInline<cr>",
                mode = "x", 
                desc = "Copilot - Inline chat",
            },
            -- VS Code-like quick chat
            {
                "<leader>cci",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
                    end
                end,
                desc = "Copilot - Ask input",
            },
            -- Git integration
            {
                "<leader>ccm",
                "<cmd>CopilotChatCommit<cr>",
                desc = "Copilot - Generate commit message",
            },
            {
                "<leader>ccM",
                "<cmd>CopilotChatCommitStaged<cr>",
                desc = "Copilot - Generate commit for staged",
            },
            -- Quick actions
            {
                "<leader>ccq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then
                        require("CopilotChat").ask(input)
                    end
                end,
                desc = "Copilot - Quick chat",
            },
            -- Utility commands
            { "<leader>ccD", "<cmd>CopilotChatDebugInfo<cr>", desc = "Copilot - Debug Info" },
            { "<leader>ccl", "<cmd>CopilotChatReset<cr>", desc = "Copilot - Reset chat" },
            { "<leader>ccT", "<cmd>CopilotChatToggle<cr>", desc = "Copilot - Toggle chat" },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = true, -- Enable for VS Code-like inline suggestions
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<M-l>", -- Alt+l like VS Code
                    accept_word = false,
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<M-CR>",
                },
                layout = {
                    position = "bottom", -- VS Code-like bottom panel
                    ratio = 0.4,
                },
            },
            server_opts_overrides = {},
        },
    },
}
