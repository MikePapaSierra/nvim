return {
	"yetone/avante.nvim",
	enabled = true, -- Enable for VS Code-like AI experience
	event = "VeryLazy",
	lazy = false,
	version = false,
	opts = {
		-- Provider configuration - Use Copilot for VS Code compatibility
		provider = "copilot",
		auto_suggestions = true,
		auto_set_highlight_group = true,
		auto_set_keymaps = true,
		auto_apply_diff_after_generation = false,
		dual_boost = {
			enabled = true, -- Enable for enhanced responses
			first_provider = "copilot",
			second_provider = "claude",
			prompt = "Based on the two reference outputs below, generate a response that incorporates the best elements from both for cloud security engineering.",
			timeout = 45000, -- Reduced timeout for faster response
		},
		behaviour = {
			auto_suggestions = true, -- Enable for VS Code-like auto suggestions
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = true, -- Enable clipboard support
		},
		mappings = {
			--- @class AvanteConflictMappings
			diff = {
				ours = "co",
				theirs = "ct",
				all_theirs = "ca",
				both = "cb",
				cursor = "cc",
				next = "]x",
				prev = "[x",
			},
			suggestion = {
				accept = "<M-l>", -- Alt+L like VS Code Copilot
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>", -- Ctrl+] to dismiss
			},
			jump = {
				next = "]]",
				prev = "[[",
			},
			submit = {
				normal = "<CR>",
				insert = "<C-s>",
			},
			sidebar = {
				apply_all = "A",
				apply_cursor = "a",
				switch_windows = "<Tab>",
				reverse_switch_windows = "<S-Tab>",
			},
		},
		hints = { enabled = false }, -- Disable hints for cleaner VS Code-like experience
		windows = {
			position = "right", -- VS Code-like sidebar position
			wrap = true,
			width = 40, -- Optimal width for VS Code-like panel
			sidebar_header = {
				enabled = true,
				align = "center", -- Center aligned title like VS Code
				rounded = false, -- Clean borders like VS Code
			},
			input = {
				prefix = "> ",
				height = 6, -- Compact input height
			},
			edit = {
				border = "solid", -- VS Code-like clean borders
				start_insert = true,
			},
			ask = {
				floating = false, -- Use sidebar like VS Code Copilot panel
				start_insert = true,
				border = "solid", -- Clean VS Code-like borders
				focus_on_apply = "ours",
			},
		},
		highlights = {
			---@type AvanteConflictHighlights
			diff = {
				current = "DiffText",
				incoming = "DiffAdd",
			},
		},
		--- @class AvanteConflictUserConfig
		diff = {
			autojump = true,
			---@type string | fun(): string
			list_opener = "copen",
			--- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
			--- Helps to avoid entering operator-pending mode with diff mappings.
			override_timeoutlen = 500,
		},
		--- @class AvanteRepoMapConfig
		repo_map = {
			ignore_patterns = { "%.git", "node_modules", "%.next" },
			nerd_font_icon = "*",
		},
		--- @class AvanteSystemPrompt
		system_prompt = [[
You are an expert programming assistant specialized in cloud security engineering and modern development practices.

Key guidelines:
- Provide production-ready, secure code solutions
- Focus on cloud security best practices (AWS, Azure, GCP)
- Use modern frameworks and follow industry standards
- Explain security implications of code suggestions
- Be concise but thorough, similar to VS Code Copilot Chat
- Consider Infrastructure as Code, containerization, and DevSecOps practices
- Prioritize performance, security, and maintainability
]],
		--- @class AvanteProviderConfig
		providers = {
			---@type AvanteProvider  
			copilot = {
				endpoint = "https://api.githubcopilot.com",
				model = "gpt-4o", -- Use GPT-4o via Copilot for VS Code compatibility
				proxy = nil,
				allow_insecure = false,
				timeout = 20000, -- Faster timeout for responsive experience
				extra_request_body = {
					temperature = 0.1, -- Slightly creative for better suggestions
					max_tokens = 4096, -- Balanced token limit
					stream = true, -- Enable streaming like VS Code
				},
			},
			---@type AvanteProvider
			claude = {
				endpoint = "https://api.anthropic.com", 
				model = "claude-3-5-sonnet-20241022",
				["api_key_name"] = "ANTHROPIC_API_KEY",
				extra_request_body = {
					temperature = 0.1,
					max_tokens = 4096,
					stream = true,
				},
			},
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			'MeanderingProgrammer/render-markdown.nvim',
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
	-- VS Code-like keybindings and setup
	keys = {
		-- VS Code Copilot Chat equivalent
		{ "<leader>ac", "<cmd>AvanteAsk<cr>", desc = "Avante Chat" },
		{ "<leader>aa", "<cmd>AvanteToggle<cr>", desc = "Avante Toggle" },
		{ "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante Refresh" },
		{ "<leader>ae", "<cmd>AvanteEdit<cr>", mode = "v", desc = "Avante Edit Selection" },
		
		-- VS Code-like quick actions
		{ "<C-k><C-i>", "<cmd>AvanteAsk<cr>", desc = "Avante: Ask AI" },
		{ "<C-k><C-e>", "<cmd>AvanteEdit<cr>", mode = "v", desc = "Avante: Edit with AI" },
		{ "<C-k><C-c>", "<cmd>AvanteChat<cr>", desc = "Avante: Open Chat" },
	},
	config = function(_, opts)
		-- Ensure proper encoding for sign text
		vim.o.encoding = "utf-8"
		
		local ok, avante = pcall(require, "avante")
		if not ok then
			vim.notify("Failed to load avante", vim.log.levels.ERROR)
			return
		end
		
		avante.setup(opts)
		
		-- Create VS Code-like commands
		vim.api.nvim_create_user_command("AvanteChat", function()
			pcall(vim.cmd, "AvanteAsk")
		end, { desc = "Open Avante Chat" })
		
		-- Test command to verify Avante is working
		vim.api.nvim_create_user_command("AvanteTest", function()
			local avante_loaded = pcall(require, "avante")
			if avante_loaded then
				vim.notify("✅ Avante is loaded and ready!", vim.log.levels.INFO, { title = "Avante Status" })
			else
				vim.notify("❌ Avante failed to load", vim.log.levels.ERROR, { title = "Avante Status" })
			end
		end, { desc = "Test Avante loading status" })
		
		-- Auto-format on apply (like VS Code)
		vim.api.nvim_create_autocmd("User", {
			pattern = "AvanteApplied",
			callback = function()
				vim.defer_fn(function()
					if vim.bo.filetype ~= "" then
						pcall(vim.lsp.buf.format, { async = false })
					end
				end, 100)
			end,
		})
		
		-- Disable startup notifications completely
	end,
}
