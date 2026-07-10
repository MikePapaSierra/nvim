return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context", -- Show current function context
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				-- Core Neovim languages
				"lua",
				"vim", 
				"vimdoc",
				"query",
				"luadoc",
				"luap", -- Lua patterns
				
				-- Cloud Security Engineering Core Stack
				"python",
				"go", 
				"gomod",
				"gowork",
				"gotmpl", -- Go templates
				"gosum", -- Go sum files
				
				-- Infrastructure as Code (IaC)
				"terraform",
				"hcl", -- HashiCorp Configuration Language
				
				-- Configuration & Data Formats
				"yaml",
				"json",
				"jsonc", -- JSON with comments
				"json5", -- JSON5 format
				"toml",
				"xml",
				"csv",
				"ini",
				
				-- Cloud & Container Technologies
				"dockerfile",
				"helm", -- Kubernetes Helm charts
				
				-- Shell & Scripting for DevOps
				"bash",
				"fish", -- Your shell
				"powershell",
				"nu", -- Nushell for modern shell scripting
				
				-- Policy and Security Languages
				"rego", -- Open Policy Agent (OPA) Rego
				"sparql", -- SPARQL for semantic queries
				
				-- Documentation & Config
				"markdown",
				"markdown_inline",
				"rst", -- ReStructuredText
				
				-- Database & Query Languages
				"sql",
				"regex", -- Regular expressions
				
				-- Git & Version Control
				"git_config",
				"git_rebase", 
				"gitcommit",
				"gitignore",
				"gitattributes",
				"diff", -- Git diff files
				
				-- Web Technologies (for cloud dashboards/APIs)
				"html",
				"css",
				"scss",
				"javascript",
				"typescript",
				"tsx",
				"jsdoc", -- JavaScript documentation
				
				-- Systems Programming (for security tools)
				"c",
				"cpp",
				"rust", -- Popular for security tools
				"zig", -- Modern systems language
				
				-- Build Systems & CI/CD
				"make",
				"cmake",
				"ninja",
				"meson", -- Modern build system
				"just", -- Command runner (alternative to Make)
				
				-- Network & Protocol Analysis
				"proto", -- Protocol Buffers
				"thrift", -- Apache Thrift
				"capnp", -- Cap'n Proto
				
				-- Configuration Management
				"puppet", -- Puppet configuration
				"nix", -- Nix package manager
				
				-- Additional Security & DevOps
				"graphql", -- GraphQL for APIs
				"elvish", -- Elvish shell
				"comment", -- Enhanced comment parsing
				
				-- Cloud Provider Specific
				"bicep", -- Azure Bicep
				"cue", -- CUE configuration language
			},
			-- Performance and installation settings
			auto_install = true, -- Auto-install missing parsers
			sync_install = false, -- Install parsers asynchronously
			ignore_install = {}, -- No parsers to ignore
			
			-- Enhanced syntax highlighting
			highlight = {
				enable = true,
				disable = function(lang, buf)
					-- Disable for very large files to prevent performance issues
					local max_filesize = 200 * 1024 -- 200KB (increased for config files)
					local ok, status = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and status and status.size > max_filesize then
						return true
					end
					-- Disable for binary files
					local filename = vim.api.nvim_buf_get_name(buf)
					if filename:match("%.zip$") or filename:match("%.tar$") or filename:match("%.gz$") then
						return true
					end
					return false
				end,
				-- Additional highlighting for specific languages
				additional_vim_regex_highlighting = { 
					"markdown", -- Better markdown highlighting
					"yaml", -- Enhanced YAML highlighting for Ansible/K8s
					"terraform", -- Better Terraform highlighting
				},
			},
			
			-- Smart indentation
			indent = { 
				enable = true,
				disable = { 
					"yaml", -- YAML indentation can be problematic with complex structures
					"python", -- Python has strict indentation rules
					"terraform", -- Terraform has specific formatting rules
				},
			},
			
			-- Incremental selection
	        incremental_selection = {
	            enable = true,
	            keymaps = {
	                init_selection = "<C-space>",
	                node_incremental = "<C-space>",
	                scope_incremental = "<C-s>",
	                node_decremental = "<bs>",
	            },
	        },
	        
	        -- Text objects for functions, classes, etc.
	        -- Advanced text objects for cloud security engineering
	        textobjects = {
	        	select = {
	        		enable = true,
	        		lookahead = true, -- Automatically jump forward to textobj
	        		keymaps = {
	        			-- Core programming constructs
	        			["af"] = "@function.outer",
	        			["if"] = "@function.inner",
	        			["ac"] = "@class.outer",
	        			["ic"] = "@class.inner",
	        			["aa"] = "@parameter.outer",
	        			["ia"] = "@parameter.inner",
	        			["ab"] = "@block.outer",
	        			["ib"] = "@block.inner",
	        			["as"] = "@statement.outer",
	        			["is"] = "@statement.inner",
	        			["ad"] = "@conditional.outer",
	        			["id"] = "@conditional.inner",
	        			["al"] = "@loop.outer",
	        			["il"] = "@loop.inner",
	        			["ak"] = "@call.outer",
	        			["ik"] = "@call.inner",
	        			["at"] = "@comment.outer",
	        			["it"] = "@comment.inner",
	        			
	        			-- Cloud/Infrastructure specific
	        			["ar"] = "@assignment.outer", -- Resource assignments in Terraform
	        			["ir"] = "@assignment.inner",
	        			["ao"] = "@attribute.outer", -- Object attributes (JSON/YAML)
	        			["io"] = "@attribute.inner",
	        			["an"] = "@number.outer", -- Numbers (ports, IDs, etc.)
	        			["in"] = "@number.inner",
	        			["aq"] = "@string.outer", -- Strings (often contain important values)
	        			["iq"] = "@string.inner",
	        			
	        			-- Security-focused selections
	        			["ap"] = "@property.outer", -- Properties in config files
	        			["ip"] = "@property.inner",
	        			["av"] = "@variable.outer", -- Variables in scripts/configs
	        			["iv"] = "@variable.inner",
	        		},
	        		selection_modes = {
	        			['@parameter.outer'] = 'v', -- charwise for parameters
	        			['@function.outer'] = 'V', -- linewise for functions
	        			['@class.outer'] = 'V', -- linewise for classes
	        			['@block.outer'] = 'V', -- linewise for blocks
	        			['@assignment.outer'] = 'V', -- linewise for resource blocks
	        			['@attribute.outer'] = 'v', -- charwise for attributes
	        		},
	        		include_surrounding_whitespace = true,
	        	},
	        	
	        	-- Enhanced navigation for cloud security workflows
	        	move = {
	        		enable = true,
	        		set_jumps = true, -- Add to jumplist for easier navigation
	        		goto_next_start = {
	        			-- Core programming navigation
	        			["]f"] = "@function.outer",
	        			["]c"] = "@class.outer",
	        			["]a"] = "@parameter.inner",
	        			["]b"] = "@block.outer",
	        			["]s"] = "@statement.outer",
	        			["]d"] = "@conditional.outer",
	        			["]l"] = "@loop.outer",
	        			
	        			-- Infrastructure/DevOps specific navigation
	        			["]r"] = "@assignment.outer", -- Next resource block (Terraform)
	        			["]p"] = "@property.outer", -- Next property (JSON/YAML)
	        			["]v"] = "@variable.outer", -- Next variable definition
	        			["]k"] = "@call.outer", -- Next function call
	        			["]t"] = "@comment.outer", -- Next comment (often contains TODOs)
	        		},
	        		goto_next_end = {
	        			["]F"] = "@function.outer",
	        			["]C"] = "@class.outer",
	        			["]A"] = "@parameter.inner", 
	        			["]B"] = "@block.outer",
	        			["]S"] = "@statement.outer",
	        			["]D"] = "@conditional.outer",
	        			["]L"] = "@loop.outer",
	        			["]R"] = "@assignment.outer",
	        			["]P"] = "@property.outer",
	        			["]V"] = "@variable.outer",
	        			["]K"] = "@call.outer",
	        			["]T"] = "@comment.outer",
	        		},
	        		goto_previous_start = {
	        			["[f"] = "@function.outer",
	        			["[c"] = "@class.outer",
	        			["[a"] = "@parameter.inner",
	        			["[b"] = "@block.outer",
	        			["[s"] = "@statement.outer",
	        			["[d"] = "@conditional.outer",
	        			["[l"] = "@loop.outer",
	        			["[r"] = "@assignment.outer",
	        			["[p"] = "@property.outer",
	        			["[v"] = "@variable.outer",
	        			["[k"] = "@call.outer",
	        			["[t"] = "@comment.outer",
	        		},
	        		goto_previous_end = {
	        			["[F"] = "@function.outer",
	        			["[C"] = "@class.outer",
	        			["[A"] = "@parameter.inner",
	        			["[B"] = "@block.outer",
	        			["[S"] = "@statement.outer",
	        			["[D"] = "@conditional.outer",
	        			["[L"] = "@loop.outer",
	        			["[R"] = "@assignment.outer",
	        			["[P"] = "@property.outer",
	        			["[V"] = "@variable.outer",
	        			["[K"] = "@call.outer",
	        			["[T"] = "@comment.outer",
	        		},
	        	},
	        	
	        	-- Smart swapping for refactoring
	        	swap = {
	        		enable = true,
	        		swap_next = {
	        			-- Core swapping
	        			["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
	        			["<leader>nf"] = "@function.outer", -- swap function with next
	        			["<leader>nb"] = "@block.outer", -- swap block with next
	        			
	        			-- Infrastructure specific swapping
	        			["<leader>nr"] = "@assignment.outer", -- swap resource blocks
	        			["<leader>np"] = "@property.outer", -- swap properties in configs
	        			["<leader>nv"] = "@variable.outer", -- swap variable definitions
	        		},
	        		swap_previous = {
	        			["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
	        			["<leader>pf"] = "@function.outer", -- swap function with previous
	        			["<leader>pb"] = "@block.outer", -- swap block with previous
	        			["<leader>pr"] = "@assignment.outer", -- swap resource blocks
	        			["<leader>pp"] = "@property.outer", -- swap properties in configs
	        			["<leader>pv"] = "@variable.outer", -- swap variable definitions
	        		},
	        	},
	        	
	        	-- LSP interop for definitions, references, etc.
	        	lsp_interop = {
	        		enable = true,
	        		border = 'none',
	        		floating_preview_opts = {},
	        		peek_definition_code = {
	        			["<leader>df"] = "@function.outer",
	        			["<leader>dF"] = "@class.outer",
	        		},
	        	},
	        },
		},
		config = function(_, opts)
			local configs = require("nvim-treesitter.configs")
			configs.setup(opts)
			
			-- Enhanced folding configuration optimized for config files
			vim.opt.foldmethod = "expr"
			vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
			vim.opt.foldenable = false -- Don't fold by default (better for security auditing)
			vim.opt.foldlevel = 99 -- Keep everything unfolded by default
			vim.opt.foldminlines = 3 -- Require at least 3 lines to create a fold
			vim.opt.foldnestmax = 10 -- Limit fold depth for complex configs
			
			-- Cloud security specific file type associations
			vim.filetype.add({
				extension = {
					-- Terraform files
					tf = "terraform",
					tfvars = "terraform",
					tfstate = "json", -- Terraform state files are JSON
					
					-- Kubernetes files (use yaml parser)
					yaml = "yaml",
					yml = "yaml",
					
					-- Ansible files (use yaml parser)
					["ansible.yml"] = "yaml",
					["ansible.yaml"] = "yaml",
					
					-- CloudFormation files
					template = function(path, bufnr)
						if path:match("cloudformation") or path:match("cfn") then
							return "yaml" -- or "json" depending on format
						end
						return "yaml"
					end,
					
					-- Docker files
					dockerfile = "dockerfile",
					Dockerfile = "dockerfile",
					containerfile = "dockerfile",
					
					-- Policy files
					rego = "rego", -- Open Policy Agent
					
					-- Other cloud configs
					bicep = "bicep", -- Azure Bicep
					cue = "cue", -- CUE configuration
				},
				filename = {
					-- Docker files
					["Dockerfile"] = "dockerfile",
					["Dockerfile.dev"] = "dockerfile",
					["Dockerfile.prod"] = "dockerfile",
					["Containerfile"] = "dockerfile",
					
					-- Kubernetes files
					["kustomization.yaml"] = "yaml",
					["kustomization.yml"] = "yaml",
					
					-- Terraform files
					[".terraform.lock.hcl"] = "hcl",
					
					-- Ansible files
					["playbook.yml"] = "yaml",
					["playbook.yaml"] = "yaml",
					["inventory"] = "ini",
					["ansible.cfg"] = "ini",
					
					-- CI/CD files
					[".github/workflows/*.yml"] = "yaml",
					[".github/workflows/*.yaml"] = "yaml",
					[".gitlab-ci.yml"] = "yaml",
					["azure-pipelines.yml"] = "yaml",
					["buildkite.yml"] = "yaml",
					
					-- Cloud provider configs
					[".aws/config"] = "ini",
					[".aws/credentials"] = "ini",
					["gcloud.json"] = "json",
					
					-- Security tools configs
					[".tfsec.yml"] = "yaml",
					[".checkov.yml"] = "yaml",
					[".semgrep.yml"] = "yaml",
					["policy.rego"] = "rego",
				},
			})
			
			-- Enhanced keymaps for cloud security workflows
			local keymap = vim.keymap.set
			keymap("n", "<leader>ts", "<cmd>TSToggle highlight<cr>", { desc = "Toggle Treesitter highlighting" })
			keymap("n", "<leader>tc", "<cmd>TSContextToggle<cr>", { desc = "Toggle Treesitter context" })
			keymap("n", "<leader>tl", function()
				vim.opt.foldenable = not vim.opt.foldenable:get()
				print("Treesitter folding:", vim.opt.foldenable:get() and "enabled" or "disabled")
			end, { desc = "Toggle Treesitter folding" })
			
			-- Security-focused text object shortcuts
			keymap("n", "<leader>sr", "vir<cmd>Telescope lsp_references<cr>", { desc = "Search references for current resource" })
			keymap("n", "<leader>sf", "vif<cmd>Telescope lsp_document_symbols<cr>", { desc = "Search symbols in current function" })
		end,
	},
	
	-- Treesitter context for showing current function/block
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 4, -- Show up to 4 lines of context
				min_window_height = 10, -- Minimum editor window height to enable context
				line_numbers = true,
				multiline_threshold = 2, -- Maximum number of lines to show for a single context
				trim_scope = 'outer', -- Remove outer scope when exceeding max_lines
				mode = 'cursor', -- Line used to calculate context ('cursor' or 'topline')
				-- Separator between context and content
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = function(bufnr)
					-- Enable context for specific file types relevant to cloud security
					local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
					return vim.tbl_contains({
						"python", "go", "terraform", "yaml", "json", "lua", "bash", 
						"dockerfile", "hcl", "rego", "yaml.kubernetes", "yaml.ansible"
					}, ft)
				end,
			})
			
			-- Keymaps for context navigation
			vim.keymap.set("n", "[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true, desc = "Go to context" })
		end,
	}
}
