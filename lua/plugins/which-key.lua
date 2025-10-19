return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = function(ctx)
			return ctx.plugin and 0 or 200
		end,
		filter = function(mapping)
			-- example to exclude mappings without a description
			return mapping.desc and mapping.desc ~= ""
		end,
		spec = {
			-- File explorer (existing keybindings)
			{ "<leader>e", group = "Explorer" },
			{ "<leader>ee", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Explorer" },
			{ "<leader>er", "<cmd>NvimTreeFocus<cr>", desc = "Focus File Explorer" },
			{ "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in Explorer" },

			-- File operations (Telescope)
			{ "<leader>f", group = "Find/File" },
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
			{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
			{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
			{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
			{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
			{ "<leader>fw", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in Buffer" },

			-- Git operations (existing keybindings)
			{ "<leader>g", group = "Git" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
			{ "<leader>gbf", "<cmd>GBrowse<cr>", desc = "Git Browse File" },
			{ "<leader>glc", desc = "Git Link Copy" },
			{ "<leader>gdf", "<cmd>Gvdiffsplit<cr>", desc = "Git Diff" },
			{ "<leader>gx", "<cmd>sil !open <cWORD><cr>", desc = "Open URL under cursor" },
			{ "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview Hunk" },
			{ "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset Hunk" },
			{ "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", desc = "Reset Buffer" },
			{ "<leader>gp", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous Hunk" },
			{ "<leader>gn", "<cmd>Gitsigns next_hunk<cr>", desc = "Next Hunk" },
			{ "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff This" },
			{ "<leader>gD", "<cmd>Gitsigns toggle_deleted<cr>", desc = "Toggle Deleted" },
			{ "<leader>gl", "<cmd>Gitsigns blame_line<cr>", desc = "Blame Line" },
			{ "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle Line Blame" },

			-- LSP operations
			{ "<leader>l", group = "LSP" },
			{ "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "Go to Definition" },
			{ "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "<leader>li", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations" },
			{ "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions" },
			{ "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
			{ "<leader>lw", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
			{ "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", desc = "Format Document" },
			{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Actions" },
			{ "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename Symbol" },
			{ "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover Documentation" },
			{ "<leader>lS", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Signature Help" },

			-- Diagnostics (existing keybindings updated)
			{ "<leader>d", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded' })<cr>", desc = "Open Diagnostic Float" },
			{ "]d", function()
				vim.diagnostic.goto_next()
				vim.api.nvim_feedkeys("zz", "n", false)
			end, desc = "Next Diagnostic" },
			{ "[d", function()
				vim.diagnostic.goto_prev()
				vim.api.nvim_feedkeys("zz", "n", false)
			end, desc = "Previous Diagnostic" },
			{ "]e", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
				vim.api.nvim_feedkeys("zz", "n", false)
			end, desc = "Next Error" },
			{ "[e", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
				vim.api.nvim_feedkeys("zz", "n", false)
			end, desc = "Previous Error" },
			{ "]w", function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
				vim.api.nvim_feedkeys("zz", "n", false)
			end, desc = "Next Warning" },
			{ "[w", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
				vim.api.nvim_feedkeys("zz", "n", false)
			end, desc = "Previous Warning" },

			-- Debugging (existing keybindings)
			{ "<leader>b", group = "Breakpoints" },
			{ "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
			{ "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", desc = "Conditional Breakpoint" },
			{ "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", desc = "Log Point" },
			{ "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>", desc = "Clear Breakpoints" },
			{ "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>", desc = "List Breakpoints" },
			
			{ "<leader>d", group = "Debug" },
			{ "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
			{ "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
			{ "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
			{ "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
			{ "<leader>dd", desc = "Disconnect & Close UI" },
			{ "<leader>dt", desc = "Terminate & Close UI" },
			{ "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Toggle REPL" },
			{ "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Run Last" },
			{ "<leader>di", desc = "Hover Variables" },
			{ "<leader>d?", desc = "Show Scopes" },
			{ "<leader>df", "<cmd>Telescope dap frames<cr>", desc = "Frames" },
			{ "<leader>dh", "<cmd>Telescope dap commands<cr>", desc = "Commands" },
			{ "<leader>de", desc = "Error Diagnostics" },

			-- Treesitter operations
			{ "<leader>t", group = "Treesitter" },
			{ "<leader>ts", "<cmd>TSToggle highlight<cr>", desc = "Toggle Highlighting" },
			{ "<leader>tc", "<cmd>TSContextToggle<cr>", desc = "Toggle Context" },
			{ "<leader>tl", function()
				vim.opt.foldenable = not vim.opt.foldenable:get()
				print("Treesitter folding:", vim.opt.foldenable:get() and "enabled" or "disabled")
			end, desc = "Toggle Folding" },

			-- Window operations (existing keybindings)
			{ "<leader>s", group = "Split/Search" },
			{ "<leader>sv", "<cmd>vsplit<cr>", desc = "Vertical Split" },
			{ "<leader>sh", "<cmd>split<cr>", desc = "Horizontal Split" },
			{ "<leader>se", "<cmd>wincmd =<cr>", desc = "Equal Windows" },
			{ "<leader>sx", "<cmd>close<cr>", desc = "Close Window" },
			{ "<leader>sj", "<cmd>wincmd -<cr>", desc = "Shorter Height" },
			{ "<leader>sk", "<cmd>wincmd +<cr>", desc = "Taller Height" },
			{ "<leader>sl", "<cmd>wincmd >5<cr>", desc = "Wider Width" },
			{ "<leader>sr", desc = "Search and Replace (existing)" },
			{ "<leader>sc", desc = "Search and Replace with Confirmation" },

			-- Search operations (existing keybindings from treesitter)
			{ "<leader>sr", ":%s/<C-r><C-w>//g<Left><Left>", desc = "Search and Replace Word Under Cursor" },
			{ "<leader>sc", ":%s//gc<Left><Left><Left>", desc = "Search and Replace with Confirmation" },
			{ "<leader>sf", "vif<cmd>Telescope lsp_document_symbols<cr>", desc = "Search Symbols (Current Function)" },
			{ "<leader>ss", "<cmd>Telescope grep_string<cr>", desc = "Search String" },
			{ "<leader>sw", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Window" },

			-- Copy/Paste/Move operations (existing keybindings)
			{ "<leader>p", "\"_dP", desc = "Paste without losing register", mode = "v" },
			{ "<leader>yf", ":%y<cr>", desc = "Yank File" },
			{ "<leader>m", group = "Move/Maximize" },
			{ "<leader>mj", desc = "Move Down" },
			{ "<leader>mk", desc = "Move Up" },

			-- Code navigation (Treesitter text objects)
			{ "]", group = "Next" },
			{ "]f", desc = "Next Function" },
			{ "]c", desc = "Next Class" },
			{ "]a", desc = "Next Parameter" },
			{ "]b", desc = "Next Block" },
			{ "]s", desc = "Next Statement" },
			{ "]d", desc = "Next Conditional" },
			{ "]l", desc = "Next Loop" },
			{ "]r", desc = "Next Resource (Terraform)" },
			{ "]p", desc = "Next Property (JSON/YAML)" },
			{ "]v", desc = "Next Variable" },
			{ "]k", desc = "Next Call" },
			{ "]t", desc = "Next Comment" },

			{ "[", group = "Previous" },
			{ "[f", desc = "Previous Function" },
			{ "[c", desc = "Previous Class" },
			{ "[a", desc = "Previous Parameter" },
			{ "[b", desc = "Previous Block" },
			{ "[s", desc = "Previous Statement" },
			{ "[d", desc = "Previous Conditional" },
			{ "[l", desc = "Previous Loop" },
			{ "[r", desc = "Previous Resource (Terraform)" },
			{ "[p", desc = "Previous Property (JSON/YAML)" },
			{ "[v", desc = "Previous Variable" },
			{ "[k", desc = "Previous Call" },
			{ "[t", desc = "Previous Comment" },

			-- Text object selections (these will show when in visual mode)
			{ "a", group = "Around", mode = {"v", "o"} },
			{ "af", desc = "Around Function", mode = {"v", "o"} },
			{ "ac", desc = "Around Class", mode = {"v", "o"} },
			{ "aa", desc = "Around Parameter", mode = {"v", "o"} },
			{ "ab", desc = "Around Block", mode = {"v", "o"} },
			{ "as", desc = "Around Statement", mode = {"v", "o"} },
			{ "ad", desc = "Around Conditional", mode = {"v", "o"} },
			{ "al", desc = "Around Loop", mode = {"v", "o"} },
			{ "ak", desc = "Around Call", mode = {"v", "o"} },
			{ "at", desc = "Around Comment", mode = {"v", "o"} },
			{ "ar", desc = "Around Resource (Terraform)", mode = {"v", "o"} },
			{ "ao", desc = "Around Attribute (JSON/YAML)", mode = {"v", "o"} },
			{ "an", desc = "Around Number", mode = {"v", "o"} },
			{ "aq", desc = "Around String", mode = {"v", "o"} },
			{ "ap", desc = "Around Property", mode = {"v", "o"} },
			{ "av", desc = "Around Variable", mode = {"v", "o"} },

			{ "i", group = "Inside", mode = {"v", "o"} },
			{ "if", desc = "Inside Function", mode = {"v", "o"} },
			{ "ic", desc = "Inside Class", mode = {"v", "o"} },
			{ "ia", desc = "Inside Parameter", mode = {"v", "o"} },
			{ "ib", desc = "Inside Block", mode = {"v", "o"} },
			{ "is", desc = "Inside Statement", mode = {"v", "o"} },
			{ "id", desc = "Inside Conditional", mode = {"v", "o"} },
			{ "il", desc = "Inside Loop", mode = {"v", "o"} },
			{ "ik", desc = "Inside Call", mode = {"v", "o"} },
			{ "it", desc = "Inside Comment", mode = {"v", "o"} },
			{ "ir", desc = "Inside Resource (Terraform)", mode = {"v", "o"} },
			{ "io", desc = "Inside Attribute (JSON/YAML)", mode = {"v", "o"} },
			{ "in", desc = "Inside Number", mode = {"v", "o"} },
			{ "iq", desc = "Inside String", mode = {"v", "o"} },
			{ "ip", desc = "Inside Property", mode = {"v", "o"} },
			{ "iv", desc = "Inside Variable", mode = {"v", "o"} },

			-- Swapping operations (Treesitter) - Updated to match existing patterns
			{ "<leader>n", group = "Swap Next" },
			{ "<leader>na", desc = "Swap Next Parameter" },
			{ "<leader>nf", desc = "Swap Next Function" },
			{ "<leader>nb", desc = "Swap Next Block" },
			{ "<leader>nr", desc = "Swap Next Resource" },
			{ "<leader>np", desc = "Swap Next Property" },
			{ "<leader>nv", desc = "Swap Next Variable" },
			{ "<leader>no", "<cmd>nohlsearch<cr>", desc = "Clear Search Highlights" },

			{ "<leader>p", group = "Swap Previous" },
			{ "<leader>pa", desc = "Swap Previous Parameter" },
			{ "<leader>pf", desc = "Swap Previous Function" },
			{ "<leader>pb", desc = "Swap Previous Block" },
			{ "<leader>pr", desc = "Swap Previous Resource" },
			{ "<leader>pp", desc = "Swap Previous Property" },
			{ "<leader>pv", desc = "Swap Previous Variable" },

			-- Quickfix list operations (existing keybindings)
			{ "<leader>c", group = "Quickfix/Diff" },
			{ "<leader>cn", "<cmd>cnext<cr>zz", desc = "Next Quickfix" },
			{ "<leader>cp", "<cmd>cprev<cr>zz", desc = "Previous Quickfix" },
			{ "<leader>co", "<cmd>copen<cr>zz", desc = "Open Quickfix" },
			{ "<leader>cc", "<cmd>cclose<cr>zz", desc = "Close Quickfix" },
			{ "<leader>cj", "<cmd>diffget 1<cr>", desc = "Get Diff from Left" },
			{ "<leader>ck", "<cmd>diffget 3<cr>", desc = "Get Diff from Right" },

			-- Terminal
			{ "<leader>T", group = "Terminal" },
			{ "<leader>Tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
			{ "<leader>Tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
			{ "<leader>Th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
			{ "<leader>Tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical Terminal" },

			-- Trouble (diagnostics)
			{ "<leader>x", group = "Trouble" },
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
			{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },

			-- Comments
			{ "gc", group = "Comment" },
			{ "gcc", desc = "Comment Line" },
			{ "gcb", desc = "Comment Block" },
			{ "gco", desc = "Comment Line Below" },
			{ "gcO", desc = "Comment Line Above" },
			{ "gcA", desc = "Comment End of Line" },

			-- AI/Copilot
			{ "<leader>a", group = "AI/Copilot" },
			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "Explain Code" },
			{ "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "Review Code" },
			{ "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "Fix Code" },
			{ "<leader>ao", "<cmd>CopilotChatOptimize<cr>", desc = "Optimize Code" },
			{ "<leader>ad", "<cmd>CopilotChatDocs<cr>", desc = "Generate Docs" },
			{ "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "Generate Tests" },
			{ "<leader>ac", "<cmd>CopilotChatCommit<cr>", desc = "Generate Commit Message" },

			-- Go specific (if applicable)
			{ "<leader>G", group = "Go" },
			{ "<leader>Gr", "<cmd>GoRun<cr>", desc = "Run Go File" },
			{ "<leader>Gb", "<cmd>GoBuild<cr>", desc = "Build Go Project" },
			{ "<leader>Gt", "<cmd>GoTest<cr>", desc = "Run Go Tests" },
			{ "<leader>Gc", "<cmd>GoCoverage<cr>", desc = "Go Coverage" },
			{ "<leader>Gf", "<cmd>GoFmt<cr>", desc = "Format Go File" },
			{ "<leader>Gi", "<cmd>GoImports<cr>", desc = "Organize Imports" },

			-- Markdown preview
			{ "<leader>M", group = "Markdown" },
			{ "<leader>Mp", "<cmd>MarkdownPreview<cr>", desc = "Preview Markdown" },
			{ "<leader>Ms", "<cmd>MarkdownPreviewStop<cr>", desc = "Stop Preview" },
			{ "<leader>Mt", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Preview" },

			-- Todo comments
			{ "<leader>td", "<cmd>TodoTelescope<cr>", desc = "Find Todo Comments" },
			{ "<leader>tq", "<cmd>TodoQuickFix<cr>", desc = "Todo QuickFix" },
			{ "<leader>tl", "<cmd>TodoLocList<cr>", desc = "Todo Location List" },

			-- Obsidian (if using)
			{ "<leader>o", group = "Obsidian" },
			{ "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Note" },
			{ "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open Note" },
			{ "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search Notes" },
			{ "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick Switch" },
			{ "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Follow Link" },
			{ "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Show Backlinks" },
			{ "<leader>ot", "<cmd>ObsidianToday<cr>", desc = "Today's Note" },
			{ "<leader>oy", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday's Note" },
			{ "<leader>oT", "<cmd>ObsidianTomorrow<cr>", desc = "Tomorrow's Note" },
			{ "<leader>od", "<cmd>ObsidianDailies<cr>", desc = "Daily Notes" },
			{ "<leader>oO", "<cmd>ObsidianTags<cr>", desc = "Show Tags" },
			{ "<leader>ow", "<cmd>ObsidianWorkspace<cr>", desc = "Switch Workspace" },
			{ "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename Note" },
			{ "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Show Links" },
			{ "<leader>oe", "<cmd>ObsidianExtractNote<cr>", desc = "Extract Note" },
			{ "<leader>oc", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle Checkbox" },
			{ "<leader>oi", "<cmd>edit ~/Documents/personalObsidianVault/inbox<cr>", desc = "Open Inbox" },
			{ "<leader>oD", "<cmd>edit ~/Documents/personalObsidianVault/Dashboard.md<cr>", desc = "Main Dashboard" },
			{ "<leader>op", "<cmd>edit ~/Documents/personalObsidianVault/02-professional/Professional Dashboard.md<cr>", desc = "Professional Dashboard" },
			{ "<leader>oh", "<cmd>edit ~/Documents/personalObsidianVault/03-hobby/Hobby Dashboard.md<cr>", desc = "Hobby Dashboard" },

			-- Quick actions
			{ "<leader>q", group = "Quit" },
			{ "<leader>qq", "<cmd>qa<cr>", desc = "Quit All" },
			{ "<leader>qw", "<cmd>wqa<cr>", desc = "Write and Quit All" },
			{ "<leader>qQ", "<cmd>qa!<cr>", desc = "Force Quit All" },

			-- Package manager (Lazy)
			{ "<leader>L", group = "Lazy" },
			{ "<leader>Ll", "<cmd>Lazy<cr>", desc = "Open Lazy" },
			{ "<leader>Lu", "<cmd>Lazy update<cr>", desc = "Update Plugins" },
			{ "<leader>Ls", "<cmd>Lazy sync<cr>", desc = "Sync Plugins" },
			{ "<leader>Lc", "<cmd>Lazy clean<cr>", desc = "Clean Plugins" },
			{ "<leader>Lp", "<cmd>Lazy profile<cr>", desc = "Profile Plugins" },

			-- Mason (LSP installer)
			{ "<leader>m", group = "Mason/Maximize" },
			{ "<leader>mm", "<cmd>Mason<cr>", desc = "Open Mason" },
			{ "<leader>mu", "<cmd>MasonUpdate<cr>", desc = "Update Mason" },
			{ "<leader>mi", "<cmd>MasonInstall<cr>", desc = "Install Package" },

			-- Notification
			{ "<leader>N", group = "Notifications" },
			{ "<leader>Nd", "<cmd>lua require('notify').dismiss()<cr>", desc = "Dismiss All Notifications" },
			{ "<leader>Nh", "<cmd>Telescope notify<cr>", desc = "Notification History" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
	end,
}
