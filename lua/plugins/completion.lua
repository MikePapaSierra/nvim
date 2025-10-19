return {
	-- GitHub Copilot core integration (managed by copilotchat.lua)
	-- Note: Main copilot configuration is in copilotchat.lua for unified AI experience
	
	-- LSP completion source
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = true,
	},
	
	-- Copilot completion integration (enhanced for VS Code-like experience)
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		opts = {
			suggestion = { enabled = true },
			panel = { enabled = true },
		},
		config = function(_, opts)
			local copilot_cmp = require("copilot_cmp")
			copilot_cmp.setup(opts)
			
			-- Enhanced Copilot integration
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("CopilotCmpAttach", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "copilot" then
						copilot_cmp._on_insert_enter({})
					end
				end,
			})
		end,
	},
	
	-- Enhanced snippet engine with cloud security snippets
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		opts = {
			history = true,
			delete_check_events = "TextChanged",
			region_check_events = "CursorMoved",
		},
		config = function(_, opts)
			require("luasnip").setup(opts)
			
			-- Load friendly snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			
			-- Load custom snippets for cloud security engineering
			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { "./snippets" } -- Add custom snippets if needed
			})
			
			-- Cloud security specific snippets
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			
			-- Terraform snippets
			ls.add_snippets("terraform", {
				s("resource", {
					t("resource \""), i(1, "type"), t("\" \""), i(2, "name"), t("\" {"),
					t({"", "  "}), i(3, "# Configuration"),
					t({"", "}"}),
				}),
				s("data", {
					t("data \""), i(1, "type"), t("\" \""), i(2, "name"), t("\" {"),
					t({"", "  "}), i(3, "# Filter criteria"),
					t({"", "}"}),
				}),
			})
			
			-- Python security snippets
			ls.add_snippets("python", {
				s("seclog", {
					t("import logging"),
					t({"", "import structlog"}),
					t({"", ""}),
					t({"", "logger = structlog.get_logger()"}),
				}),
			})
			
			-- YAML/Kubernetes snippets
			ls.add_snippets("yaml", {
				s("k8s-deploy", {
					t("apiVersion: apps/v1"),
					t({"", "kind: Deployment"}),
					t({"", "metadata:"}),
					t({"", "  name: "}), i(1, "app-name"),
					t({"", "spec:"}),
					t({"", "  replicas: "}), i(2, "3"),
				}),
			})
		end,
	},
	-- Advanced autocompletion engine
	{
		"hrsh7th/nvim-cmp",
		version = false, -- Use latest features
		event = "InsertEnter",
		dependencies = {
			-- Core completion sources
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-emoji",
			"saadparwaiz1/cmp_luasnip",
			
			-- Enhanced features
			"onsails/lspkind-nvim", -- VSCode-like pictograms
			"windwp/nvim-autopairs", -- Auto-close brackets
			"hrsh7th/cmp-calc", -- Math calculations
			"f3fora/cmp-spell", -- Spell checking
			"hrsh7th/cmp-nvim-lua", -- Neovim Lua API
		},
		config = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			-- Setup autopairs integration
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			require("nvim-autopairs").setup({
				check_ts = true,
				ts_config = {
					lua = { "string", "source" },
					javascript = { "string", "template_string" },
					python = { "string" },
					terraform = { "string" },
					yaml = { "string" },
					json = { "string" },
				},
				disable_filetype = { 
					"TelescopePrompt", 
					"spectre_panel",
					"dap-repl",
					"dapui_watches",
					"dapui_hover",
				},
				fast_wrap = {
					map = '<M-e>',
					chars = { '{', '[', '(', '"', "'" },
					pattern = [=[[%'%"%>%]%)%}%,]]=],
					end_key = '$',
					keys = 'qwertyuiopzxcvbnmasdfghjkl',
					check_comma = true,
					highlight = 'PmenuSel',
					highlight_grey = 'LineNr',
				},
			})
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			-- Performance optimizations
			local function has_words_before()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			cmp.setup({
				performance = {
					debounce = 60,
					throttle = 30,
					fetching_timeout = 500,
					confirm_resolve_timeout = 80,
					async_budget = 1,
					max_view_entries = 200,
				},
				
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				
				window = {
					completion = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						winhighlight = "Normal:Pmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
						col_offset = -3,
						side_padding = 0,
						scrollbar = true,
					},
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder,CursorLine:PmenuSel,Search:None",
						max_height = 15,
						max_width = 60,
					},
				},
				
				mapping = cmp.mapping.preset.insert({
					-- Enhanced Tab completion with intelligent fallback
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					
					-- Enhanced navigation and control
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-u>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					
					-- Smart confirm with fallback
					["<CR>"] = cmp.mapping({
						i = function(fallback)
							if cmp.visible() and cmp.get_active_entry() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
							else
								fallback()
							end
						end,
						s = cmp.mapping.confirm({ select = true }),
						c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
					}),
				}),
				
				-- Intelligent source prioritization for cloud security engineering
				sources = cmp.config.sources({
					-- Primary sources (high priority)
					{ 
						name = "nvim_lsp", 
						priority = 1000,
						max_item_count = 20,
						keyword_length = 1,
						group_index = 1,
					},
					{ 
						name = "nvim_lsp_signature_help", 
						priority = 950,
						max_item_count = 10,
						group_index = 1,
					},
					{ 
						name = "luasnip", 
						priority = 750,
						max_item_count = 8,
						keyword_length = 2,
						group_index = 1,
					},
					{ 
						name = "copilot", 
						priority = 700,
						max_item_count = 5,
						keyword_length = 3,
						group_index = 1,
					},
				}, {
					-- Secondary sources (medium priority)
					{ 
						name = "nvim_lua", 
						priority = 600,
						max_item_count = 10,
						keyword_length = 2,
						group_index = 2,
					},
					{ 
						name = "path", 
						priority = 550,
						max_item_count = 8,
						keyword_length = 2,
						group_index = 2,
					},
					{ 
						name = "buffer", 
						priority = 500,
						max_item_count = 10,
						keyword_length = 3,
						group_index = 2,
						option = {
							get_bufnrs = function()
								local bufs = {}
								for _, win in ipairs(vim.api.nvim_list_wins()) do
									local buf = vim.api.nvim_win_get_buf(win)
									if vim.api.nvim_buf_get_option(buf, "buftype") ~= "nofile" then
										bufs[buf] = true
									end
								end
								return vim.tbl_keys(bufs)
							end
						},
					},
				}, {
					-- Tertiary sources (low priority)
					{ 
						name = "calc", 
						priority = 300,
						max_item_count = 3,
						group_index = 3,
					},
					{ 
						name = "emoji", 
						priority = 200,
						max_item_count = 5,
						keyword_length = 2,
						group_index = 3,
					},
					{ 
						name = "spell", 
						priority = 100,
						max_item_count = 5,
						keyword_length = 4,
						group_index = 3,
					},
				}),
				
				-- Enhanced formatting with cloud security icons
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = lspkind.cmp_format({
							mode = "symbol_text",
							maxwidth = 50,
							ellipsis_char = "…",
							show_labelDetails = true,
							symbol_map = {
								-- Enhanced icons for cloud security
								Copilot = "",
								Text = "󰉿",
								Method = "󰊕",
								Function = "󰊕",
								Constructor = "",
								Field = "󰜢",
								Variable = "󰀫",
								Class = "󰠱",
								Interface = "",
								Module = "",
								Property = "󰜢",
								Unit = "󰑭",
								Value = "󰎠",
								Enum = "",
								Keyword = "󰌋",
								Snippet = "",
								Color = "󰏘",
								File = "󰈙",
								Reference = "󰈇",
								Folder = "󰉋",
								EnumMember = "",
								Constant = "󰏿",
								Struct = "󰙅",
								Event = "",
								Operator = "󰆕",
								TypeParameter = "",
								-- Cloud specific
								Resource = "󰅶", -- Terraform resources
								Secret = "󰟵", -- Secrets/credentials
								Config = "󰒓", -- Configuration files
							},
						})(entry, vim_item)
						
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						
						-- Enhanced menu with source information
						local source_names = {
							nvim_lsp = "[LSP]",
							nvim_lsp_signature_help = "[Sig]",
							luasnip = "[Snip]",
							copilot = "[AI]",
							buffer = "[Buf]",
							path = "[Path]",
							emoji = "[Emoji]",
							calc = "[Calc]",
							spell = "[Spell]",
							nvim_lua = "[Lua]",
						}
						
						kind.menu = string.format(" %s %s", 
							source_names[entry.source.name] or "[?]",
							strings[2] or ""
						)
						
						return kind
					end,
				},
				
				-- Enhanced experimental features
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				
				-- Smart completion behavior
				completion = {
					completeopt = "menu,menuone,noinsert",
					keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
				},
				
				-- Confirmation behavior
				confirmation = {
					default_behavior = cmp.ConfirmBehavior.Insert,
				},
				
				-- Matching configuration
				matching = {
					disallow_fuzzy_matching = false,
					disallow_fullfuzzy_matching = false,
					disallow_partial_fuzzy_matching = true,
					disallow_partial_matching = false,
					disallow_prefix_unmatching = false,
				},
				
				-- Sorting for better cloud security workflow
				sorting = {
					priority_weight = 2,
					comparators = {
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.locality,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})

			-- Enhanced cmdline completion
			cmp.setup.cmdline({ '/', '?' }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp_document_symbol' }
				}, {
					{ name = 'buffer' }
				})
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				}),
				matching = { disallow_symbol_nonprefix_matching = false }
			})
			
			-- File type specific configurations
			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'buffer' },
					{ name = 'spell' },
				})
			})
			
			-- Enhanced completion for configuration files
			cmp.setup.filetype({ 'yaml', 'terraform', 'json' }, {
				sources = cmp.config.sources({
					{ name = 'nvim_lsp', priority = 1000 },
					{ name = 'luasnip', priority = 750 },
					{ name = 'copilot', priority = 700 },
					{ name = 'path', priority = 600 },
					{ name = 'buffer', priority = 500, keyword_length = 2 },
				})
			})
		end,
	},
}
