# 🔧 LSP Configuration Guide

Comprehensive guide to Language Server Protocol (LSP) configuration optimized for cloud security engineering.

## Table of Contents

- [🎯 Overview](#-overview)
- [🚀 Quick Start](#-quick-start)
- [🗄️ Language Servers](#️-language-servers)
- [🔧 Configuration Details](#-configuration-details)
- [🛠️ Tools & Formatters](#️-tools--formatters)
- [🐛 Troubleshooting](#-troubleshooting)
- [⚡ Performance](#-performance)
- [🎨 Customization](#-customization)

---

## 🎯 Overview

This configuration provides a comprehensive LSP setup with 20+ language servers, security tools, and formatters optimized for cloud security engineering workflows.

### Key Features
- **Auto-installation**: Mason manages all servers automatically
- **Security Focus**: Integrated security linters and scanners
- **Cloud Native**: Terraform, Kubernetes, Docker support
- **Performance**: Optimized diagnostics and completion
- **Extensible**: Easy to add new languages and tools

### Architecture
```
LSP Configuration
├── Mason (Package Manager)
├── LSP Servers (20+)
├── Formatters & Linters
├── Diagnostics & Completion
└── Custom Configurations
```

---

## 🚀 Quick Start

### Installation
LSP servers are automatically installed on first use. Manual installation:

```vim
" Open Mason package manager
:Mason

" Install specific server
:MasonInstall pyright

" Update all packages
:MasonUpdate
```

### Health Check
```vim
" Check LSP health
:checkhealth lsp

" Check Mason health
:checkhealth mason

" Check specific server
:LspInfo
```

### Basic Usage
```vim
" Go to definition
gd

" Show hover documentation
K

" Find references
gr

" Code actions
<leader>ca

" Rename symbol
<leader>rn

" Format document
<leader>f
```

---

## 🗄️ Language Servers

### Python
**Servers**: `pylsp`, `pyright`  
**Focus**: Security analysis, type checking, cloud SDK support

#### Features
- **Type Checking**: Static type analysis with pyright
- **Security Scanning**: Integrated bandit for vulnerability detection
- **Cloud SDKs**: boto3, azure-sdk, google-cloud support
- **Linting**: Comprehensive code quality checks
- **Formatting**: Black, isort integration

#### Configuration
```lua
-- Python LSP with security focus
pylsp = {
    settings = {
        pylsp = {
            plugins = {
                -- Code analysis
                pylint = { enabled = true },
                pyflakes = { enabled = true },
                pycodestyle = { enabled = true },
                
                -- Security
                bandit = { enabled = true },
                
                -- Formatting
                black = { enabled = true },
                isort = { enabled = true },
                
                -- Type checking (disabled, using pyright)
                mypy = { enabled = false },
            }
        }
    }
}
```

#### Cloud Security Features
- **AWS**: boto3 completions, CloudFormation validation
- **Azure**: azure-sdk support, ARM template checking
- **GCP**: google-cloud-sdk completions
- **Security**: Hardcoded secret detection, SQL injection analysis

---

### Go
**Server**: `gopls`  
**Focus**: Cloud-native applications, microservices, Kubernetes

#### Features
- **Cloud Native**: Kubernetes client-go support
- **Performance**: Optimized for large codebases
- **Security**: gosec integration for security analysis
- **Modules**: Go modules support with proxy configuration
- **Testing**: Integrated test discovery and running

#### Configuration
```lua
gopls = {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
            },
            staticcheck = true,
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            experimentalWorkspaceModule = true,
        }
    }
}
```

---

### JavaScript/TypeScript
**Servers**: `ts_ls`, `eslint`  
**Focus**: Modern web development, Node.js security

#### Features
- **Modern JS/TS**: Latest ECMAScript support
- **Security**: ESLint security rules
- **Node.js**: Server-side development support
- **Frameworks**: React, Vue, Angular support
- **Performance**: Incremental type checking

#### Security Rules
```json
{
  "extends": [
    "eslint:recommended",
    "@typescript-eslint/recommended",
    "plugin:security/recommended"
  ],
  "rules": {
    "security/detect-object-injection": "error",
    "security/detect-non-literal-fs-filename": "error",
    "security/detect-unsafe-regex": "error"
  }
}
```

---

### Infrastructure as Code

#### Terraform
**Server**: `terraformls`  
**Focus**: Infrastructure security, best practices

**Features**:
- **Syntax Validation**: HCL syntax checking
- **Provider Support**: AWS, Azure, GCP providers
- **Security**: Resource configuration validation
- **Documentation**: Inline provider documentation

#### Ansible
**Server**: `ansiblels`  
**Focus**: Configuration management security

**Features**:
- **Playbook Validation**: YAML and Ansible syntax
- **Security**: ansible-lint integration
- **Best Practices**: Role and task optimization
- **Vault Support**: Encrypted variable handling

#### Kubernetes
**Server**: `yamlls` with Kubernetes schemas  
**Focus**: Container orchestration security

**Features**:
- **Manifest Validation**: Kubernetes resource validation
- **Security Policies**: Pod security standards
- **Best Practices**: Resource limits, probes
- **Custom Resources**: CRD support

---

### Configuration Files

#### YAML
**Server**: `yamlls`  
**Schemas**: Kubernetes, GitHub Actions, Docker Compose

```lua
yamlls = {
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "k8s/*.yaml",
            },
            validate = true,
            completion = true,
        }
    }
}
```

#### JSON
**Server**: `jsonls`  
**Features**: Schema validation, IntelliSense

#### Docker
**Server**: `dockerls`  
**Features**: Dockerfile optimization, security scanning

---

### Shell Scripting
**Server**: `bashls`  
**Tools**: `shellcheck` for static analysis

#### Features
- **Syntax Checking**: Bash/sh syntax validation
- **Security**: Command injection detection
- **Best Practices**: POSIX compliance checking
- **Performance**: Inefficient pattern detection

---

### Documentation

#### Markdown
**Server**: `marksman`  
**Features**: Link validation, structure analysis

#### LaTeX
**Server**: `texlab`  
**Features**: Document compilation, bibliography

---

## 🔧 Configuration Details

### Mason Setup
Located in: `lua/plugins/lsp.lua`

```lua
-- Mason configuration
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- Auto-install servers
local servers = {
    -- Python
    "pyright",
    "pylsp",
    
    -- Go
    "gopls",
    
    -- JavaScript/TypeScript
    "ts_ls",
    "eslint",
    
    -- Infrastructure
    "terraformls",
    "ansiblels",
    
    -- Configuration
    "yamlls",
    "jsonls",
    "dockerls",
    
    -- Shell
    "bashls",
    
    -- Documentation
    "marksman",
    "texlab",
    
    -- Lua (for Neovim config)
    "lua_ls",
}

mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})
```

### LSP Server Configuration

#### Capabilities
```lua
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
```

#### On Attach Function
```lua
local function on_attach(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    
    -- Mappings
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format { async = true }
    end, bufopts)
    
    -- Document highlighting
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            group = "lsp_document_highlight",
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end
```

### Diagnostic Configuration
```lua
vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        source = "if_many",
    },
    float = {
        source = "always",
        border = "rounded",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
```

---

## 🛠️ Tools & Formatters

### Formatters
Auto-installed via Mason:

#### Python
- **Black**: Code formatting
- **isort**: Import sorting
- **autopep8**: PEP 8 compliance

#### Go
- **gofmt**: Standard Go formatting
- **goimports**: Import management
- **gofumpt**: Stricter formatting

#### JavaScript/TypeScript
- **Prettier**: Code formatting
- **ESLint**: Linting with auto-fix

#### Other Languages
- **shfmt**: Shell script formatting
- **terraform fmt**: Terraform formatting
- **yamlfmt**: YAML formatting

### Linters

#### Security Focused
- **bandit**: Python security scanner
- **gosec**: Go security scanner
- **eslint-plugin-security**: JavaScript security
- **shellcheck**: Shell script analysis
- **tflint**: Terraform linting
- **ansible-lint**: Ansible best practices

#### Code Quality
- **pylint**: Python code analysis
- **golangci-lint**: Go meta-linter
- **markdownlint**: Markdown style checking

### Configuration Example
```lua
-- Formatter configuration
local formatters_by_ft = {
    python = { "black", "isort" },
    go = { "gofmt", "goimports" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    yaml = { "yamlfmt" },
    json = { "prettier" },
    markdown = { "prettier" },
    sh = { "shfmt" },
    terraform = { "terraform_fmt" },
}
```

---

## 🐛 Troubleshooting

### Common Issues

#### Server Not Starting
```vim
" Check server status
:LspInfo

" Restart server
:LspRestart

" Check Mason installation
:Mason
```

**Common causes**:
1. Server not installed via Mason
2. Missing dependencies (Node.js, Python, etc.)
3. Incorrect workspace configuration

#### No Completions
```vim
" Check capabilities
:lua print(vim.inspect(vim.lsp.get_active_clients()[1].server_capabilities))

" Check completion setup
:checkhealth nvim-cmp
```

**Solutions**:
1. Verify nvim-cmp is properly configured
2. Check if server supports completion
3. Restart LSP server

#### Slow Performance
```vim
" Check running servers
:LspInfo

" Profile LSP
:lua vim.lsp.set_log_level("debug")
```

**Optimizations**:
1. Disable unused language servers
2. Configure workspace exclusions
3. Adjust diagnostic update frequency

#### Diagnostic Issues
```vim
" Check diagnostic configuration
:lua print(vim.inspect(vim.diagnostic.config()))

" Clear diagnostics
:lua vim.diagnostic.reset()
```

### Debug Commands

#### LSP Logs
```bash
# View LSP logs
tail -f ~/.local/state/nvim/lsp.log

# Enable debug logging
:lua vim.lsp.set_log_level("debug")
```

#### Mason Debug
```vim
" Mason log location
:lua print(require("mason-core.path").log_prefix())

" Check package installation
:MasonLog
```

---

## ⚡ Performance

### Optimization Tips

#### Workspace Configuration
```lua
-- Exclude large directories
workspace = {
    didChangeWatchedFiles = {
        dynamicRegistration = false,
    },
    workspaceFolders = {
        {
            uri = vim.uri_from_fname(vim.fn.getcwd()),
            name = "root"
        }
    }
}
```

#### Diagnostic Optimization
```lua
-- Reduce diagnostic frequency
vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = {
        source = "if_many",
        spacing = 4,
    },
})
```

#### Server-specific Optimizations

**TypeScript**
```lua
ts_ls = {
    init_options = {
        preferences = {
            disableSuggestions = true,
        }
    }
}
```

**Python**
```lua
pylsp = {
    settings = {
        pylsp = {
            plugins = {
                -- Disable heavy plugins for large projects
                rope_completion = { enabled = false },
                rope_autoimport = { enabled = false },
            }
        }
    }
}
```

### Memory Usage
```vim
" Check LSP memory usage
:lua for _, client in pairs(vim.lsp.get_active_clients()) do
    print(client.name .. ": " .. vim.fn.luaeval("collectgarbage('count')") .. "KB")
end
```

---

## 🎨 Customization

### Adding New Language Servers

#### Step 1: Install via Mason
```vim
:MasonInstall your-language-server
```

#### Step 2: Add to Configuration
```lua
-- In lua/plugins/lsp.lua
local servers = {
    -- ... existing servers
    "your-language-server",
}

-- Configure server
require('lspconfig').your_language_server.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        -- Your server-specific settings
    }
})
```

### Custom Formatters

#### Add to null-ls (deprecated, use conform.nvim)
```lua
-- Example custom formatter
local custom_formatter = {
    method = null_ls.methods.FORMATTING,
    filetypes = { "your_filetype" },
    generator = null_ls.formatter({
        command = "your_formatter",
        args = { "--stdin" },
        to_stdin = true,
    }),
}

null_ls.register(custom_formatter)
```

### Server-specific Settings

#### Lua Language Server (for Neovim config)
```lua
lua_ls = {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
```

#### Custom Keybindings
```lua
-- Add custom LSP keybindings in on_attach
local function on_attach(client, bufnr)
    -- ... existing mappings
    
    -- Custom mappings
    vim.keymap.set('n', '<leader>lf', function()
        vim.lsp.buf.format { async = true }
    end, { buffer = bufnr, desc = "Format document" })
    
    vim.keymap.set('n', '<leader>li', ':LspInfo<CR>', 
        { buffer = bufnr, desc = "LSP Info" })
end
```

### Workspace-specific Configuration

#### Project-specific LSP settings
```lua
-- .nvim.lua in project root
return {
    lsp = {
        servers = {
            pylsp = {
                settings = {
                    pylsp = {
                        plugins = {
                            -- Project-specific Python settings
                            mypy = { enabled = true },
                        }
                    }
                }
            }
        }
    }
}
```

---

## 📚 Additional Resources

### Official Documentation
- [Neovim LSP](https://neovim.io/doc/user/lsp.html)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

### Language Server Documentation
- [Language Server Protocol](https://microsoft.github.io/language-server-protocol/)
- [LSP Server Implementations](https://langserver.org/)

### Security Tools
- [Bandit](https://bandit.readthedocs.io/)
- [gosec](https://github.com/securecodewarrior/gosec)
- [ESLint Security](https://github.com/nodesecurity/eslint-plugin-security)

---

*For more advanced LSP configuration and troubleshooting, see the [Plugin Guide](PLUGINS.md) and [Troubleshooting section](../README.md#troubleshooting).*
