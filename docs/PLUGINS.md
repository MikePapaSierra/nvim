# 🔌 Plugin Guide

Complete documentation for all plugins used in this Neovim configuration.

## Table of Contents

- [🎨 Theme & UI](#-theme--ui)
- [🤖 AI & Coding Assistance](#-ai--coding-assistance)
- [🔧 Development Tools](#-development-tools)
- [🗂️ File Management](#️-file-management)
- [📝 Text & Markdown](#-text--markdown)
- [🔄 Git Integration](#-git-integration)
- [🖥️ Terminal & System](#️-terminal--system)
- [⚡ Performance & Diagnostics](#-performance--diagnostics)

---

## 🎨 Theme & UI

### Catppuccin

**Purpose**: Primary color theme with comprehensive plugin integration  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/catppuccin.lua`

#### Features
- **Mocha Variant**: Dark theme optimized for long coding sessions
- **Plugin Integration**: 20+ plugins with coordinated colors
- **Terminal Colors**: Custom terminal palette for consistency
- **Accessibility**: Improved contrast ratios and readability

#### Customization
```lua
-- Available flavors: latte, frappe, macchiato, mocha
flavour = "mocha"

-- Integrations (automatically enabled)
integrations = {
    cmp = true,
    gitsigns = true,
    telescope = true,
    treesitter = true,
    -- ... and many more
}
```

#### Color Palette
- **Base**: `#1e1e2e` - Main background
- **Surface**: `#313244` - Secondary background
- **Text**: `#cdd6f4` - Primary text
- **Blue**: `#89b4fa` - Links and keywords
- **Green**: `#a6e3a1` - Strings and success
- **Red**: `#f38ba8` - Errors and warnings

---

### Alpha.nvim

**Purpose**: Beautiful dashboard with system information  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/alpha-nvim.lua`

#### Features
- **System Stats**: Plugin count, loading times, Neovim version
- **Quick Actions**: Recent files, sessions, configuration
- **Beautiful ASCII**: Custom Neovim logo
- **Plugin Integration**: Catppuccin themed

#### Dashboard Sections
1. **Header**: ASCII art logo
2. **Menu**: Quick navigation buttons
3. **Footer**: System information and quotes

---

### Lualine.nvim

**Purpose**: Enhanced status line with comprehensive information  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/lualine.lua`

#### Features
- **Mode Indicator**: Current Neovim mode with colors
- **File Info**: Name, type, encoding, format
- **Git Status**: Branch, changes, blame info
- **LSP Status**: Active servers, diagnostics count
- **Location**: Line/column, percentage, word count

#### Sections
```
┌─ Mode ─ Branch ─ Filename ──────────────── LSP ─ Diagnostics ─ Line:Col ─┐
│  NORMAL   main  ● config.lua            lua_ls    2  1  0  0   45:12  │
└─────────────────────────────────────────────────────────────────────────┘
```

---

### Noice.nvim

**Purpose**: Modern UI for messages, cmdline, and popups  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/noice.lua`

#### Features
- **Command Line**: Enhanced command input with completion
- **Messages**: Beautiful message display with history
- **LSP Progress**: Real-time server status updates
- **Search Count**: Show match count in search
- **Mini Views**: Compact display for routine messages

#### Views
- **Cmdline Popup**: Floating command line
- **Mini**: Compact notifications
- **Split**: Side panel for messages
- **Popup**: Floating message windows

---

### Notify.nvim

**Purpose**: Beautiful notification system  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/notify.lua`

#### Features
- **Animation**: Smooth slide-in/out animations
- **Levels**: Info, warn, error, debug with distinct styling
- **History**: Notification history with search
- **Integration**: Works with noice.nvim and other plugins

---

## 🤖 AI & Coding Assistance

### Avante.nvim

**Purpose**: VS Code-like AI coding assistant  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/avante.lua`

#### Features
- **Right Sidebar**: VS Code-style AI chat interface
- **Code Context**: Automatic code context inclusion
- **Multiple Providers**: Claude, OpenAI, local models
- **Diff View**: Visual code suggestions with apply/reject
- **File Editing**: Direct file modifications with AI assistance

#### Key Commands
- `<leader>aa` - Toggle Avante sidebar
- `<leader>ar` - Refresh Avante
- `<leader>ae` - Edit with Avante
- `<leader>af` - Focus Avante sidebar

#### Configuration Options
```lua
provider = "claude"           -- AI provider
auto_suggestions = true       -- Automatic suggestions
sidebar = {
    width = 30,              -- Sidebar width percentage
    position = "right"       -- Sidebar position
}
```

---

### ChatGPT.nvim

**Purpose**: ChatGPT integration with intelligent 1Password support  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/chatgpt.lua`

#### Features
- **Smart API Key**: Automatic 1Password CLI detection
- **Graceful Fallback**: Environment variable support
- **Interactive Setup**: User guidance for configuration
- **Custom Actions**: Predefined code analysis actions
- **Context Awareness**: Automatic code context inclusion

#### Key Commands
- `:ChatGPT` - Open ChatGPT interface
- `:ChatGPTStatus` - Check configuration status
- `:ChatGPTSetup` - Manual configuration
- `<leader>gpt` - Quick ChatGPT access
- `<leader>ge` - Edit with ChatGPT
- `<leader>gc` - ChatGPT code review

#### API Key Setup
```bash
# Option 1: 1Password CLI (recommended)
eval $(op signin)

# Option 2: Environment variable
export OPENAI_API_KEY="your-key-here"

# Option 3: Interactive setup
:ChatGPTSetup
```

#### Custom Actions
- **Code Review**: Analyze code for improvements
- **Bug Fix**: Identify and suggest fixes
- **Documentation**: Generate comprehensive docs
- **Optimization**: Performance improvement suggestions
- **Security**: Security vulnerability analysis

---

### CopilotChat.nvim

**Purpose**: GitHub Copilot chat interface with enhanced prompts  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/copilotchat.lua`

#### Features
- **Enhanced Prompts**: Cloud security focused prompts
- **Code Explanation**: Detailed code analysis
- **Security Review**: Vulnerability assessment
- **Performance Tips**: Optimization suggestions
- **Best Practices**: Industry standard recommendations

#### Key Commands
- `<leader>cc` - Open Copilot Chat
- `<leader>ce` - Explain code
- `<leader>cr` - Review code
- `<leader>co` - Optimize code
- `<leader>cs` - Security analysis

#### Custom Prompts
- **CloudSecurity**: AWS/Azure/GCP security best practices
- **Terraform**: Infrastructure as code review
- **Kubernetes**: Container orchestration guidance
- **Python**: Security-focused Python development

---

## 🔧 Development Tools

### LSP Configuration

**Purpose**: Multi-language LSP with Mason auto-installation  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/lsp.lua`

#### Supported Languages
- **Python**: `pylsp`, `pyright` with security tools
- **Go**: `gopls` with cloud-native tools
- **JavaScript/TypeScript**: `ts_ls`, `eslint`
- **Lua**: `lua_ls` for Neovim configuration
- **Shell**: `bashls` with shellcheck
- **YAML**: `yamlls` for Kubernetes/Ansible
- **Terraform**: `terraformls` for IaC
- **Docker**: `dockerls` for containers
- **JSON**: `jsonls` with schema validation
- **Markdown**: `marksman` for documentation

#### Security Tools Integration
- **Ruff**: Python linting and formatting
- **Bandit**: Python security scanner
- **Semgrep**: Multi-language security analysis
- **TruffleHog**: Secret detection
- **Checkov**: Infrastructure security scanning

#### Key Features
- **Auto-install**: Mason manages all servers
- **Diagnostics**: Real-time error detection
- **Code Actions**: Quick fixes and refactoring
- **Hover Info**: Documentation on demand
- **Go to Definition**: Symbol navigation
- **References**: Find all usages

#### Commands
- `:Mason` - Package manager interface
- `:LspInfo` - Active server information
- `:LspRestart` - Restart language servers
- `gd` - Go to definition
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol

---

### Mason.nvim

**Purpose**: Portable package manager for LSP servers, formatters, linters  
**Status**: ✅ Active  
**Configuration**: Integrated with LSP

#### Features
- **Auto-install**: Automatic server installation
- **Cross-platform**: Works on Linux, macOS, Windows
- **Version Management**: Server version control
- **Health Checks**: Installation validation

#### Installed Packages
```
Language Servers: 15+
Formatters: 10+
Linters: 8+
DAP Servers: 5+
```

---

### Nvim-cmp

**Purpose**: Advanced autocompletion with multiple sources  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/completion.lua`

#### Completion Sources
1. **LSP**: Language server completions
2. **Copilot**: AI-powered suggestions
3. **LuaSnip**: Snippet expansion
4. **Buffer**: Current buffer words
5. **Path**: File system paths
6. **Cmdline**: Command line completion

#### Features
- **Intelligent Ranking**: Context-aware suggestions
- **Snippet Support**: LuaSnip integration
- **Ghost Text**: Preview suggestions
- **Documentation**: Hover documentation in completion
- **Icons**: Kind-specific icons with colors

#### Key Bindings
- `<Tab>` - Next completion item
- `<S-Tab>` - Previous completion item
- `<CR>` - Confirm selection
- `<C-Space>` - Trigger completion
- `<C-e>` - Close completion menu

---

### LuaSnip

**Purpose**: Snippet engine with cloud security snippets  
**Status**: ✅ Active  
**Configuration**: Integrated with completion

#### Snippet Categories
- **AWS**: CloudFormation, CDK, Terraform
- **Kubernetes**: Pod, Service, Deployment templates
- **Python**: Security patterns, API endpoints
- **Go**: Cloud-native application patterns
- **Terraform**: Module templates, resource blocks
- **Ansible**: Playbook templates, security tasks

#### Custom Snippets
```lua
-- Example: AWS Lambda function
snippet("awslambda", {
    t("import json"),
    t({"", ""}),
    t("def lambda_handler(event, context):"),
    t({"", "    "}),
    i(1, "# Your code here"),
    t({"", "    return {"}),
    t({"", "        'statusCode': 200,"}),
    t({"", "        'body': json.dumps('Hello from Lambda!')"}),
    t({"", "    }"}),
})
```

---

## 🗂️ File Management

### Telescope.nvim

**Purpose**: Powerful fuzzy finder and picker  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/telescope.lua`

#### Core Features
- **File Finder**: Fast file search with preview
- **Live Grep**: Real-time text search across files
- **Buffer Management**: Open buffer navigation
- **Help Tags**: Neovim help search
- **Commands**: Command palette functionality
- **Git Integration**: Git files, branches, commits

#### Extensions
- **File Browser**: Directory navigation
- **Project**: Project management and switching
- **Recent Files**: Recently opened files
- **Symbols**: LSP symbol search
- **Diagnostics**: Error and warning navigation

#### Key Bindings
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Help tags
- `<leader>fr` - Recent files
- `<leader>fc` - Commands
- `<leader>fs` - LSP symbols
- `<leader>fd` - Diagnostics

#### Advanced Usage
```lua
-- Custom search in specific directory
:Telescope find_files cwd=~/projects

-- Search with specific file types
:Telescope find_files find_command=rg,--files,--glob,*.lua

-- Live grep with additional args
:Telescope live_grep additional_args=--case-sensitive
```

---

### Barbar.nvim

**Purpose**: Modern buffer/tab management  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/barbar.lua`

#### Features
- **Visual Tabs**: VS Code-style buffer tabs
- **Git Indicators**: Modified, added, deleted status
- **Auto-sorting**: Intelligent buffer ordering
- **Pin Buffers**: Keep important buffers visible
- **Close Animations**: Smooth buffer closing

#### Key Bindings
- `<leader>bp` - Previous buffer
- `<leader>bn` - Next buffer
- `<leader>bc` - Close buffer
- `<leader>bb` - Pick buffer
- `<leader>bpn` - Pin buffer
- `<leader>bcm` - Close all but current
- `<Alt-1>` to `<Alt-9>` - Go to buffer 1-9

#### Buffer States
- **Modified**: `●` indicator
- **Pinned**: `📌` indicator
- **Git Status**: Color-coded based on changes
- **Inactive**: Dimmed appearance

---

### Nvim-tree

**Purpose**: File explorer sidebar  
**Status**: ⚠️ Configured but disabled (prefer Telescope)  
**Configuration**: `lua/plugins/nvim-tree.lua`

#### Features (when enabled)
- **Tree View**: Hierarchical file structure
- **Git Integration**: File status indicators
- **File Operations**: Create, delete, rename, copy
- **Filters**: Hide/show specific file types
- **Bookmarks**: Quick directory access

---

## 📝 Text & Markdown

### Obsidian.nvim

**Purpose**: Three-domain personal knowledge management  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/obsidian.lua`

#### Three-Domain System
1. **Personal**: Private thoughts, ideas, journal
2. **Professional**: Work notes, meetings, projects
3. **Hobby**: Interests, learning, side projects

#### Features
- **Daily Notes**: Automatic daily note creation
- **Templates**: TPL_ prefixed note templates
- **Link Navigation**: Wiki-style linking
- **Search**: Full-text note search
- **Tags**: Organizational tagging system
- **Vault Management**: Multiple vault support

#### Key Commands
- `<leader>on` - New note
- `<leader>ot` - Today's daily note
- `<leader>oy` - Yesterday's daily note
- `<leader>os` - Search notes
- `<leader>ob` - Browse notes
- `<leader>onp` - New personal note
- `<leader>onw` - New professional note
- `<leader>onh` - New hobby note

#### Templates
Located in `/home/mps/Documents/personalObsidianVault/templates/`:
- `TPL_Daily.md` - Daily note template
- `TPL_Private.md` - Personal note template
- `TPL_Professional.md` - Work note template
- `TPL_Hobby.md` - Hobby note template
- `TPL_Health.md` - Health tracking template

#### Directory Structure
```
personalObsidianVault/
├── dailies/           # Daily notes
├── personal/          # Private domain
├── professional/      # Work domain
├── hobby/            # Interest domain
└── templates/        # Note templates
```

---

### Markdown Preview

**Purpose**: Live markdown preview in browser  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/markdown_preview.lua`

#### Features
- **Live Preview**: Real-time browser preview
- **Math Support**: LaTeX math rendering
- **Mermaid Diagrams**: Flowcharts and diagrams
- **Code Highlighting**: Syntax highlighting in code blocks
- **Custom CSS**: Themed preview styling

#### Commands
- `:MarkdownPreview` - Start preview
- `:MarkdownPreviewStop` - Stop preview
- `:MarkdownPreviewToggle` - Toggle preview

---

### Render-markdown.nvim

**Purpose**: Beautiful inline markdown rendering  
**Status**: ✅ Active  
**Configuration**: Integrated with Obsidian

#### Features
- **Inline Rendering**: Headers, lists, code blocks
- **Syntax Highlighting**: Language-specific colors
- **Math Rendering**: LaTeX math display
- **Link Styling**: Visual link indicators
- **Table Formatting**: Clean table display

---

### Headlines.nvim

**Purpose**: Enhanced markdown headlines  
**Status**: ✅ Active  
**Configuration**: Integrated with markdown

#### Features
- **Visual Hierarchy**: Distinct header styling
- **Background Colors**: Header background highlighting
- **Bullets**: Custom bullet points for lists
- **Code Blocks**: Enhanced code block styling

---

## 🔄 Git Integration

### Gitsigns.nvim

**Purpose**: Git decorations and inline blame  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/git.lua`

#### Features
- **Line Indicators**: Added, modified, deleted lines
- **Inline Blame**: Author and commit info
- **Hunk Preview**: See changes in popup
- **Stage/Unstage**: Interactive staging
- **Navigation**: Jump between hunks

#### Key Bindings
- `<leader>gp` - Preview hunk
- `<leader>gs` - Stage hunk
- `<leader>gu` - Unstage hunk
- `<leader>gr` - Reset hunk
- `<leader>gb` - Toggle blame
- `]c` - Next hunk
- `[c` - Previous hunk

#### Visual Indicators
- **Green**: Added lines
- **Blue**: Modified lines
- **Red**: Deleted lines
- **Orange**: Top-delete indicator

---

### Diffview.nvim

**Purpose**: Git diff viewer and merge tool  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/git.lua`

#### Features
- **File History**: Visual file change history
- **Diff View**: Side-by-side or unified diff
- **Merge Conflicts**: Interactive conflict resolution
- **Branch Comparison**: Compare branches visually
- **Commit Range**: View changes between commits

#### Commands
- `:DiffviewOpen` - Open diff view
- `:DiffviewFileHistory` - File history
- `:DiffviewFileHistory %` - Current file history
- `:DiffviewClose` - Close diff view

---

## 🖥️ Terminal & System

### ToggleTerm.nvim

**Purpose**: Terminal management with VS Code-style integration  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/toggleterm.lua`

#### Terminal Types
1. **Bottom Terminal**: VS Code-style integrated terminal
2. **Floating Terminal**: Popup terminal window
3. **Vertical Terminal**: Side panel terminal
4. **Horizontal Terminal**: Split terminal

#### Key Features
- **Multiple Terminals**: Manage several terminal instances
- **Persistent Sessions**: Terminal state preservation
- **Custom Commands**: Predefined terminal commands
- **Integration**: Works with tmux and other tools

#### Key Bindings
- `<Ctrl-`>` - Toggle bottom terminal
- `<Ctrl-\>` - Alternative toggle
- `<leader>tb` - Bottom terminal
- `<leader>tf` - Floating terminal
- `<leader>th` - Horizontal terminal
- `<leader>tv` - Vertical terminal

#### Predefined Terminals
- `<leader>gg` - LazyGit
- `<leader>tp` - Python REPL
- `<leader>tm` - System monitor (htop)
- `<leader>tn` - Node.js REPL

#### Custom Terminal Commands
```lua
-- Create custom terminal
local Terminal = require('toggleterm.terminal').Terminal

local python_repl = Terminal:new({
    cmd = "python3",
    hidden = true,
    direction = "float",
})

function _python_toggle()
    python_repl:toggle()
end
```

---

## ⚡ Performance & Diagnostics

### Trouble.nvim

**Purpose**: Enhanced diagnostics and quickfix management  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/trouble.lua`

#### Features
- **Error List**: Comprehensive error display
- **Cloud Security Focus**: Security-specific filtering
- **Performance Optimization**: Fast diagnostic processing
- **Multi-source**: LSP, quickfix, location list
- **Visual Indicators**: Color-coded severity levels

#### Views
- **Diagnostics**: All workspace diagnostics
- **LSP References**: Symbol references
- **LSP Definitions**: Symbol definitions
- **Quickfix**: Quickfix list items
- **Location List**: Location list items

#### Key Bindings
- `<leader>xx` - Toggle Trouble
- `<leader>xw` - Workspace diagnostics
- `<leader>xd` - Document diagnostics
- `<leader>xq` - Quickfix list
- `<leader>xl` - Location list

#### Filtering Options
```lua
-- Filter by severity
:Trouble diagnostics filter.severity=vim.diagnostic.severity.ERROR

-- Filter by source
:Trouble diagnostics filter.source="eslint"

-- Filter by file type
:Trouble diagnostics filter.buf=0
```

---

### Todo Comments

**Purpose**: TODO/FIXME/NOTE highlighting and navigation  
**Status**: ✅ Active  
**Configuration**: `lua/plugins/todo-comments.lua`

#### Supported Keywords
- **TODO**: Tasks to be done
- **HACK**: Quick and dirty solutions
- **WARNING**: Important warnings
- **PERF**: Performance-related notes
- **NOTE**: General notes
- **TEST**: Testing-related comments
- **FIXME**: Things that need fixing
- **BUG**: Known bugs

#### Features
- **Syntax Highlighting**: Colored keyword highlighting
- **Search Integration**: Telescope todo search
- **Navigation**: Jump between todos
- **Quickfix**: Generate todo quickfix list

#### Key Bindings
- `<leader>ft` - Find todos (Telescope)
- `]t` - Next todo
- `[t` - Previous todo
- `<leader>xt` - Todo trouble list

#### Example Usage
```lua
-- TODO: Implement authentication system
-- HACK: Temporary fix for API rate limiting
-- WARNING: This function modifies global state
-- PERF: Consider caching this expensive operation
-- NOTE: See documentation for more details
-- FIXME: Handle edge case when input is nil
```

---

## 🔧 Plugin Status Summary

| Category | Plugin | Status | Key Features |
|----------|--------|--------|--------------|
| **Theme** | Catppuccin | ✅ Active | Mocha theme, 20+ integrations |
| **Theme** | Alpha | ✅ Active | Dashboard, system stats |
| **Theme** | Lualine | ✅ Active | Status line, git/LSP info |
| **Theme** | Noice | ✅ Active | Modern UI, messages |
| **Theme** | Notify | ✅ Active | Notifications |
| **AI** | Avante | ✅ Active | AI assistant, right sidebar |
| **AI** | ChatGPT | ✅ Active | 1Password integration |
| **AI** | CopilotChat | ✅ Active | Enhanced prompts |
| **LSP** | LSP Config | ✅ Active | 20+ language servers |
| **LSP** | Mason | ✅ Active | Package manager |
| **LSP** | Nvim-cmp | ✅ Active | Advanced completion |
| **Files** | Telescope | ✅ Active | Fuzzy finder, extensions |
| **Files** | Barbar | ✅ Active | Buffer management |
| **Files** | Nvim-tree | ⚠️ Disabled | File explorer |
| **Text** | Obsidian | ✅ Active | Knowledge management |
| **Text** | Markdown Preview | ✅ Active | Live preview |
| **Text** | Render Markdown | ✅ Active | Inline rendering |
| **Git** | Gitsigns | ✅ Active | Git decorations |
| **Git** | Diffview | ✅ Active | Diff viewer |
| **Terminal** | ToggleTerm | ✅ Active | VS Code-style terminal |
| **Diag** | Trouble | ✅ Active | Enhanced diagnostics |
| **Diag** | Todo Comments | ✅ Active | Todo highlighting |

---

## 🚀 Getting Started with Plugins

### For New Users
1. **Start with basics**: Telescope, LSP, Git integration
2. **Learn keybindings**: Use `<leader>?` to see all mappings
3. **Customize gradually**: Modify one plugin at a time
4. **Read documentation**: Each plugin has extensive docs

### For Advanced Users
- **Create custom snippets**: Extend LuaSnip
- **Add language servers**: Expand Mason configuration
- **Custom Telescope extensions**: Build specialized finders
- **AI prompt engineering**: Customize ChatGPT/Avante prompts

### Plugin Development
- **Fork and modify**: Adapt plugins to your workflow
- **Create new plugins**: Use existing ones as templates
- **Contribute back**: Submit improvements to upstream

---

*For more detailed configuration examples and troubleshooting, see the individual plugin files in `lua/plugins/`.*
