return {
    -- Core git functionality (minimal, since you use Lazygit)
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GBrowse" },
        keys = {
            { "<leader>gd", "<cmd>Gdiffsplit<cr>", desc = "Git diff split" },
            { "<leader>go", "<cmd>GBrowse<cr>", desc = "Open in GitHub", mode = { "n", "v" } },
        },
        dependencies = {
            "tpope/vim-rhubarb", -- GitHub integration
        },
    },

    -- Primary git signs and blame functionality
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            -- Enhanced visual indicators for git changes
            signs = {
                add          = { text = '┃' },  -- Clean vertical line for additions
                change       = { text = '┃' },  -- Clean vertical line for changes
                delete       = { text = '_' },  -- Understated deletion marker
                topdelete    = { text = '‾' },  -- Top deletion marker
                changedelete = { text = '~' },  -- Change+delete marker
                untracked    = { text = '┆' },  -- Dotted line for untracked
            },
            signs_staged = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
            },
            
            -- Git blame configuration optimized for daily use
            current_line_blame = true, -- Enable by default since you want blame
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- End of line positioning
                delay = 300, -- Quick response for productivity
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            -- Concise but informative blame format
            current_line_blame_formatter = '<author> • <author_time:%m/%d/%Y> • <summary>',
            
            -- Hunk preview configuration
            preview_config = {
                border = 'rounded',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            
            -- Performance and behavior settings
            attach_to_untracked = true, -- Show signs for untracked files
            update_debounce = 100, -- Fast updates for real-time feedback
            max_file_length = 40000, -- Disable on very large files
            watch_gitdir = {
                enable = true,
                follow_files = true
            },
            auto_attach = true,
            diff_opts = {
                algorithm = "patience", -- Better diff algorithm
                internal = true, -- Use internal diff
            },
            
            -- Enhanced integration with other tools
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                
                -- Enhanced navigation
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end
                
                -- Hunk navigation with wrapping
                map('n', ']h', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, {expr=true, desc = "Next git hunk"})
                
                map('n', '[h', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, {expr=true, desc = "Previous git hunk"})
                
                -- Enhanced text objects for git hunks
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', {desc = "Select git hunk"})
            end,
        },
        
        keys = {
            -- Git blame controls
            { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle git blame" },
            { "<leader>gB", function() require('gitsigns').blame_line{full=true} end, desc = "Git blame full" },
            
            -- Hunk operations (complement Lazygit for quick in-editor changes)
            { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview git hunk" },
            { "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset git hunk", mode = { "n", "v" } },
            { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage git hunk", mode = { "n", "v" } },
            { "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<cr>", desc = "Undo stage hunk" },
            
            -- Buffer-level operations
            { "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset git buffer" },
            { "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", desc = "Stage git buffer" },
            
            -- Visual enhancements
            { "<leader>gl", "<cmd>Gitsigns toggle_linehl<cr>", desc = "Toggle line highlights" },
            { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<cr>", desc = "Toggle word diff" },
            { "<leader>gn", "<cmd>Gitsigns toggle_numhl<cr>", desc = "Toggle number highlights" },
            { "<leader>gD", "<cmd>Gitsigns diffthis<cr>", desc = "Diff this file" },
            
            -- Quickfix integration
            { "<leader>gq", "<cmd>Gitsigns setqflist<cr>", desc = "Send hunks to quickfix" },
        },
    },

    -- Enhanced git blame with commit details
    {
        "f-person/git-blame.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            enabled = false, -- Start disabled, toggle when needed for detailed info
            message_template = " <summary> • <date> • <author> • <sha>",
            date_format = "%m-%d-%Y %H:%M:%S",
            virtual_text_column = 1,
            highlight_group = "Comment",
            set_extmark_options = {
                priority = 7,
            },
            display_virtual_text = true,
            ignored_filetypes = {
                "help", "fugitive", "git", "gitcommit", "gitrebase", "svn", "hgcommit",
                "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify",
                "toggleterm", "lazyterm",
            },
            delay = 200, -- Quick response
        },
        keys = {
            { "<leader>gT", "<cmd>GitBlameToggle<cr>", desc = "Toggle detailed git blame" },
            { "<leader>gO", "<cmd>GitBlameOpenCommitURL<cr>", desc = "Open commit URL" },
            { "<leader>gC", "<cmd>GitBlameCopyCommitURL<cr>", desc = "Copy commit URL" },
            { "<leader>gF", "<cmd>GitBlameOpenFileURL<cr>", desc = "Open file URL" },
        },
    },

    -- Lazygit integration (your primary git interface)
    {
        "kdheepak/lazygit.nvim",
        cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
            { "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit current file" },
            { "<leader>gc", "<cmd>LazyGitFilter<cr>", desc = "LazyGit commits" },
        },
        config = function()
            -- Enhanced Lazygit configuration for better integration
            vim.g.lazygit_floating_window_winblend = 0
            vim.g.lazygit_floating_window_scaling_factor = 0.95 -- Slightly larger for better visibility
            vim.g.lazygit_use_neovim_remote = 1
            vim.g.lazygit_floating_window_corner_chars = {'╭', '╮', '╰', '╯'}
            vim.g.lazygit_floating_window_use_plenary = 0
            
            -- Custom autocmds for Lazygit integration
            vim.api.nvim_create_autocmd("TermOpen", {
                pattern = "*lazygit*",
                callback = function()
                    -- Disable line numbers and other distractions in LazyGit terminal
                    vim.opt_local.number = false
                    vim.opt_local.relativenumber = false
                    vim.opt_local.signcolumn = "no"
                    vim.opt_local.statuscolumn = ""
                end,
            })
            
            -- Refresh gitsigns after LazyGit operations
            vim.api.nvim_create_autocmd("TermClose", {
                pattern = "*lazygit*",
                callback = function()
                    -- Refresh all git-related plugins after LazyGit closes
                    vim.schedule(function()
                        local gitsigns = package.loaded.gitsigns
                        if gitsigns then
                            gitsigns.refresh()
                        end
                    end)
                end,
            })
        end,
    },

    -- Diffview for visual diff and file history (complement to Lazygit)
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewRefresh" },
        keys = {
            { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
            { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" },
            { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repository history" },
        },
        opts = {
            diff_binaries = false,
            enhanced_diff_hl = true,
            git_cmd = { "git" },
            use_icons = true,
            show_help_hints = true,
            watch_index = true,
            
            -- Clean, modern icons
            icons = {
                folder_closed = "",
                folder_open = "",
            },
            signs = {
                fold_closed = "",
                fold_open = "",
                done = "✓",
            },
            
            -- Optimized layouts
            view = {
                default = {
                    layout = "diff2_horizontal",
                    disable_diagnostics = true,
                    winbar_info = true,
                },
                merge_tool = {
                    layout = "diff3_horizontal",
                    disable_diagnostics = true,
                },
                file_history = {
                    layout = "diff2_horizontal",
                    disable_diagnostics = true,
                },
            },
            
            -- Enhanced file panel
            file_panel = {
                listing_style = "tree",
                tree_options = {
                    flatten_dirs = true,
                    folder_statuses = "only_folded",
                },
                win_config = {
                    position = "left",
                    width = 35,
                    win_opts = {}
                },
            },
            
            -- Streamlined keymaps (only essential ones)
            keymaps = {
                disable_defaults = false,
                view = {
                    { "n", "<tab>", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle file panel" } },
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
                },
                file_panel = {
                    { "n", "j", "<cmd>lua require'diffview.actions'.next_entry()<cr>", { desc = "Next file" } },
                    { "n", "k", "<cmd>lua require'diffview.actions'.prev_entry()<cr>", { desc = "Previous file" } },
                    { "n", "<cr>", "<cmd>lua require'diffview.actions'.select_entry()<cr>", { desc = "Open diff" } },
                    { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" } },
                },
            },
        },
    },

    -- Conflict resolution helper
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            default_mappings = {
                ours = '<leader>gco',
                theirs = '<leader>gct',
                none = '<leader>gc0',
                both = '<leader>gcb',
                next = ']x',
                prev = '[x',
            },
            default_commands = true,
            disable_diagnostics = false,
            list_opener = 'Telescope quickfix',
            highlights = {
                incoming = 'DiffAdd',
                current = 'DiffText',
            },
        },
    },
    {
        "f-person/git-blame.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            enabled = true,
            message_template = " <author> • <date> • <summary>",
            date_format = "%m/%d/%Y",
            virtual_text_column = 1,
            highlight_group = "Comment",
            set_extmark_options = {
                priority = 7,
            },
            display_virtual_text = true,
            ignored_filetypes = {
                "help",
                "fugitive",
                "git",
                "gitcommit",
                "gitrebase",
                "svn",
                "hgcommit",
            },
            delay = 250,
        },
        keys = {
            { "<leader>gT", "<cmd>GitBlameToggle<cr>", desc = "Toggle git blame (detailed)" },
            { "<leader>gO", "<cmd>GitBlameOpenCommitURL<cr>", desc = "Open commit URL" },
            { "<leader>gC", "<cmd>GitBlameCopyCommitURL<cr>", desc = "Copy commit URL" },
            { "<leader>gF", "<cmd>GitBlameOpenFileURL<cr>", desc = "Open file URL" },
        },
    },
    {
        "sindrets/diffview.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
        keys = {
            { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
            { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
            { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
            { "<leader>gH", "<cmd>DiffviewFileHistory %<cr>", desc = "Current file history" },
        },
        opts = {
            diff_binaries = false,
            enhanced_diff_hl = true,
            git_cmd = { "git" },
            use_icons = true,
            show_help_hints = true,
            watch_index = true,
            icons = {
                folder_closed = "",
                folder_open = "",
            },
            signs = {
                fold_closed = "",
                fold_open = "",
                done = "✓",
            },
            view = {
                default = {
                    layout = "diff2_horizontal",
                    disable_diagnostics = true,
                },
                merge_tool = {
                    layout = "diff3_horizontal",
                    disable_diagnostics = true,
                },
                file_history = {
                    layout = "diff2_horizontal",
                    disable_diagnostics = true,
                },
            },
            file_panel = {
                listing_style = "tree",
                tree_options = {
                    flatten_dirs = true,
                    folder_statuses = "only_folded",
                },
                win_config = {
                    position = "left",
                    width = 35,
                    win_opts = {}
                },
            },
            file_history_panel = {
                log_options = {
                    git = {
                        single_file = {
                            diff_merges = "combined",
                        },
                        multi_file = {
                            diff_merges = "first-parent",
                        },
                    },
                },
                win_config = {
                    position = "bottom",
                    height = 16,
                    win_opts = {}
                },
            },
            commit_log_panel = {
                win_config = {
                    win_opts = {},
                }
            },
            default_args = {
                DiffviewOpen = {},
                DiffviewFileHistory = {},
            },
            hooks = {},
            keymaps = {
                disable_defaults = false,
                view = {
                    { "n", "<tab>", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle the file panel." } },
                    { "n", "gf", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle the file panel" } },
                    { "n", "<leader>e", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle the file panel" } },
                    { "n", "<leader>co", "<cmd>DiffviewConflictChooseOurs<cr>", { desc = "Choose the OURS version of a conflict" } },
                    { "n", "<leader>ct", "<cmd>DiffviewConflictChooseTheirs<cr>", { desc = "Choose the THEIRS version of a conflict" } },
                    { "n", "<leader>cb", "<cmd>DiffviewConflictChooseBase<cr>", { desc = "Choose the BASE version of a conflict" } },
                    { "n", "<leader>ca", "<cmd>DiffviewConflictChooseAll<cr>", { desc = "Choose all the versions of a conflict" } },
                    { "n", "dx", "<cmd>DiffviewConflictChooseNone<cr>", { desc = "Delete the conflict region" } },
                },
                diff1 = {
                    { "n", "g?", "<cmd>h diffview-maps-diff1<cr>", { desc = "Open the help panel" } },
                },
                diff2 = {
                    { "n", "g?", "<cmd>h diffview-maps-diff2<cr>", { desc = "Open the help panel" } },
                },
                diff3 = {
                    { "n", "g?", "<cmd>h diffview-maps-diff3<cr>", { desc = "Open the help panel" } },
                },
                diff4 = {
                    { "n", "g?", "<cmd>h diffview-maps-diff4<cr>", { desc = "Open the help panel" } },
                },
                file_panel = {
                    { "n", "j", "<cmd>lua require'diffview.actions'.next_entry()<cr>", { desc = "Bring the cursor to the next file entry" } },
                    { "n", "<down>", "<cmd>lua require'diffview.actions'.next_entry()<cr>", { desc = "Bring the cursor to the next file entry" } },
                    { "n", "k", "<cmd>lua require'diffview.actions'.prev_entry()<cr>", { desc = "Bring the cursor to the previous file entry." } },
                    { "n", "<up>", "<cmd>lua require'diffview.actions'.prev_entry()<cr>", { desc = "Bring the cursor to the previous file entry." } },
                    { "n", "<cr>", "<cmd>lua require'diffview.actions'.select_entry()<cr>", { desc = "Open the diff for the selected entry." } },
                    { "n", "o", "<cmd>lua require'diffview.actions'.select_entry()<cr>", { desc = "Open the diff for the selected entry." } },
                    { "n", "l", "<cmd>lua require'diffview.actions'.select_entry()<cr>", { desc = "Open the diff for the selected entry." } },
                    { "n", "<2-LeftMouse>", "<cmd>lua require'diffview.actions'.select_entry()<cr>", { desc = "Open the diff for the selected entry." } },
                    { "n", "-", "<cmd>lua require'diffview.actions'.toggle_stage_entry()<cr>", { desc = "Stage / unstage the selected entry." } },
                    { "n", "S", "<cmd>lua require'diffview.actions'.stage_all()<cr>", { desc = "Stage all entries." } },
                    { "n", "U", "<cmd>lua require'diffview.actions'.unstage_all()<cr>", { desc = "Unstage all entries." } },
                    { "n", "X", "<cmd>lua require'diffview.actions'.restore_entry()<cr>", { desc = "Restore entry to the state on the left side." } },
                    { "n", "L", "<cmd>lua require'diffview.actions'.open_commit_log()<cr>", { desc = "Open the commit log panel." } },
                    { "n", "zo", "<cmd>lua require'diffview.actions'.open_fold()<cr>", { desc = "Expand fold" } },
                    { "n", "h", "<cmd>lua require'diffview.actions'.close_fold()<cr>", { desc = "Collapse fold" } },
                    { "n", "zc", "<cmd>lua require'diffview.actions'.close_fold()<cr>", { desc = "Collapse fold" } },
                    { "n", "za", "<cmd>lua require'diffview.actions'.toggle_fold()<cr>", { desc = "Toggle fold" } },
                    { "n", "zR", "<cmd>lua require'diffview.actions'.open_all_folds()<cr>", { desc = "Expand all folds" } },
                    { "n", "zM", "<cmd>lua require'diffview.actions'.close_all_folds()<cr>", { desc = "Collapse all folds" } },
                    { "n", "<c-b>", "<cmd>lua require'diffview.actions'.scroll_view(-0.25)<cr>", { desc = "Scroll the view up" } },
                    { "n", "<c-f>", "<cmd>lua require'diffview.actions'.scroll_view(0.25)<cr>", { desc = "Scroll the view down" } },
                    { "n", "<tab>", "<cmd>lua require'diffview.actions'.select_next_entry()<cr>", { desc = "Open the diff for the next file" } },
                    { "n", "<s-tab>", "<cmd>lua require'diffview.actions'.select_prev_entry()<cr>", { desc = "Open the diff for the previous file" } },
                    { "n", "gf", "<cmd>lua require'diffview.actions'.goto_file()<cr>", { desc = "Open the file in the previous tabpage" } },
                    { "n", "<C-w><C-f>", "<cmd>lua require'diffview.actions'.goto_file_split()<cr>", { desc = "Open the file in a new split" } },
                    { "n", "<C-w>gf", "<cmd>lua require'diffview.actions'.goto_file_tab()<cr>", { desc = "Open the file in a new tabpage" } },
                    { "n", "i", "<cmd>lua require'diffview.actions'.listing_style()<cr>", { desc = "Toggle between 'list' and 'tree' views" } },
                    { "n", "f", "<cmd>lua require'diffview.actions'.toggle_flatten_dirs()<cr>", { desc = "Flatten empty subdirectories in tree listing style." } },
                    { "n", "R", "<cmd>lua require'diffview.actions'.refresh_files()<cr>", { desc = "Update stats and entries in the file list." } },
                    { "n", "<leader>e", "<cmd>lua require'diffview.actions'.focus_files()<cr>", { desc = "Bring focus to the file panel" } },
                    { "n", "<leader>b", "<cmd>lua require'diffview.actions'.toggle_files()<cr>", { desc = "Toggle the file panel." } },
                    { "n", "g<C-x>", "<cmd>lua require'diffview.actions'.cycle_layout()<cr>", { desc = "Cycle through available layouts." } },
                    { "n", "[x", "<cmd>lua require'diffview.actions'.prev_conflict()<cr>", { desc = "In the merge-tool: jump to the previous conflict" } },
                    { "n", "]x", "<cmd>lua require'diffview.actions'.next_conflict()<cr>", { desc = "In the merge-tool: jump to the next conflict" } },
                    { "n", "g?", "<cmd>h diffview-maps-file-panel<cr>", { desc = "Open the help panel" } },
                    { "n", "<leader>co", "<cmd>lua require'diffview.actions'.conflict_choose('ours')<cr>", { desc = "Choose the OURS version of a conflict" } },
                    { "n", "<leader>ct", "<cmd>lua require'diffview.actions'.conflict_choose('theirs')<cr>", { desc = "Choose the THEIRS version of a conflict" } },
                    { "n", "<leader>cb", "<cmd>lua require'diffview.actions'.conflict_choose('base')<cr>", { desc = "Choose the BASE version of a conflict" } },
                    { "n", "<leader>ca", "<cmd>lua require'diffview.actions'.conflict_choose('all')<cr>", { desc = "Choose all the versions of a conflict" } },
                    { "n", "dx", "<cmd>lua require'diffview.actions'.conflict_choose('none')<cr>", { desc = "Delete the conflict region" } },
                },
                file_history_panel = {
                    { "n", "g!", "<cmd>lua require'diffview.actions'.options()<cr>", { desc = "Open the option panel" } },
                    { "n", "<C-A-d>", "<cmd>lua require'diffview.actions'.open_in_diffview()<cr>", { desc = "Open the entry under the cursor in a diffview" } },
                    { "n", "y", "<cmd>lua require'diffview.actions'.copy_hash()<cr>", { desc = "Copy the commit hash of the entry under the cursor" } },
                    { "n", "L", "<cmd>lua require'diffview.actions'.open_commit_log()<cr>", { desc = "Show commit details" } },
                    { "n", "zR", "<cmd>lua require'diffview.actions'.open_all_folds()<cr>", { desc = "Expand all folds" } },
                    { "n", "zM", "<cmd>lua require'diffview.actions'.close_all_folds()<cr>", { desc = "Collapse all folds" } },
                    { "n", "j", "<cmd>lua require'diffview.actions'.next_entry()<cr>", { desc = "Bring the cursor to the next file entry" } },
                    { "n", "<down>", "<cmd>lua require'diffview.actions'.next_entry()<cr>", { desc = "Bring the cursor to the next file entry" } },
                    { "n", "k", "<cmd>lua require'diffview.actions'.prev_entry()<cr>", { desc = "Bring the cursor to the previous file entry." } },
                    { "n", "<up>", "<cmd>lua require'diffview.actions'.prev_entry()<cr>", { desc = "Bring the cursor to the previous file entry." } },
                    { "n", "<cr>", "<cmd>lua require'diffview.actions'.select_entry()<cr>", { desc = "Open the diff for the selected entry." } },
                    { "n", "o", "<cmd>lua require'diffview.actions'.select_entry()<cr>", { desc = "Open the diff for the selected entry." } },
                    { "n", "<2-LeftMouse>", "<cmd>lua require'diffview.actions'.select_entry()<cr>", { desc = "Open the diff for the selected entry." } },
                    { "n", "<c-b>", "<cmd>lua require'diffview.actions'.scroll_view(-0.25)<cr>", { desc = "Scroll the view up" } },
                    { "n", "<c-f>", "<cmd>lua require'diffview.actions'.scroll_view(0.25)<cr>", { desc = "Scroll the view down" } },
                    { "n", "<tab>", "<cmd>lua require'diffview.actions'.select_next_entry()<cr>", { desc = "Open the diff for the next file" } },
                    { "n", "<s-tab>", "<cmd>lua require'diffview.actions'.select_prev_entry()<cr>", { desc = "Open the diff for the previous file" } },
                    { "n", "gf", "<cmd>lua require'diffview.actions'.goto_file()<cr>", { desc = "Open the file in the previous tabpage" } },
                    { "n", "<C-w><C-f>", "<cmd>lua require'diffview.actions'.goto_file_split()<cr>", { desc = "Open the file in a new split" } },
                    { "n", "<C-w>gf", "<cmd>lua require'diffview.actions'.goto_file_tab()<cr>", { desc = "Open the file in a new tabpage" } },
                    { "n", "<leader>e", "<cmd>lua require'diffview.actions'.focus_files()<cr>", { desc = "Bring focus to the file panel" } },
                    { "n", "<leader>b", "<cmd>lua require'diffview.actions'.toggle_files()<cr>", { desc = "Toggle the file panel." } },
                    { "n", "g<C-x>", "<cmd>lua require'diffview.actions'.cycle_layout()<cr>", { desc = "Cycle through available layouts." } },
                    { "n", "g?", "<cmd>h diffview-maps-file-history-panel<cr>", { desc = "Open the help panel" } },
                },
                option_panel = {
                    { "n", "<tab>", "<cmd>lua require'diffview.actions'.select_entry()<cr>", { desc = "Change the current option" } },
                    { "n", "q", "<cmd>lua require'diffview.actions'.close()<cr>", { desc = "Close the panel" } },
                    { "n", "g?", "<cmd>h diffview-maps-option-panel<cr>", { desc = "Open the help panel" } },
                },
                help_panel = {
                    { "n", "q", "<cmd>lua require'diffview.actions'.close()<cr>", { desc = "Close help menu" } },
                    { "n", "<esc>", "<cmd>lua require'diffview.actions'.close()<cr>", { desc = "Close help menu" } },
                },
            },
        },
    },
    {
        "akinsho/git-conflict.nvim",
        version = "*",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('git-conflict').setup({
                default_mappings = true,
                default_commands = true,
                disable_diagnostics = false,
                list_opener = 'copen',
                highlights = {
                    incoming = 'DiffAdd',
                    current = 'DiffText',
                },
            })
        end,
        keys = {
            { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>", desc = "Choose ours (conflict)" },
            { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>", desc = "Choose theirs (conflict)" },
            { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>", desc = "Choose both (conflict)" },
            { "<leader>gc0", "<cmd>GitConflictChooseNone<cr>", desc = "Choose none (conflict)" },
            { "]x", "<cmd>GitConflictNextConflict<cr>", desc = "Next conflict" },
            { "[x", "<cmd>GitConflictPrevConflict<cr>", desc = "Previous conflict" },
            { "<leader>gcl", "<cmd>GitConflictListQf<cr>", desc = "List conflicts in quickfix" },
        },
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
        },
        config = function()
            vim.g.lazygit_floating_window_winblend = 0
            vim.g.lazygit_floating_window_scaling_factor = 0.9
            vim.g.lazygit_use_neovim_remote = 1
        end,
    }
}
