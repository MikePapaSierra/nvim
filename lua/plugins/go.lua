-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Enhanced Go Development for Cloud Security Engineering                     │
-- │ Optimized for cloud-native development, security tools, and DevOps        │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

return {
	-- Enhanced Go development plugin
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua", -- GUI components for go.nvim
			"neovim/nvim-lspconfig", -- LSP configuration
			"nvim-treesitter/nvim-treesitter", -- Syntax highlighting
			"nvim-telescope/telescope.nvim", -- For better file navigation
			"rcarriga/nvim-notify", -- For enhanced notifications
		},
		event = { "CmdlineEnter" },
		ft = { "go", "gomod", "gosum", "gotmpl" },
		build = ':lua require("go.install").update_all_sync()',
		
		opts = {
			-- Enhanced Go language server configuration
			goimports = "gopls", -- Use gopls for imports (more reliable)
			gofmt = "gofumpt", -- Use gofumpt for better formatting (no max_line_len warnings)
			tag_transform = "camelcase", -- Transform struct tags to camelCase
			tag_options = "json=omitempty", -- Default JSON tag options
			
			-- Cloud security and DevOps specific settings
			comment_placeholder = "   ", -- Better comment alignment
			icons = { 
				breakpoint = "🔴", -- Debug breakpoint
				currentpos = "▶️", -- Current execution position
			},
			
			-- Enhanced diagnostic configuration
			diagnostic = {
				hdlr = true, -- Enable enhanced diagnostics
				underline = true,
				virtual_text = { spacing = 2, prefix = "●" },
				signs = true,
				update_in_insert = false,
			},
			
			-- Professional LSP configuration for cloud development
			lsp_cfg = true, -- Use default configuration from main LSP setup
			lsp_on_attach = true, -- Use go.nvim's attach function
			lsp_keymaps = true, -- Enable enhanced keymaps
			lsp_codelens = true, -- Enable code lenses for better UX
			lsp_diag_hdlr = true, -- Enhanced diagnostic handler
			lsp_inlay_hints = {
				enable = true,
				-- Only enable hints we want to see
				only_current_line = false,
				only_current_line_autocmd = "CursorHold",
				show_variable_name = true,
				parameter_hints_prefix = "󰊕 ",
				show_parameter_hints = true,
				prefix = "»» ",
				highlight = "Comment",
			},
			
			-- Enhanced debugging configuration for cloud applications
			dap_debug = true,
			dap_debug_gui = {
				icons = { expanded = "▾", collapsed = "▸", current_frame = "▶" },
				mappings = {
					expand = { "<CR>", "<2-LeftMouse>" },
					open = "o",
					remove = "d",
					edit = "e",
					repl = "r",
					toggle = "t",
				},
			},
			dap_debug_keymap = true, -- Enable default DAP keymaps
			dap_debug_vt = { enabled_commands = true, all_frames = true },
			
			-- Cloud-native testing configuration
			test_runner = "go", -- Use standard go test
			run_in_floaterm = false, -- Use integrated terminal
			test_efm = true, -- Enhanced error format matching
			test_timeout = "30s", -- Longer timeout for integration tests
			test_env = {
				-- Environment variables for cloud testing
				CGO_ENABLED = "0", -- For static binaries
				GOOS = "linux", -- Target Linux for containers
			},
			
			-- Professional trouble integration for diagnostics
			trouble = true,
			luasnip = true, -- Enable LuaSnip integration
			
			-- Enhanced auto-commands for cloud development
			auto_format = true,
			auto_lint = true,
			lsp_document_formatting = true,
			
			-- Security-focused linters and tools
			lint_prompt_style = "vt", -- Virtual text style
			
			-- Enhanced completion for cloud libraries
			textobjects = true,
			
			-- Cloud security specific tool configurations
			build_tags = "netgo,osusergo", -- Secure build tags
			run_in_floaterm = false, -- Use integrated terminal for better workflow
		},
		
		-- Enhanced keymaps for cloud security development
		keys = {
			-- ╭─────────────────────────────────────────────────────────────────╮
			-- │ Essential Go Development                                        │
			-- ╰─────────────────────────────────────────────────────────────────╯
			{ "<leader>gr", "<cmd>GoRun<cr>", desc = "󰑮 Run Go application", ft = "go" },
			{ "<leader>gb", "<cmd>GoBuild<cr>", desc = "󰔨 Build Go application", ft = "go" },
			{ "<leader>gt", "<cmd>GoTest<cr>", desc = "󰙨 Run Go tests", ft = "go" },
			{ "<leader>gT", "<cmd>GoTestFunc<cr>", desc = "󰙨 Test current function", ft = "go" },
			{ "<leader>gc", "<cmd>GoCoverage<cr>", desc = "󰘬 Show test coverage", ft = "go" },
			
			-- ╭─────────────────────────────────────────────────────────────────╮
			-- │ Code Generation & Refactoring                                  │
			-- ╰─────────────────────────────────────────────────────────────────╯
			{ "<leader>gie", "<cmd>GoIfErr<cr>", desc = "󰅙 Generate if err", ft = "go" },
			{ "<leader>gfs", "<cmd>GoFillStruct<cr>", desc = "󰙏 Fill struct", ft = "go" },
			{ "<leader>gfs", "<cmd>GoFillSwitch<cr>", desc = "󰘬 Fill switch", ft = "go" },
			{ "<leader>gaj", "<cmd>GoAddTag json<cr>", desc = "󰘦 Add JSON tags", ft = "go" },
			{ "<leader>gay", "<cmd>GoAddTag yaml<cr>", desc = "󰘦 Add YAML tags", ft = "go" },
			{ "<leader>grj", "<cmd>GoRmTag json<cr>", desc = "󰆴 Remove JSON tags", ft = "go" },
			{ "<leader>gry", "<cmd>GoRmTag yaml<cr>", desc = "󰆴 Remove YAML tags", ft = "go" },
			{ "<leader>gmt", "<cmd>GoModTidy<cr>", desc = "󰚯 Go mod tidy", ft = "go" },
			
			-- ╭─────────────────────────────────────────────────────────────────╮
			-- │ Testing & Debugging                                             │
			-- ╰─────────────────────────────────────────────────────────────────╯
			{ "<leader>gda", "<cmd>GoDebug<cr>", desc = "󰃤 Start debugging", ft = "go" },
			{ "<leader>gdt", "<cmd>GoDebugTest<cr>", desc = "󰃤 Debug test", ft = "go" },
			{ "<leader>gds", "<cmd>GoDebugStop<cr>", desc = "󰓛 Stop debugging", ft = "go" },
			{ "<leader>gdb", "<cmd>GoBreakToggle<cr>", desc = "󰏃 Toggle breakpoint", ft = "go" },
			{ "<leader>gtc", "<cmd>GoTestFile<cr>", desc = "󰙨 Test current file", ft = "go" },
			{ "<leader>gtp", "<cmd>GoTestPkg<cr>", desc = "󰙨 Test current package", ft = "go" },
			
			-- ╭─────────────────────────────────────────────────────────────────╮
			-- │ Cloud Security & DevOps Specific                               │
			-- ╰─────────────────────────────────────────────────────────────────╯
			{ "<leader>gci", "<cmd>GoInstall<cr>", desc = "󰏔 Install dependencies", ft = "go" },
			{ "<leader>gcb", "<cmd>GoBuild -tags=netgo,osusergo<cr>", desc = "󰔨 Build for containers", ft = "go" },
			{ "<leader>gcr", "<cmd>GoRun -tags=netgo<cr>", desc = "󰑮 Run with secure tags", ft = "go" },
			{ "<leader>gct", "<cmd>GoTest -tags=integration<cr>", desc = "󰙨 Run integration tests", ft = "go" },
			
			-- ╭─────────────────────────────────────────────────────────────────╮
			-- │ Code Navigation & Documentation                                 │
			-- ╰─────────────────────────────────────────────────────────────────╮
			{ "<leader>gdd", "<cmd>GoDoc<cr>", desc = "󰈙 Show documentation", ft = "go" },
			{ "<leader>gdv", "<cmd>GoDocBrowser<cr>", desc = "󰈹 Open docs in browser", ft = "go" },
			{ "<leader>gim", "<cmd>GoImpl<cr>", desc = "󰙨 Generate interface implementation", ft = "go" },
			{ "<leader>gin", "<cmd>GoImplements<cr>", desc = "󰙨 Show implementations", ft = "go" },
			{ "<leader>gca", "<cmd>GoCallees<cr>", desc = "󰆘 Show callees", ft = "go" },
			{ "<leader>gcr", "<cmd>GoCallers<cr>", desc = "󰆗 Show callers", ft = "go" },
			{ "<leader>gch", "<cmd>GoChannelPeers<cr>", desc = "󰆘 Show channel peers", ft = "go" },
			
			-- ╭─────────────────────────────────────────────────────────────────╮
			-- │ Advanced Tooling                                                │
			-- ╰─────────────────────────────────────────────────────────────────╯
			{ "<leader>glt", "<cmd>GoLint<cr>", desc = "󰁨 Run linter", ft = "go" },
			{ "<leader>gve", "<cmd>GoVet<cr>", desc = "󰁨 Run go vet", ft = "go" },
			{ "<leader>gvp", "<cmd>GoVulnCheck<cr>", desc = "󰒃 Check vulnerabilities", ft = "go" },
			{ "<leader>gal", "<cmd>GoAlt<cr>", desc = "󰘬 Switch to alternative file", ft = "go" },
			{ "<leader>gas", "<cmd>GoAltS<cr>", desc = "󰘬 Switch to alternative (split)", ft = "go" },
			{ "<leader>gav", "<cmd>GoAltV<cr>", desc = "󰘬 Switch to alternative (vsplit)", ft = "go" },
		},
		
		config = function(_, opts)
			-- Setup go.nvim with enhanced configuration
			require("go").setup(opts)
			
			-- Load cloud security snippets for Go
			local luasnip = require("luasnip")
			local go_snippets = require("config.go-snippets")
			luasnip.add_snippets("go", go_snippets)
			
			-- Enhanced auto-commands for cloud security development
			local go_group = vim.api.nvim_create_augroup("GoCloudSecurity", { clear = true })
			
			-- Auto-format on save with security-focused formatting
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = go_group,
				pattern = "*.go",
				callback = function()
					-- Format imports and code
					require("go.format").goimport()
					vim.lsp.buf.format({ async = false })
				end,
			})
			
			-- Auto-generate missing imports for cloud libraries
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = go_group,
				pattern = "*.go",
				callback = function()
					local params = vim.lsp.util.make_range_params()
					params.context = { only = { "source.organizeImports" } }
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
					for _, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							if r.edit then
								vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
							end
						end
					end
				end,
			})
			
			-- Cloud security specific auto-commands
			vim.api.nvim_create_autocmd("FileType", {
				group = go_group,
				pattern = "go",
				callback = function()
					-- Set buffer-local options for Go development
					vim.opt_local.tabstop = 4
					vim.opt_local.shiftwidth = 4
					vim.opt_local.expandtab = false -- Go uses tabs
					vim.opt_local.textwidth = 120
					
					-- Enhanced folding for better code navigation
					vim.opt_local.foldmethod = "expr"
					vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
					vim.opt_local.foldlevel = 1
					
					-- Security-focused settings
					vim.opt_local.conceallevel = 0 -- Don't hide sensitive information
				end,
			})
			
			-- Cloud security project templates
			vim.api.nvim_create_user_command("GoNewCloudProject", function(opts)
				local project_name = opts.args or "cloud-app"
				local template = [[
package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/health", healthHandler)
	mux.HandleFunc("/", rootHandler)

	server := &http.Server{
		Addr:         ":8080",
		Handler:      mux,
		ReadTimeout:  15 * time.Second,
		WriteTimeout: 15 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	go func() {
		log.Printf("Starting server on %s", server.Addr)
		if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("Server failed to start: %v", err)
		}
	}()

	// Graceful shutdown
	c := make(chan os.Signal, 1)
	signal.Notify(c, os.Interrupt, syscall.SIGTERM)
	<-c

	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	server.Shutdown(ctx)
	log.Println("Server stopped")
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	fmt.Fprintln(w, "OK")
}

func rootHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello from %s!", "]] .. project_name .. [[")
}
]]
				
				-- Create the file
				vim.cmd("edit " .. project_name .. "/main.go")
				vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(template, "\n"))
				vim.cmd("write")
				
				vim.notify("Created cloud-native Go project: " .. project_name, vim.log.levels.INFO, {
					title = "󰟓 Go Cloud Project"
				})
			end, {
				desc = "Create new cloud-native Go project",
				nargs = "?",
			})
			
			-- Enhanced user commands for Go development
			local go_setup = require("config.go-setup")
			local go_templates = require("config.go-templates")
			
			-- Setup validation commands
			vim.api.nvim_create_user_command("GoSetupStatus", function()
				go_setup.show_status()
			end, {
				desc = "Show Go development environment status",
			})
			
			vim.api.nvim_create_user_command("GoInstallTools", function()
				go_setup.install_tools()
			end, {
				desc = "Install missing Go development tools",
			})
			
			vim.api.nvim_create_user_command("GoInstallSecurityTools", function()
				go_setup.install_security_tools()
			end, {
				desc = "Install Go security analysis tools",
			})
			
			-- Project template commands
			vim.api.nvim_create_user_command("GoNewMicroservice", function(opts)
				go_templates.create_microservice(opts.args)
			end, {
				desc = "Create new cloud-native microservice project",
				nargs = "?",
			})
			
			vim.api.nvim_create_user_command("GoNewSecurityScanner", function(opts)
				go_templates.create_security_scanner(opts.args)
			end, {
				desc = "Create new cloud security scanner project",
				nargs = "?",
			})
			
			vim.api.nvim_create_user_command("GoNewIaCValidator", function(opts)
				go_templates.create_iac_validator(opts.args)
			end, {
				desc = "Create new Infrastructure as Code validator project",
				nargs = "?",
			})
			
			-- Cloud security project templates (legacy command for compatibility)
			vim.api.nvim_create_user_command("GoNewCloudProject", function(opts)
				go_templates.create_microservice(opts.args)
			end, {
				desc = "Create new cloud-native Go project",
				nargs = "?",
			})
			
			-- Help command to show all Go commands
			vim.api.nvim_create_user_command("GoHelp", function()
				local commands = {
					"── 🛠️  Setup & Validation ──",
					":GoSetupStatus - Show Go development environment status",
					":GoInstallTools - Install missing Go development tools",
					":GoInstallSecurityTools - Install Go security analysis tools",
					"",
					"── 📦 Project Templates ──",
					":GoNewMicroservice [name] - Create cloud-native microservice",
					":GoNewSecurityScanner [name] - Create security scanner project",
					":GoNewIaCValidator [name] - Create Infrastructure as Code validator",
					":GoNewCloudProject [name] - Create basic cloud project (legacy)",
					"",
					"── 🔧 Development ──",
					"<leader>gr - Run Go application",
					"<leader>gb - Build Go application",
					"<leader>gt - Run Go tests",
					"<leader>gT - Test current function",
					"<leader>gc - Show test coverage",
					"",
					"── 🏗️  Code Generation ──",
					"<leader>gie - Generate if err block",
					"<leader>gfs - Fill struct/switch",
					"<leader>gaj - Add JSON tags",
					"<leader>gay - Add YAML tags",
					"<leader>grj - Remove JSON tags",
					"<leader>gry - Remove YAML tags",
					"<leader>gmt - Go mod tidy",
					"",
					"── 🐛 Testing & Debugging ──",
					"<leader>gda - Start debugging",
					"<leader>gdt - Debug test",
					"<leader>gds - Stop debugging",
					"<leader>gdb - Toggle breakpoint",
					"<leader>gtc - Test current file",
					"<leader>gtp - Test current package",
					"",
					"── ☁️  Cloud Security ──",
					"<leader>gcb - Build for containers",
					"<leader>gcr - Run with secure tags",
					"<leader>gct - Run integration tests",
					"<leader>gvp - Check vulnerabilities",
					"<leader>glt - Run linter",
					"<leader>gve - Run go vet",
					"",
					"── 📚 Navigation & Docs ──",
					"<leader>gdd - Show documentation",
					"<leader>gdv - Open docs in browser",
					"<leader>gim - Generate interface implementation",
					"<leader>gin - Show implementations",
					"<leader>gca - Show callees",
					"<leader>gcr - Show callers",
					"<leader>gal - Switch to alternative file",
				}
				
				vim.notify(table.concat(commands, "\n"), vim.log.levels.INFO, {
					title = "󰟓 Go Development Commands",
					timeout = false, -- Don't auto-close
				})
			end, {
				desc = "Show all available Go development commands",
			})
			-- Go setup complete (notification disabled for cleaner startup)
		end,
	},
	
	-- Additional Go development enhancements
	{
		"olexsmir/gopher.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		ft = "go",
		config = function()
			require("gopher").setup({
				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "gotests", -- Generate table tests
					impl = "impl",
					iferr = "iferr",
				},
			})
		end,
		-- Enhanced keymaps for gopher
		keys = {
			{ "<leader>gsj", "<cmd>GoTagAdd json<cr>", desc = "󰘦 Add JSON struct tags", ft = "go" },
			{ "<leader>gsy", "<cmd>GoTagAdd yaml<cr>", desc = "󰘦 Add YAML struct tags", ft = "go" },
			{ "<leader>gst", "<cmd>GoTestAdd<cr>", desc = "󰙨 Add tests for function", ft = "go" },
			{ "<leader>gse", "<cmd>GoIfErr<cr>", desc = "󰅙 Add if err block", ft = "go" },
			{ "<leader>gsi", "<cmd>GoImpl<cr>", desc = "󰙨 Implement interface", ft = "go" },
		},
	},
}
