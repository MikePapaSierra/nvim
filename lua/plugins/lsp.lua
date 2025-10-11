return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPost" },
        dependencies = {
            -- LSP management
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            -- Auto-install LSPs, linters, formatters, debbugers
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            -- Usefull status updates for LSP
            { "j-hui/fidget.nvim",                        opts = {} },
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = {
                    "bashls",
                    "lua_ls",
                    "pyright",
                    "yamlls",
                    "jsonls"
                },
            })

            require("mason-tool-installer").setup({
                ensure_installed = {
                    "black",
                    "debugpy",
                    "flake8",
                    "isort",
                    "mypy",
                    "pylint"
                },
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Define on_attach function
            local on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
            end

            -- Configure LSP servers using vim.lsp.config (Neovim 0.11+)
            vim.lsp.config.lua_ls = {
                cmd = { "lua-language-server" },
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                        diagnostics = {
                            globals = { "vim" }
                        }
                    },
                },
            }

            vim.lsp.config.bashls = {
                cmd = { "bash-language-server", "start" },
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "sh", "bash" },
            }

            vim.lsp.config.pyright = {
                cmd = { "pyright-langserver", "--stdio" },
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "python" },
            }

            vim.lsp.config.ansiblels = {
                cmd = { "ansible-language-server", "--stdio" },
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "yaml.ansible" },
                settings = {
                    ansible = {
                        ansible = {
                            path = "ansible",
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
            }

            vim.lsp.config.terraformls = {
                cmd = { "terraform-ls", "serve" },
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "terraform", "terraform-vars" },
            }

            vim.lsp.config.tflint = {
                cmd = { "tflint", "--langserver" },
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "terraform" },
            }

            vim.lsp.config.gopls = {
                cmd = { "gopls" },
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
            }

            vim.lsp.config.yamlls = {
                cmd = { "yaml-language-server", "--stdio" },
                on_attach = on_attach,
                capabilities = capabilities,
            }

            vim.lsp.config.jsonls = {
                cmd = { "vscode-json-language-server", "--stdio" },
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.golines,
                },
                on_attach = function(client, bufnr)
                    if client:supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr,
                        })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
        end,
    },
    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup()
        end,
    },
}
