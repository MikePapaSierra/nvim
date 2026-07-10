return {
    "jackMort/ChatGPT.nvim",
    enabled = true, -- Enable for enhanced AI capabilities
    event = "VeryLazy",
    keys = {
        -- VS Code-like AI commands
        { "<leader>gpt", "<cmd>ChatGPT<cr>", desc = "ChatGPT: Open Chat" },
        { "<leader>gpe", "<cmd>ChatGPTEditWithInstructions<cr>", mode = { "n", "v" }, desc = "ChatGPT: Edit with Instructions" },
        { "<leader>gpd", "<cmd>ChatGPTRun docstring<cr>", mode = { "n", "v" }, desc = "ChatGPT: Generate Docstring" },
        { "<leader>gpr", "<cmd>ChatGPTRun code_readability_analysis<cr>", mode = { "n", "v" }, desc = "ChatGPT: Code Review" },
        { "<leader>gpt", "<cmd>ChatGPTRun translate<cr>", mode = { "n", "v" }, desc = "ChatGPT: Translate" },
        { "<leader>gpf", "<cmd>ChatGPTRun fix_bugs<cr>", mode = { "n", "v" }, desc = "ChatGPT: Fix Bugs" },
        { "<leader>gpo", "<cmd>ChatGPTRun optimize_code<cr>", mode = { "n", "v" }, desc = "ChatGPT: Optimize Code" },
        { "<leader>gps", "<cmd>ChatGPTRun summarize<cr>", mode = { "n", "v" }, desc = "ChatGPT: Summarize" },
        { "<leader>gpx", "<cmd>ChatGPTRun explain_code<cr>", mode = { "n", "v" }, desc = "ChatGPT: Explain Code" },
    },
    config = function()
        local ok, chatgpt = pcall(require, "chatgpt")
        if not ok then
            vim.notify("Failed to load ChatGPT plugin", vim.log.levels.ERROR)
            return
        end
        
        -- Smart API key management with 1Password integration
        local function get_api_key_with_guidance()
            -- Check if 1Password CLI is available
            local op_available = vim.fn.executable("op") == 1
            if not op_available then
                -- Fallback to environment variable
                local env_key = os.getenv("OPENAI_API_KEY")
                if env_key and env_key ~= "" then
                    return env_key
                end
                return nil
            end
            
            -- Test 1Password signin status
            local signin_test = vim.fn.system("op account list 2>/dev/null")
            if vim.v.shell_error ~= 0 then
                -- Not signed in - return nil to defer setup
                return nil
            end
            
            -- Try to get the API key
            local api_key = vim.fn.system("op read 'op://Private/ChatGPT/nvimAPIKey' --no-newline 2>/dev/null")
            if vim.v.shell_error == 0 and api_key and api_key ~= "" then
                return api_key
            end
            
            -- If we reach here, 1Password is signed in but secret not found
            return nil
        end
        
        -- Function to prompt user for signin and retry
        local function prompt_signin_and_retry()
            vim.ui.select(
                {
                    "Sign in to 1Password",
                    "Use environment variable ($OPENAI_API_KEY)",
                    "Cancel"
                },
                {
                    prompt = "ChatGPT API Key not available. How would you like to proceed?",
                    format_item = function(item)
                        return "  " .. item
                    end
                },
                function(choice)
                    if choice == "Sign in to 1Password" then
                        vim.notify("Please run: eval $(op signin)", vim.log.levels.INFO, {
                            title = "🔐 1Password Signin Required"
                        })
                        vim.notify("Then restart Neovim or run :ChatGPTSetup", vim.log.levels.INFO)
                    elseif choice == "Use environment variable ($OPENAI_API_KEY)" then
                        local env_key = os.getenv("OPENAI_API_KEY")
                        if env_key and env_key ~= "" then
                            vim.notify("Using OPENAI_API_KEY environment variable", vim.log.levels.INFO)
                            -- Re-setup ChatGPT with env variable
                            local setup_ok, err = pcall(chatgpt.setup, get_chatgpt_config(env_key))
                            if not setup_ok then
                                vim.notify("ChatGPT setup failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
                            else
                                vim.notify("✅ ChatGPT configured successfully!", vim.log.levels.INFO, {
                                    title = "ChatGPT Ready"
                                })
                            end
                        else
                            vim.notify("OPENAI_API_KEY not found in environment", vim.log.levels.WARN)
                            vim.notify("Set it with: export OPENAI_API_KEY='your-key'", vim.log.levels.INFO)
                        end
                    end
                end
            )
        end
        
        -- Configuration generator
        local function get_chatgpt_config(api_key)
            return {
                api_key_cmd = api_key and ("echo '" .. api_key .. "'") or nil,
                openai_params = {
                    model = "gpt-4o", -- Latest GPT-4 model
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    max_tokens = 4096,
                    temperature = 0.1, -- Lower temperature for more focused responses
                    top_p = 0.9, -- Better balance for code generation
                    n = 1,
                },
                openai_edit_params = {
                    model = "gpt-4o",
                    frequency_penalty = 0,
                    presence_penalty = 0,
                    temperature = 0,
                    top_p = 1.0,
                    n = 1,
                },
                use_openai_functions_for_edits = true,
                actions_paths = { vim.fn.stdpath("config") .. "/lua/config/chatgpt-actions.json" },
                show_quickfixes_cmd = "Trouble quickfix",
                predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
                chat = {
                    welcome_message = "ChatGPT for Cloud Security Engineering",
                    loading_text = "Loading...",
                    question_sign = "U", -- Single character for valid sign text
                    answer_sign = "G", -- Single character for valid sign text
                    border_left_sign = "|",
                    border_right_sign = "|",
                    max_line_length = 120,
                    sessions_window = {
                        active_sign = "*", -- Single character for valid sign
                        inactive_sign = "-", -- Single character for valid sign
                        current_line_sign = "",
                        border = {
                            style = "rounded",
                            text = {
                                top = " Sessions ",
                            },
                        },
                        win_options = {
                            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                        },
                    },
                    keymaps = {
                        close = "<C-c>",
                        yank_last = "<C-y>",
                        yank_last_code = "<C-k>",
                        scroll_up = "<C-u>",
                        scroll_down = "<C-d>",
                        new_session = "<C-n>",
                        cycle_windows = "<Tab>",
                        cycle_modes = "<C-f>",
                        next_message = "<C-j>",
                        prev_message = "<C-k>",
                        select_session = "<Space>",
                        rename_session = "r",
                        delete_session = "d",
                        draft_message = "<C-r>",
                        edit_message = "e",
                        delete_message = "d",
                        toggle_settings = "<C-o>",
                        toggle_sessions = "<C-p>",
                        toggle_help = "<C-h>",
                        toggle_message_role = "<C-r>",
                        toggle_system_role_open = "<C-s>",
                        stop_generating = "<C-x>",
                    },
                },
                popup_layout = {
                    default = "center",
                    center = {
                        width = "80%",
                        height = "80%",
                    },
                    right = {
                        width = "30%",
                        width_settings_open = "50%",
                    },
                },
                popup_window = {
                    border = {
                        highlight = "FloatBorder",
                        style = "rounded",
                        text = {
                            top = " ChatGPT ",
                        },
                    },
                    win_options = {
                        wrap = true,
                        linebreak = true,
                        foldcolumn = "1",
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                    buf_options = {
                        filetype = "markdown",
                    },
                },
                system_window = {
                    border = {
                        highlight = "FloatBorder",
                        style = "rounded",
                        text = {
                            top = " SYSTEM ",
                        },
                    },
                    win_options = {
                        wrap = true,
                        linebreak = true,
                        foldcolumn = "2",
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                },
                popup_input = {
                    prompt = "  ",
                    border = {
                        highlight = "FloatBorder",
                        style = "rounded",
                        text = {
                            top_align = "center",
                            top = " Prompt ",
                        },
                    },
                    win_options = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                    submit = "<C-Enter>",
                    submit_n = "<Enter>",
                    max_visible_lines = 20,
                },
                settings_window = {
                    setting_sign = ">", -- Single character for valid sign
                    border = {
                        style = "rounded",
                        text = {
                            top = " Settings ",
                        },
                    },
                    win_options = {
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    },
                },
            }
        end
        
        -- Main setup logic
        local api_key = get_api_key_with_guidance()
        
        if api_key then
            -- We have an API key, set up ChatGPT immediately
            local setup_ok, err = pcall(chatgpt.setup, get_chatgpt_config(api_key))
            if not setup_ok then
                vim.notify("ChatGPT setup failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
            else
                vim.notify("✅ ChatGPT configured successfully!", vim.log.levels.INFO, {
                    title = "ChatGPT Ready"
                })
            end
        else
            -- No API key available, create deferred setup
            vim.notify("ChatGPT API key not available. Use :ChatGPTSetup to configure.", vim.log.levels.WARN, {
                title = "ChatGPT Setup Pending"
            })
        end
        
        -- Create user commands for manual setup
        vim.api.nvim_create_user_command("ChatGPTSetup", function()
            local retry_key = get_api_key_with_guidance()
            if retry_key then
                local setup_ok, err = pcall(chatgpt.setup, get_chatgpt_config(retry_key))
                if not setup_ok then
                    vim.notify("ChatGPT setup failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
                else
                    vim.notify("✅ ChatGPT configured successfully!", vim.log.levels.INFO, {
                        title = "ChatGPT Ready"
                    })
                end
            else
                prompt_signin_and_retry()
            end
        end, { desc = "Setup ChatGPT with API key" })
        
        vim.api.nvim_create_user_command("ChatGPTStatus", function()
            local op_available = vim.fn.executable("op") == 1
            local env_key = os.getenv("OPENAI_API_KEY")
            
            local status = {
                "🔍 ChatGPT Configuration Status:",
                "",
                "1Password CLI: " .. (op_available and "✅ Available" or "❌ Not found"),
            }
            
            if op_available then
                local signin_test = vim.fn.system("op account list 2>/dev/null")
                table.insert(status, "1Password Signin: " .. (vim.v.shell_error == 0 and "✅ Signed in" or "❌ Not signed in"))
            end
            
            table.insert(status, "Environment API Key: " .. (env_key and env_key ~= "" and "✅ Set" or "❌ Not set"))
            table.insert(status, "")
            table.insert(status, "📝 Available Commands:")
            table.insert(status, "• :ChatGPTSetup - Configure ChatGPT")
            table.insert(status, "• :ChatGPTStatus - Show this status")
            
            if not op_available and (not env_key or env_key == "") then
                table.insert(status, "")
                table.insert(status, "⚠️  To use ChatGPT:")
                table.insert(status, "1. Install 1Password CLI, OR")
                table.insert(status, "2. Set OPENAI_API_KEY environment variable")
            end
            
            vim.notify(table.concat(status, "\n"), vim.log.levels.INFO, { title = "ChatGPT Configuration" })
        end, { desc = "Show ChatGPT configuration status" })
        
        -- Override ChatGPT commands to provide better UX
        local original_chatgpt_setup = false
        
        -- Custom ChatGPT command with configuration check
        vim.api.nvim_create_user_command("ChatGPT", function()
            -- Check if ChatGPT is properly configured
            local test_key = get_api_key_with_guidance()
            if not test_key then
                prompt_signin_and_retry()
                return
            end
            
            -- If not already configured, set it up
            if not original_chatgpt_setup then
                local setup_ok, err = pcall(chatgpt.setup, get_chatgpt_config(test_key))
                if not setup_ok then
                    vim.notify("ChatGPT setup failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
                    return
                end
                original_chatgpt_setup = true
            end
            
            -- Run the original command
            pcall(function()
                require("chatgpt").open_chat()
            end)
        end, { desc = "Open ChatGPT (with configuration check)" })
        
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim",
    },
}
