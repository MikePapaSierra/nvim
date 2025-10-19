return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- Always use mocha for consistency
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- Set to true if you want transparency
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = true, -- sets terminal colors for better integration
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.08, -- Slightly more dimming for better focus
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline
			styles = { -- Enhanced styling for better code readability
				comments = { "italic" },
				conditionals = { "italic" },
				loops = { "italic" },
				functions = { "bold" },
				keywords = { "italic", "bold" },
				strings = {},
				variables = {},
				numbers = { "bold" },
				booleans = { "bold", "italic" },
				properties = {},
				types = { "bold" },
				operators = { "bold" },
			},
			color_overrides = {
				mocha = {
					-- Enhanced colors for better visibility
					rosewater = "#f5e0dc",
					flamingo = "#f2cdcd", 
					pink = "#f5c2e7",
					mauve = "#cba6f7",
					red = "#f38ba8",
					maroon = "#eba0ac",
					peach = "#fab387",
					yellow = "#f9e2af",
					green = "#a6e3a1",
					teal = "#94e2d5",
					sky = "#89dceb",
					sapphire = "#74c7ec",
					blue = "#89b4fa",
					lavender = "#b4befe",
					text = "#cdd6f4",
					subtext1 = "#bac2de",
					subtext0 = "#a6adc8",
					overlay2 = "#9399b2",
					overlay1 = "#7f849c",
					overlay0 = "#6c7086",
					surface2 = "#585b70",
					surface1 = "#45475a",
					surface0 = "#313244",
					base = "#1e1e2e",
					mantle = "#181825",
					crust = "#11111b",
				},
			},
			custom_highlights = function(colors)
				return {
					-- Enhanced terminal colors
					TerminalCursor = { bg = colors.rosewater },
					TerminalCursorNC = { bg = colors.flamingo },
					
					-- Better diff colors
					DiffAdd = { bg = colors.green, fg = colors.base, style = { "bold" } },
					DiffChange = { bg = colors.yellow, fg = colors.base },
					DiffDelete = { bg = colors.red, fg = colors.base, style = { "bold" } },
					DiffText = { bg = colors.blue, fg = colors.base, style = { "bold" } },
					
					-- Enhanced diagnostic colors
					DiagnosticError = { fg = colors.red, style = { "bold" } },
					DiagnosticWarn = { fg = colors.yellow, style = { "bold" } },
					DiagnosticInfo = { fg = colors.blue, style = { "bold" } },
					DiagnosticHint = { fg = colors.teal, style = { "bold" } },
					
					-- Better search highlighting
					Search = { bg = colors.yellow, fg = colors.base, style = { "bold" } },
					IncSearch = { bg = colors.pink, fg = colors.base, style = { "bold" } },
					CurSearch = { bg = colors.red, fg = colors.base, style = { "bold" } },
					
					-- Enhanced cursor line
					CursorLine = { bg = colors.surface0 },
					CursorLineNr = { fg = colors.lavender, style = { "bold" } },
					
					-- Better completion menu
					Pmenu = { bg = colors.surface0, fg = colors.text },
					PmenuSel = { bg = colors.surface1, fg = colors.text, style = { "bold" } },
					PmenuKind = { bg = colors.surface0, fg = colors.blue },
					PmenuKindSel = { bg = colors.surface1, fg = colors.blue, style = { "bold" } },
					PmenuExtra = { bg = colors.surface0, fg = colors.subtext1 },
					PmenuExtraSel = { bg = colors.surface1, fg = colors.subtext1 },
					
					-- Custom highlights for specific plugins
					TelescopePromptBorder = { fg = colors.blue },
					TelescopeResultsBorder = { fg = colors.teal },
					TelescopePreviewBorder = { fg = colors.green },
					TelescopeSelection = { bg = colors.surface1, fg = colors.text, style = { "bold" } },
					
					-- Enhanced git colors
					GitSignsAdd = { fg = colors.green },
					GitSignsChange = { fg = colors.yellow },
					GitSignsDelete = { fg = colors.red },
					GitSignsCurrentLineBlame = { fg = colors.overlay1, style = { "italic" } },
					
					-- Better todo-comments integration
					TodoBgTODO = { bg = colors.blue, fg = colors.base, style = { "bold" } },
					TodoBgFIX = { bg = colors.red, fg = colors.base, style = { "bold" } },
					TodoBgHACK = { bg = colors.yellow, fg = colors.base, style = { "bold" } },
					TodoBgWARN = { bg = colors.peach, fg = colors.base, style = { "bold" } },
					TodoBgPERF = { bg = colors.mauve, fg = colors.base, style = { "bold" } },
					TodoBgNOTE = { bg = colors.teal, fg = colors.base, style = { "bold" } },
					TodoBgTEST = { bg = colors.green, fg = colors.base, style = { "bold" } },
					
					-- Alpha dashboard enhancement
					AlphaHeader = { fg = colors.blue, style = { "bold" } },
					AlphaButtons = { fg = colors.text },
					AlphaShortcut = { fg = colors.pink, style = { "bold" } },
					AlphaFooter = { fg = colors.overlay1, style = { "italic" } },
				}
			end,
			default_integrations = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				treesitter_context = true,
				markdown = true,
				mason = true,
				noice = true,
				dap = true,
				dap_ui = true,
				dropbar = true,
				flash = true,
				hop = true,
				leap = true,
				lsp_trouble = true,
				fidget = true,
				which_key = true,
				telescope = {
					enabled = true,
					style = "nvchad", -- nvchad style looks better with mocha
				},
				notify = true,
				mini = {
					enabled = true,
					indentscope_color = "mauve",
				},
				barbar = true,
				alpha = true,
				dashboard = true,
				headlines = true,
				lualine = true, -- Enable lualine integration for proper theme support
				illuminate = {
					enabled = true,
					lsp = true,
				},
				indent_blankline = {
					enabled = true,
					scope_color = "lavender",
					colored_indent_levels = false,
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
						ok = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
						ok = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
				navic = {
					enabled = false,
					custom_bg = "NONE",
				},
				neotest = true,
				neotree = true,
				overseer = true,
				semantic_tokens = true,
				symbols_outline = true,
				telekasten = true,
				ts_rainbow = false, -- We use rainbow-delimiters instead
				ts_rainbow2 = false,
				vim_sneak = true,
				vimwiki = true,
				barbecue = {
					dim_dirname = true,
					bold_basename = true,
					dim_context = false,
					alt_background = false,
				},
			},
		})
		
		-- Set the colorscheme after setup
		vim.cmd.colorscheme("catppuccin-mocha")
		
		-- Ensure consistent theme across terminal
		if vim.fn.has("termguicolors") == 1 then
			vim.opt.termguicolors = true
		end
		
		-- Force consistent theme application after loading
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				-- Ensure all highlight groups are properly linked to Catppuccin
				local highlights = {
					-- Ensure LSP and diagnostic colors are consistent
					LspReferenceText = { link = "CursorLine" },
					LspReferenceRead = { link = "CursorLine" },
					LspReferenceWrite = { link = "CursorLine" },
					
					-- Ensure completion menu is consistent
					CmpItemAbbr = { link = "Comment" },
					CmpItemAbbrMatch = { link = "Function" },
					CmpItemAbbrMatchFuzzy = { link = "Function" },
					CmpItemKind = { link = "Special" },
					CmpItemMenu = { link = "Comment" },
					
					-- Ensure telescope is consistent
					TelescopeNormal = { link = "Normal" },
					TelescopeBorder = { link = "FloatBorder" },
					
					-- Ensure git integration is consistent
					GitSignsAdd = { link = "DiffAdd" },
					GitSignsChange = { link = "DiffChange" },
					GitSignsDelete = { link = "DiffDelete" },
					
					-- Ensure barbar is consistent
					BufferCurrent = { link = "TabLineSel" },
					BufferCurrentMod = { link = "TabLineSel" },
					BufferVisible = { link = "TabLine" },
					BufferInactive = { link = "TabLineFill" },
					
					-- Ensure which-key is consistent (when enabled)
					WhichKey = { link = "Function" },
					WhichKeyGroup = { link = "Keyword" },
					WhichKeyDesc = { link = "Comment" },
					WhichKeySeperator = { link = "Comment" },
					WhichKeyFloat = { link = "NormalFloat" },
					WhichKeyBorder = { link = "FloatBorder" },
				}
				
				for group, opts in pairs(highlights) do
					vim.api.nvim_set_hl(0, group, opts)
				end
			end,
		})
		
		-- Apply theme consistency on VimEnter
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				-- Trigger ColorScheme event to apply custom highlights
				vim.cmd("doautocmd ColorScheme")
			end,
		})
		
		-- Additional mocha-specific terminal colors
		vim.g.terminal_color_0 = "#45475a"   -- surface1
		vim.g.terminal_color_1 = "#f38ba8"   -- red
		vim.g.terminal_color_2 = "#a6e3a1"   -- green
		vim.g.terminal_color_3 = "#f9e2af"   -- yellow
		vim.g.terminal_color_4 = "#89b4fa"   -- blue
		vim.g.terminal_color_5 = "#f5c2e7"   -- pink
		vim.g.terminal_color_6 = "#94e2d5"   -- teal
		vim.g.terminal_color_7 = "#bac2de"   -- subtext1
		vim.g.terminal_color_8 = "#585b70"   -- surface2
		vim.g.terminal_color_9 = "#f38ba8"   -- red
		vim.g.terminal_color_10 = "#a6e3a1"  -- green
		vim.g.terminal_color_11 = "#f9e2af"  -- yellow
		vim.g.terminal_color_12 = "#89b4fa"  -- blue
		vim.g.terminal_color_13 = "#f5c2e7"  -- pink
		vim.g.terminal_color_14 = "#94e2d5"  -- teal
		vim.g.terminal_color_15 = "#a6adc8"  -- subtext0
	end,
}
