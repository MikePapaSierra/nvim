-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Enhanced Markdown Plugins for Obsidian Integration                         │
-- │ Beautiful rendering, live preview, and enhanced UX features                │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
	-- Beautiful markdown rendering in Neovim
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		ft = { "markdown", "Avante" },
		opts = {
			-- Enhanced rendering for Obsidian-style notes
			enabled = true,
			max_file_size = 10.0, -- MB
			debounce = 100,
			
			-- Beautiful headings with domain-aware colors
			headings = {
				enabled = true,
				sign = true,
				icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
				signs = { '󰫎 ' },
				width = 'full',
				left_pad = 0,
				right_pad = 0,
				min_width = 0,
				border = true,
				above = '▄',
				below = '▀',
				backgrounds = {
					'RenderMarkdownH1Bg', -- Private domain color
					'RenderMarkdownH2Bg', -- Professional domain color
					'RenderMarkdownH3Bg', -- Hobby domain color
					'RenderMarkdownH4Bg',
					'RenderMarkdownH5Bg',
					'RenderMarkdownH6Bg',
				},
				foregrounds = {
					'RenderMarkdownH1', -- Bright for importance
					'RenderMarkdownH2', -- Medium for sections
					'RenderMarkdownH3', -- Subtle for subsections
					'RenderMarkdownH4',
					'RenderMarkdownH5',
					'RenderMarkdownH6',
				},
			},
			
			-- Enhanced code blocks for technical notes
			code = {
				enabled = true,
				sign = true,
				style = 'full',
				position = 'left',
				language_pad = 0,
				left_pad = 0,
				right_pad = 0,
				width = 'full',
				border = 'thin',
				above = '▄',
				below = '▀',
				highlight = 'RenderMarkdownCode',
				highlight_inline = 'RenderMarkdownCodeInline',
			},
			
			-- Beautiful bullet points for better organization
			bullet = {
				enabled = true,
				icons = { '●', '○', '◆', '◇' },
				left_pad = 0,
				right_pad = 0,
				highlight = 'RenderMarkdownBullet',
			},
			
			-- Enhanced checkboxes for three-domain task management
			checkbox = {
				enabled = true,
				position = 'inline',
				unchecked = {
					icon = '󰄱 ',
					highlight = 'RenderMarkdownUnchecked',
				},
				checked = {
					icon = '󰱒 ',
					highlight = 'RenderMarkdownChecked',
				},
				custom = {
					-- Domain-specific task states
					todo = { raw = '[>]', rendered = '󰅂 ', highlight = 'RenderMarkdownTodo' },
					urgent = { raw = '[!]', rendered = '󰀦 ', highlight = 'RenderMarkdownUrgent' },
					note = { raw = '[?]', rendered = '󰍨 ', highlight = 'RenderMarkdownNote' },
					progress = { raw = '[/]', rendered = '󰡖 ', highlight = 'RenderMarkdownProgress' },
					private = { raw = '[p]', rendered = '󰒡 ', highlight = 'RenderMarkdownPrivate' },
					professional = { raw = '[w]', rendered = '󰼏 ', highlight = 'RenderMarkdownProfessional' },
					hobby = { raw = '[h]', rendered = '󰠱 ', highlight = 'RenderMarkdownHobby' },
				},
			},
			
			-- Enhanced quotes and callouts for knowledge capture
			quote = {
				enabled = true,
				icon = '▋',
				repeat_linebreak = false,
				highlight = 'RenderMarkdownQuote',
			},
			
			-- Beautiful pipe tables for data organization
			pipe_table = {
				enabled = true,
				preset = 'round',
				style = 'full',
				cell = 'padded',
				border = {
					'┌', '┬', '┐',
					'├', '┼', '┤', 
					'└', '┴', '┘',
					'│', '─',
				},
				alignment_indicator = '━',
				head = 'RenderMarkdownTableHead',
				row = 'RenderMarkdownTableRow',
				filler = 'RenderMarkdownTableFill',
			},
			
			-- Enhanced links for cross-references
			link = {
				enabled = true,
				image = '󰥶 ',
				email = '󰀓 ',
				hyperlink = '󰌹 ',
				highlight = 'RenderMarkdownLink',
				custom = {
					web = { pattern = '^http[s]?://', icon = '󰖟 ', highlight = 'RenderMarkdownLink' },
					obsidian = { pattern = '^obsidian://', icon = '󰁱 ', highlight = 'RenderMarkdownLink' },
					file = { pattern = '^file://', icon = '󰈔 ', highlight = 'RenderMarkdownLink' },
				},
			},
			
			-- Obsidian-specific wiki links
			wiki_link = {
				enabled = true,
				icon = '󰌹 ',
				highlight = 'RenderMarkdownWikiLink',
			},
			
			-- File type settings
			file_types = { 'markdown', 'Avante' },
			
			-- Enhanced anti-conceal for editing
			anti_conceal = {
				enabled = true,
				above = 1,
				below = 1,
			},
		},
	},
	
	-- Live markdown preview in browser
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
		config = function()
			-- Enhanced preview settings for Obsidian notes
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_refresh_slow = 0
			vim.g.mkdp_command_for_global = 0
			vim.g.mkdp_open_to_the_world = 0
			vim.g.mkdp_open_ip = ''
			vim.g.mkdp_port = ''
			vim.g.mkdp_browser = ''
			vim.g.mkdp_echo_preview_url = 0
			vim.g.mkdp_browserfunc = ''
			vim.g.mkdp_preview_options = {
				mkit = {},
				katex = {},
				uml = {},
				maid = {},
				disable_sync_scroll = 0,
				sync_scroll_type = 'middle',
				hide_yaml_meta = 1,
				sequence_diagrams = {},
				flowchart_diagrams = {},
				content_editable = false,
				disable_filename = 0,
				toc = {}
			}
			vim.g.mkdp_markdown_css = ''
			vim.g.mkdp_highlight_css = ''
			vim.g.mkdp_page_title = '「${name}」'
			vim.g.mkdp_filetypes = { 'markdown' }
			vim.g.mkdp_theme = 'dark'
		end,
	},
	
	-- Enhanced markdown features and navigation
	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown",
		opts = {
			-- Enhanced mappings for Obsidian workflow
			mappings = {
				inline_surround_toggle = "<leader>mis", -- Toggle inline style
				inline_surround_toggle_line = "<leader>misl", -- Toggle line style
				inline_surround_delete = "<leader>misd", -- Delete inline style
				inline_surround_change = "<leader>misc", -- Change inline style
				link_add = "<leader>mla", -- Add link
				link_follow = "<leader>mlf", -- Follow link
				go_curr_heading = "]c", -- Go to current heading
				go_parent_heading = "]p", -- Go to parent heading
				go_next_heading = "]]", -- Go to next heading
				go_prev_heading = "[[", -- Go to previous heading
			},
			
			-- Enhanced inline style options
			inline_surround = {
				emphasis = {
					key = "e",
					txt = "*",
				},
				strong = {
					key = "s", 
					txt = "**",
				},
				strikethrough = {
					key = "d",
					txt = "~~",
				},
				code_inline = {
					key = "c",
					txt = "`",
				},
			},
			
			-- Enhanced link configuration for Obsidian
			link = {
				paste = {
					enable = true,
				},
			},
			
			-- Table of contents generation
			toc = {
				omit_heading = 1,
				omit_section = { "^## References", "^## Metadata" },
			},
			
			-- Enhanced hooks for Obsidian-style workflow
			hooks = {
				follow_link = function(opts, fallback)
					-- Custom link following for Obsidian-style links
					if opts.path:match("%.md$") then
						-- Try to find the file in the vault
						local vault_path = "/home/mps/second-brain/vaults/personal-obsidian-vault/"
						local full_path = vault_path .. opts.path
						
						if vim.fn.filereadable(full_path) == 1 then
							vim.cmd("edit " .. full_path)
						else
							-- Search for the file in all domain folders
							local search_paths = {
								vault_path .. "01-private/" .. opts.path,
								vault_path .. "02-professional/" .. opts.path,
								vault_path .. "03-hobby/" .. opts.path,
								vault_path .. "inbox/" .. opts.path,
							}
							
							for _, path in ipairs(search_paths) do
								if vim.fn.filereadable(path) == 1 then
									vim.cmd("edit " .. path)
									return
								end
							end
							
							-- File not found, create it
							vim.cmd("ObsidianNew " .. opts.path:gsub("%.md$", ""))
						end
					else
						fallback(opts)
					end
				end,
			},
		},
	},
	
	-- Beautiful headlines and code blocks
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = { "markdown", "Avante" },
		opts = {
			markdown = {
				headline_highlights = {
					"Headline1", -- Private domain style
					"Headline2", -- Professional domain style
					"Headline3", -- Hobby domain style
					"Headline4",
					"Headline5",
					"Headline6",
				},
				codeblock_highlight = "CodeBlock",
				dash_highlight = "Dash",
				dash_string = "-",
				quote_highlight = "Quote",
				quote_string = "┃",
				fat_headlines = true,
				fat_headline_upper_string = "▃",
				fat_headline_lower_string = "🬂",
			},
		},
	},
	
	-- Enhanced table editing for data organization
	{
		"dhruvasagar/vim-table-mode",
		ft = "markdown",
		cmd = { "TableModeToggle", "TableModeEnable" },
		config = function()
			-- Enhanced table settings for Obsidian
			vim.g.table_mode_corner = '|'
			vim.g.table_mode_corner_corner = '+'
			vim.g.table_mode_header_fillchar = '='
			vim.g.table_mode_align_char = ':'
			vim.g.table_mode_delimiter = ' | '
			vim.g.table_mode_auto_align = 1
			
			-- Key mappings for table mode
			vim.keymap.set('n', '<leader>tm', '<cmd>TableModeToggle<cr>', { desc = 'Toggle table mode' })
			vim.keymap.set('n', '<leader>tr', '<cmd>TableModeRealign<cr>', { desc = 'Realign table' })
		end,
	},
	
	-- Enhanced markdown folding
	{
		"masukomi/vim-markdown-folding",
		ft = "markdown",
		config = function()
			-- Enhanced folding for better organization
			vim.g.markdown_folding = 1
			vim.g.markdown_fold_style = 'nested'
			vim.g.markdown_fold_override_foldtext = 1
		end,
	},
}
