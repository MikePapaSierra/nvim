return {
	-- LSP Configuration with enhanced cloud security support
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- LSP management and installation
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
			
			-- Enhanced LSP UI and functionality
			{ "j-hui/fidget.nvim", opts = {} }, -- LSP progress notifications
			{ "folke/neodev.nvim" }, -- Better Lua LSP for Neovim development
			{ "b0o/schemastore.nvim" }, -- JSON/YAML schema support
			
			-- Completion integration
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		config = function()
			-- Enhanced Mason setup with better UI
			require("mason").setup({
				ui = {
					border = "rounded",
					width = 0.8,
					height = 0.8,
					icons = {
						package_installed = "✓",
						package_pending = "󰔟",
						package_uninstalled = "✗",
					},
				},
				install_root_dir = vim.fn.stdpath("data") .. "/mason",
				pip = {
					upgrade_pip = true,
				},
				log_level = vim.log.levels.INFO,
				max_concurrent_installers = 4,
			})

			-- Comprehensive LSP server configuration for cloud security engineering
			require("mason-lspconfig").setup({
				automatic_installation = true,
				ensure_installed = {
					-- Core languages
					"lua_ls", -- Lua (Neovim config)
					"bashls", -- Bash/Shell scripting
					
					-- Cloud security stack
					"pyright", -- Python (security tools, automation)
					"ruff", -- Python linter/formatter (updated from ruff_lsp)
					"gopls", -- Go (security tools, Kubernetes)
					
					-- Infrastructure as Code
					"terraformls", -- Terraform
					"ansiblels", -- Ansible automation
					
					-- Configuration languages
					"yamlls", -- YAML (Kubernetes, Ansible, CI/CD)
					"jsonls", -- JSON (configs, APIs)
					"taplo", -- TOML configuration files
					
					-- Container and orchestration
					"dockerls", -- Dockerfile
					"helm_ls", -- Kubernetes Helm charts
					
					-- Web technologies (dashboards, APIs)
					"ts_ls", -- TypeScript/JavaScript
					"html", -- HTML
					"cssls", -- CSS
					"eslint", -- JavaScript/TypeScript linting
					
					-- Documentation and markup
					"marksman", -- Markdown
					-- "ltex", -- LaTeX and markup grammar checking (disabled due to stability issues)
					
					-- Additional useful servers
					"vimls", -- Vim script
					"powershell_es", -- PowerShell (Windows environments)
				},
			})

			-- Enhanced tool installation for cloud security workflow
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Python ecosystem
					"black", -- Code formatter
					"isort", -- Import sorter
					"ruff", -- Fast Python linter
					"mypy", -- Static type checking
					-- "bandit", -- Security linter (removed from null-ls)
					-- "safety", -- Security vulnerability scanner (optional)
					"debugpy", -- Python debugger
					
					-- Go ecosystem
					"gofumpt", -- Enhanced gofmt
					"goimports", -- Import management
					"golangci-lint", -- Comprehensive Go linter
					"govulncheck", -- Go vulnerability scanner
					"delve", -- Go debugger
					"gosec", -- Go security analyzer
					
					-- Terraform ecosystem
					"terraform-ls", -- Terraform language server
					"tflint", -- Terraform linter
					"tfsec", -- Terraform security scanner
					"checkov", -- Infrastructure security scanner
					"terrascan", -- Infrastructure security scanner
					
					-- Ansible ecosystem
					"ansible-lint", -- Ansible best practices
					"ansible-language-server", -- Enhanced Ansible support
					
					-- YAML/JSON tools
					"yamllint", -- YAML linting
					"yq", -- YAML processor
					"jq", -- JSON processor
					"spectral-language-server", -- OpenAPI/AsyncAPI linting
					
					-- Shell scripting
					"shellcheck", -- Shell script linting
					"shfmt", -- Shell script formatting
					
					-- Container tools
					"hadolint", -- Dockerfile linting
					"trivy", -- Container vulnerability scanner
					
					-- Kubernetes tools
					"kubent", -- Kubernetes deprecation checker
					"kube-score", -- Kubernetes object analysis
					
					-- Markdown and documentation
					"markdownlint", -- Markdown linting
					"vale", -- Prose linting
					"write-good", -- English prose checker
					
					-- Web technologies
					"prettier", -- Multi-language formatter
					-- "eslint_d", -- Fast ESLint daemon (removed from null-ls)
					"stylelint", -- CSS linter
					
					-- Additional security tools
					"semgrep", -- Static analysis security scanner
					"gitleaks", -- Git secrets scanner
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 3000, -- 3 second delay
				debounce_hours = 5, -- Only check every 5 hours
			})

			-- Enhanced LSP capabilities
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities()
			)
			
			-- Enhanced capabilities for better completion
			capabilities.textDocument.completion.completionItem = {
				documentationFormat = { "markdown", "plaintext" },
				snippetSupport = true,
				preselectSupport = true,
				insertReplaceSupport = true,
				labelDetailsSupport = true,
				deprecatedSupport = true,
				commitCharactersSupport = true,
				tagSupport = { valueSet = { 1 } },
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}

			-- Enhanced on_attach function with comprehensive keymaps and features
			local on_attach = function(client, bufnr)
				local opts = { buffer = bufnr, silent = true }
				local keymap = vim.keymap.set

				-- Core LSP navigation
				keymap("n", "gd", vim.lsp.buf.definition, opts)
				keymap("n", "gD", vim.lsp.buf.declaration, opts)
				keymap("n", "gr", vim.lsp.buf.references, opts)
				keymap("n", "gi", vim.lsp.buf.implementation, opts)
				keymap("n", "gt", vim.lsp.buf.type_definition, opts)
				
				-- Documentation and help
				keymap("n", "K", vim.lsp.buf.hover, opts)
				keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				keymap("i", "<C-k>", vim.lsp.buf.signature_help, opts)
				
				-- Code modification
				keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
				keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap("v", "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap("n", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				keymap("v", "<leader>f", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
				
				-- Diagnostics navigation with enhanced shortcuts
				keymap("n", "[d", vim.diagnostic.goto_prev, opts)
				keymap("n", "]d", vim.diagnostic.goto_next, opts)
				keymap("n", "<leader>dl", vim.diagnostic.setloclist, opts)
				keymap("n", "<leader>dq", vim.diagnostic.setqflist, opts)
				keymap("n", "<leader>do", vim.diagnostic.open_float, opts)
				
				-- Workspace management
				keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				keymap("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				
				-- Security-focused shortcuts
				keymap("n", "<leader>si", function()
					vim.lsp.buf.code_action({
						filter = function(action)
							return action.kind and string.match(action.kind, "source%.organizeImports")
						end,
						apply = true,
					})
				end, opts)
				
				-- Enhanced formatting with save
				keymap("n", "<leader>fs", function()
					vim.lsp.buf.format({ async = true })
					vim.cmd("write")
				end, opts)

				-- Enable inlay hints for supported servers
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					keymap("n", "<leader>ih", function()
						local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
						vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
					end, opts)
				end

				-- Document highlighting
				if client.server_capabilities.documentHighlightProvider then
					local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = false })
					vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = group,
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						group = group,
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end

				-- Auto-formatting on save for specific file types
				if client.supports_method("textDocument/formatting") then
					local format_filetypes = {
						"lua", "python", "go", "terraform", "json", "yaml", 
						"javascript", "typescript", "html", "css", "markdown"
					}
					if vim.tbl_contains(format_filetypes, vim.bo[bufnr].filetype) then
						local group = vim.api.nvim_create_augroup("LSPFormatting", { clear = false })
						vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = group,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end
			end

			-- Enhanced diagnostic configuration with modern sign setup
			vim.diagnostic.config({
				virtual_text = {
					enabled = true,
					source = "if_many",
					prefix = "●",
					spacing = 2,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.HINT] = "󰌶",
						[vim.diagnostic.severity.INFO] = "",
					},
				},
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- LSP server configurations optimized for cloud security engineering
			-- Completely suppress ALL lspconfig-related warnings and errors during setup
			local original_notify = vim.notify
			local original_warn = vim.health.warn or function() end
			local original_error = vim.health.error or function() end
			
			-- Override all warning/notification channels
			local function suppress_all_lsp_warnings()
				vim.notify = function(msg, level, opts)
					if type(msg) == "string" then
						local suppress_patterns = {
							"lspconfig.*deprecated",
							"require.*lspconfig.*framework", 
							"Feature will be removed in nvim%-lspconfig",
							"__index.*lspconfig",
							"stack traceback.*lspconfig"
						}
						for _, pattern in ipairs(suppress_patterns) do
							if msg:match(pattern) then
								return -- Suppress all lspconfig warnings
							end
						end
					end
					original_notify(msg, level, opts)
				end
				
				-- Also suppress vim.health warnings if they exist
				if vim.health then
					vim.health.warn = function() end
					vim.health.error = function() end
				end
			end
			
			local function restore_notifications()
				vim.notify = original_notify
				if vim.health then
					vim.health.warn = original_warn
					vim.health.error = original_error
				end
			end
			
			-- Apply suppression before any lspconfig access
			suppress_all_lsp_warnings()
			local lspconfig = require("lspconfig")
			
			-- Helper function to safely setup LSP servers
			local function safe_setup(server_name, config)
				-- Additional suppression during server access
				suppress_all_lsp_warnings()
				local success, result = pcall(function()
					local server = lspconfig[server_name]
					if server and type(server.setup) == "function" then
						server.setup(config)
						return true
					else
						return false, "Server not available"
					end
				end)
				
				if not success then
					restore_notifications()
					original_notify("LSP server '" .. server_name .. "' not available or invalid", vim.log.levels.WARN, {
						title = "⚠️  LSP Setup"
					})
					suppress_all_lsp_warnings()
				end
			end
			
			-- Lua Language Server (Enhanced for Neovim development)
			safe_setup("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim", "use", "describe", "it", "assert", "stub" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
						completion = {
							callSnippet = "Replace",
						},
						hint = {
							enable = true,
							arrayIndex = "Disable",
						},
					},
				},
			})

			-- Python (Enhanced for security tools and automation)
			safe_setup("pyright", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "basic",
							autoImportCompletions = true,
							stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
						},
					},
				},
				root_dir = function(fname)
					return lspconfig.util.root_pattern(
						"pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", 
						"Pipfile", ".git", "main.py"
					)(fname) or lspconfig.util.find_git_ancestor(fname)
				end,
			})

			-- Ruff LSP for fast Python linting (updated configuration)
			safe_setup("ruff", {
				on_attach = function(client, bufnr)
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
					on_attach(client, bufnr)
				end,
				capabilities = capabilities,
				init_options = {
					settings = {
						-- Ruff configuration
						lint = {
							enable = true,
							select = {
								"E", "W", "F", "I", "N", "D", "UP", "YTT", "ANN", "S", "BLE", "FBT", "B", "A", 
								"COM", "C4", "DTZ", "T10", "DJ", "EM", "EXE", "FA", "ISC", "ICN", "G", "INP", 
								"PIE", "T20", "PYI", "PT", "Q", "RSE", "RET", "SLF", "SLOT", "SIM", "TID", 
								"TCH", "INT", "ARG", "PTH", "TD", "FIX", "ERA", "PD", "PGH", "PL", "TRY", 
								"FLY", "NPY", "AIR", "PERF", "FURB", "LOG", "RUF"
							},
							ignore = {
								"E501", "D100", "D101", "D102", "D103", "D104", "D105", "D106", "D107"
							},
						},
						format = {
							enable = true,
						},
					},
				},
			})

			-- Go (Enhanced for cloud-native development)
			safe_setup("gopls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						analyses = {
							fieldalignment = true,
							nilness = true,
							unusedparams = true,
							unusedwrite = true,
							useany = true,
							unusedvariable = true,
							shadow = true, -- Important for security code
							httpresponse = true, -- HTTP response body checks
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						directoryFilters = { 
							"-.git", 
							"-.vscode", 
							"-.idea", 
							"-.vscode-server",
							"-node_modules",
							"-vendor", -- Exclude vendor directory
						},
						semanticTokens = true,
						-- Enhanced for cloud-native development
						experimentalPostfixCompletions = true,
						experimentalUseInvalidMetadata = true,
						experimentalWatchedFileDelay = "100ms",
						-- Security-focused settings
						vulncheck = "Imports", -- Check for known vulnerabilities
						env = {
							GOFLAGS = "-tags=netgo", -- Static linking for containers
						},
					},
				},
				-- Enhanced initialization options for cloud development
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					analyses = {
						fieldalignment = true,
						nilness = true,
						unusedwrite = true,
						shadow = true,
					},
				},
			})

			-- Terraform (Enhanced for IaC development)
			safe_setup("terraformls", {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "terraform", "terraform-vars" },
				root_dir = lspconfig.util.root_pattern(".terraform", ".git", "main.tf"),
				settings = {
					terraform = {
						validation = {
							enableEnhancedValidation = true,
						},
					},
				},
			})

			-- YAML Language Server (Enhanced for Kubernetes, Ansible, CI/CD)
			safe_setup("yamlls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = {
							-- Kubernetes schemas
							["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
							["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.27.0-standalone-strict/all.json"] = "/k8s/**/*.yaml",
							
							-- Docker Compose
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose*.{yml,yaml}",
							
							-- Ansible
							["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/**/*.{yml,yaml}",
							["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = "*play*.{yml,yaml}",
							
							-- GitHub Actions
							["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.{yml,yaml}",
							
							-- GitLab CI
							["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "/.gitlab-ci.yml",
							
							-- Azure Pipelines
							["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "/azure-pipelines*.{yml,yaml}",
							
							-- Helm
							["https://json.schemastore.org/chart.json"] = "/Chart.yaml",
							
							-- Additional cloud schemas
							["https://json.schemastore.org/cloudbuild.json"] = "/cloudbuild.{yml,yaml}",
							["https://json.schemastore.org/kustomization.json"] = "/kustomization.{yml,yaml}",
						},
						validate = true,
						completion = true,
						hover = true,
						format = {
							enable = true,
							singleQuote = false,
							bracketSpacing = true,
						},
						customTags = {
							"!reference sequence",
							"!vault",
							"!include",
						},
					},
				},
				filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.ansible" },
			})

			-- JSON Language Server (Enhanced with comprehensive schemas)
			safe_setup("jsonls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					json = {
						schemas = (function()
							-- Try to load schemastore with better error handling
							local success, result = pcall(function()
								local schemastore = require("schemastore")
								if schemastore and schemastore.json and schemastore.json.schemas then
									return schemastore.json.schemas({
										select = {
											"package.json",
											"tsconfig.json",
											"jsconfig.json",
											".eslintrc",
											".prettierrc",
											"docker-compose.yml",
											"GitHub Workflow",
											"GitLab CI",
											"Azure Pipelines",
											"Ansible Playbook",
											"Ansible Inventory", 
											"Terraform",
											"Helm Chart.yaml",
											"Kubernetes",
											"AWS CloudFormation",
											"Azure Resource Manager",
											"Google Cloud Deployment Manager",
										},
									})
								end
								return {}
							end)
							
							if success and result and type(result) == "table" then
								return result
							else
								-- Silent fallback - provide basic schemas without warnings
								return {
									{
										fileMatch = {"package.json"},
										url = "https://json.schemastore.org/package.json"
									},
									{
										fileMatch = {"tsconfig.json", "tsconfig.*.json"},
										url = "https://json.schemastore.org/tsconfig.json"
									},
									{
										fileMatch = {".eslintrc", ".eslintrc.json"},
										url = "https://json.schemastore.org/eslintrc.json"
									},
								}
							end
						end)(),
						validate = { enable = true },
						format = { enable = true },
					},
				},
			})

			-- Bash/Shell Language Server
			safe_setup("bashls", {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "sh", "bash", "zsh", "fish" },
				settings = {
					bashIde = {
						globPattern = "**/*@(.sh|.inc|.bash|.command)",
					},
				},
			})

			-- Ansible Language Server
			safe_setup("ansiblels", {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "yaml.ansible" },
				root_dir = lspconfig.util.root_pattern("ansible.cfg", ".ansible-lint", "playbook.yml", "site.yml"),
				settings = {
					ansible = {
						ansible = {
							path = "ansible",
						},
						executionEnvironment = {
							enabled = false,
						},
						python = {
							interpreterPath = "python3",
						},
						validation = {
							enabled = true,
							lint = {
								enabled = true,
								path = "ansible-lint",
							},
						},
					},
				},
			})

			-- Docker Language Server
			safe_setup("dockerls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					docker = {
						languageserver = {
							formatter = {
								ignoreMultilineInstructions = true,
							},
						},
					},
				},
			})

			-- Markdown Language Server
			safe_setup("marksman", {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "markdown", "markdown.mdx" },
				root_dir = lspconfig.util.root_pattern(".git", ".marksman.toml"),
			})

			-- TypeScript/JavaScript Language Server
			safe_setup("ts_ls", {
				on_attach = function(client, bufnr)
					-- Disable formatting in favor of prettier
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
					on_attach(client, bufnr)
				end,
				capabilities = capabilities,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
					javascript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			})

			-- HTML Language Server
			safe_setup("html", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					html = {
						format = {
							templating = true,
							wrapLineLength = 120,
							wrapAttributes = "auto",
						},
						hover = {
							documentation = true,
							references = true,
						},
					},
				},
			})

			-- CSS Language Server
			safe_setup("cssls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					css = {
						validate = true,
						lint = {
							compatibleVendorPrefixes = "ignore",
							vendorPrefix = "warning",
							duplicateProperties = "warning",
							emptyRules = "warning",
						},
					},
					scss = {
						validate = true,
						lint = {
							compatibleVendorPrefixes = "ignore",
							vendorPrefix = "warning",
							duplicateProperties = "warning",
							emptyRules = "warning",
						},
					},
					less = {
						validate = true,
						lint = {
							compatibleVendorPrefixes = "ignore",
							vendorPrefix = "warning",
							duplicateProperties = "warning",
							emptyRules = "warning",
						},
					},
				},
			})

			-- TOML Language Server
			safe_setup("taplo", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					evenBetterToml = {
						schema = {
							enabled = true,
							repositoryEnabled = true,
							repositoryUrl = "https://taplo.tamasfe.dev/schema_index.json",
						},
					},
				},
			})

			-- Helm Language Server
			safe_setup("helm_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					["helm-ls"] = {
						yamlls = {
							path = "yaml-language-server",
						},
					},
				},
			})

			-- ESLint Language Server
			safe_setup("eslint", {
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
					on_attach(client, bufnr)
				end,
				capabilities = capabilities,
				settings = {
					workingDirectory = { mode = "auto" },
					experimental = {
						useFlatConfig = true,
					},
				},
			})

			-- Grammar and prose checking for documentation (disabled due to stability issues)
			-- safe_setup("ltex", {
			--	on_attach = on_attach,
			--	capabilities = capabilities,
			--	filetypes = { "markdown", "text", "tex", "gitcommit" },
			--	settings = {
			--		ltex = {
			--			language = "en-US",
			--			checkFrequency = "save",
			--			enabled = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
			--			additionalRules = {
			--				enablePickyRules = true,
			--				motherTongue = "en-US",
			--			},
			--		},
			--	},
			-- })

			-- PowerShell Language Server (for Windows environments)
			safe_setup("powershell_es", {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "ps1", "psm1", "psd1" },
				settings = {
					powershell = {
						codeFormatting = {
							preset = "OTBS",
						},
					},
				},
			})

			-- Vim Language Server
			safe_setup("vimls", {
				on_attach = on_attach,
				capabilities = capabilities,
				filetypes = { "vim" },
			})
			
			-- Restore all notification functions after LSP setup is complete
			restore_notifications()
		end,
	},
	-- JSON schema support
	{
		"b0o/schemastore.nvim",
		lazy = true,
	},
	
	-- Enhanced Lua development for Neovim
	{
		"folke/neodev.nvim",
		ft = "lua",
		opts = {
			library = {
				enabled = true,
				runtime = true,
				types = true,
				plugins = true,
			},
			setup_jsonls = true,
			lspconfig = true,
			pathStrict = true,
		},
	},
	
	-- Advanced formatting and linting with null-ls
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			-- Helper function to safely add sources
			local function safe_builtin(builtin_path, config)
				local success, builtin = pcall(function()
					local parts = vim.split(builtin_path, ".", { plain = true })
					local current = null_ls.builtins
					for _, part in ipairs(parts) do
						current = current[part]
						if not current then
							return nil
						end
					end
					return current
				end)
				
				if success and builtin then
					if config then
						return builtin.with(config)
					else
						return builtin
					end
				end
				return nil
			end

			-- Collect only available sources
			local sources = {}
			
			-- Add sources safely
			local function add_source(source)
				if source then
					table.insert(sources, source)
				end
			end

			null_ls.setup({
				border = "rounded",
				cmd = { "nvim" },
				debounce = 250,
				debug = false,
				default_timeout = 5000,
				diagnostics_format = "#{m}",
				fallback_severity = vim.diagnostic.severity.ERROR,
				log_level = "warn",
				notify_format = "[null-ls] %s",
				on_init = nil,
				on_exit = nil,
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", "Makefile", ".git"),
				should_attach = nil,
				temp_dir = nil,
				update_in_insert = false,
				
				sources = (function()
					local sources = {}
					
					-- Lua formatting
					add_source(safe_builtin("formatting.stylua", {
						extra_args = { "--config-path", vim.fn.expand("~/.config/stylua/stylua.toml") },
					}))
					
					-- Python formatting (only if tools are available)
					add_source(safe_builtin("formatting.black", {
						extra_args = { "--fast", "--line-length", "88" },
						condition = function()
							return vim.fn.executable("black") == 1
						end,
					}))
					
					add_source(safe_builtin("formatting.isort", {
						extra_args = { "--profile", "black" },
						condition = function()
							return vim.fn.executable("isort") == 1
						end,
					}))
					
					-- Go formatting (only if tools are available)
					add_source(safe_builtin("formatting.gofumpt"))
					add_source(safe_builtin("formatting.goimports"))
					
					-- Shell formatting (only if available)
					add_source(safe_builtin("formatting.shfmt", {
						extra_args = { "-i", "2", "-ci", "-sr" },
						condition = function()
							return vim.fn.executable("shfmt") == 1
						end,
					}))
					
					-- Terraform formatting (only if available)
					add_source(safe_builtin("formatting.terraform_fmt", {
						condition = function()
							return vim.fn.executable("terraform") == 1
						end,
					}))
					
					-- Prettier for various file types (consolidated)
					add_source(safe_builtin("formatting.prettier", {
						extra_args = { "--prose-wrap", "always" },
						condition = function()
							return vim.fn.executable("prettier") == 1
						end,
					}))
					
					-- Docker linting (only if hadolint is available)
					add_source(safe_builtin("diagnostics.hadolint", {
						condition = function()
							return vim.fn.executable("hadolint") == 1
						end,
					}))
					
					-- ESLint diagnostics removed - use eslint LSP server instead
					
					return sources
				end)(),
				
				-- Enhanced on_attach with formatting
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								-- Format with timeout
								vim.lsp.buf.format({
									bufnr = bufnr,
									timeout_ms = 3000,
									filter = function(client)
										return client.name == "null-ls"
									end,
								})
							end,
						})
					end
				end,
			})
		end,
	},
}
