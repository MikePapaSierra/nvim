return {
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({
                ui = {
                    icons = {
                        package_installed = '✓',
                        package_pending = '➜',
                        package_uninstalled = '✗'
                    }
                },
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "golines",
                    "goimports",
                    "delve",
                }
            })
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                --ensure_installed = {
                --    'lua_ls',
                --    "gopls",
                --    "golines",
                --    "goimports",
                --    "delve",
                --},
                auto_install = true,
            })
        end
    },
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPost" },
        config = function()
            local on_attach = require('cmp_nvim_lsp').on_attach
            local capabilities = require('cmp_nvim_lsp').default_cpapbilities
            local lspconfig = require('lspconfig')
            local util = require('lspconfig/util')
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })
            lspconfig.pyright.setup({
                on_attach = on_attach,
                capabilities = capabilities
            })
            lspconfig.ansiblels.setup({
                capabilities = capabilities
            })
            lspconfig.gopls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        }
                    }
                }
            })
        end
    },
    {
        'nvimtools/none-ls.nvim',
        config = function()
            local null_ls = require('null-ls')
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.isort,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,
                    null_ls.builtins.formatting.golines,
                    -- TODO: [null-ls] failed to load builtin ansible_lint for method formatting; please check your config
                    -- [lspconfig] Cannot access configuration for ansible. Ensure this server is listed in `server_configurations.md` or added as a custom server.
                    --	null_ls.builtins.formatting.ansible_lint,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
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
            vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
        end
    },
    {
        'folke/neodev.nvim',
        config = function()
            require('neodev').setup()
        end
    },
}
