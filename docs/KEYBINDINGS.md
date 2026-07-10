# ⌨️ Keybindings Reference

Complete keybinding reference organized with which-key for enhanced discoverability. Press `<leader>` (spacebar) and wait for the popup guide!

## Table of Contents

- [🎯 Which-Key Guide](#-which-key-guide)
- [🔍 File & Search Operations](#-file--search-operations)
- [🗂️ Explorer & Buffer Management](#️-explorer--buffer-management)
- [🔄 Git Integration](#-git-integration)
- [🔧 LSP & Development](#-lsp--development)
- [⚡ Diagnostics & Debugging](#-diagnostics--debugging)
- [🖥️ Terminal Management](#️-terminal-management)
- [🤖 AI & Coding Assistance](#-ai--coding-assistance)
- [🏗️ Code Navigation & Editing](#️-code-navigation--editing)
- [🎨 UI & Window Management](#-ui--window-management)
- [🎯 Core Navigation](#-core-navigation)

---

## 🎯 Which-Key Guide

**Which-key provides visual keybinding assistance!** Press any `<leader>` key combination and wait 200ms to see available options.

### Quick Access Groups
- `<leader>f` - **Find/File** operations (Telescope)
- `<leader>e` - **Explorer** operations (NvimTree)
- `<leader>g` - **Git** operations (Gitsigns & Git commands)
- `<leader>l` - **LSP** operations (Language Server)
- `<leader>d` - **Debug** operations (DAP)
- `<leader>b` - **Breakpoints** (DAP debugging)
- `<leader>t` - **Treesitter** operations
- `<leader>s` - **Split/Search** operations
- `<leader>c` - **Quickfix/Diff** operations
- `<leader>T` - **Terminal** operations
- `<leader>x` - **Trouble** (diagnostics)
- `<leader>a` - **AI/Copilot** assistance
- `<leader>G` - **Go** specific operations
- `<leader>M` - **Markdown** operations
- `<leader>o` - **Obsidian** note-taking
- `<leader>q` - **Quit** operations
- `<leader>L` - **Lazy** plugin manager
- `<leader>m` - **Mason/Maximize** operations
- `<leader>N` - **Notifications**

---

## 🔍 File & Search Operations

### Find/File (`<leader>f`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ff` | `Telescope find_files` | Find files in workspace |
| `<leader>fg` | `Telescope live_grep` | Live grep search in files |
| `<leader>fb` | `Telescope buffers` | Find open buffers |
| `<leader>fh` | `Telescope help_tags` | Search help documentation |
| `<leader>fr` | `Telescope oldfiles` | Recent files |
| `<leader>fc` | `Telescope commands` | Available commands |
| `<leader>fk` | `Telescope keymaps` | Search keymaps |
| `<leader>fs` | `Telescope grep_string` | Grep string under cursor |
| `<leader>fw` | `Telescope current_buffer_fuzzy_find` | Find in current buffer |

### Search Operations (`<leader>s`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>sr` | Search and replace word | Replace word under cursor |
| `<leader>sc` | Search and replace confirm | Replace with confirmation |
| `<leader>sf` | Search symbols | LSP document symbols in current function |
| `<leader>ss` | Search string | Telescope grep string |
| `<leader>sw` | Search in window | Current buffer fuzzy find |
| `<leader>sv` | Vertical split | Split window vertically |
| `<leader>sh` | Horizontal split | Split window horizontally |
| `<leader>se` | Equal windows | Make windows equal size |
| `<leader>sx` | Close window | Close current window |
| `<leader>sj` | Shorter height | Make window shorter |
| `<leader>sk` | Taller height | Make window taller |
| `<leader>sl` | Wider width | Make window wider |

---

## 🗂️ Explorer & Buffer Management

### File Explorer (`<leader>e`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ee` | `NvimTreeToggle` | Toggle file explorer |
| `<leader>er` | `NvimTreeFocus` | Focus file explorer |
| `<leader>ef` | `NvimTreeFindFile` | Find current file in explorer |

---

## 🔄 Git Integration

### Git Operations (`<leader>g`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>gs` | `Telescope git_status` | Git status |
| `<leader>gb` | `Telescope git_branches` | Git branches |
| `<leader>gc` | `Telescope git_commits` | Git commits |
| `<leader>gbf` | `GBrowse` | Git browse file |
| `<leader>glc` | Git link copy | Copy git link |
| `<leader>gdf` | `Gvdiffsplit` | Git diff |
| `<leader>gx` | Open URL | Open URL under cursor |
| `<leader>gh` | Preview hunk | Gitsigns preview hunk |
| `<leader>gr` | Reset hunk | Gitsigns reset hunk |
| `<leader>gR` | Reset buffer | Gitsigns reset buffer |
| `<leader>gp` | Previous hunk | Gitsigns previous hunk |
| `<leader>gn` | Next hunk | Gitsigns next hunk |
| `<leader>gd` | Diff this | Gitsigns diff this |
| `<leader>gD` | Toggle deleted | Gitsigns toggle deleted |
| `<leader>gl` | Blame line | Gitsigns blame line |
| `<leader>gB` | Toggle line blame | Gitsigns toggle line blame |

---

## 🔧 LSP & Development

### LSP Operations (`<leader>l`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ld` | Go to definition | Telescope LSP definitions |
| `<leader>lr` | References | Telescope LSP references |
| `<leader>li` | Implementations | Telescope LSP implementations |
| `<leader>lt` | Type definitions | Telescope LSP type definitions |
| `<leader>ls` | Document symbols | Telescope LSP document symbols |
| `<leader>lw` | Workspace symbols | Telescope LSP workspace symbols |
| `<leader>lf` | Format document | Format current document |
| `<leader>la` | Code actions | Show code actions |
| `<leader>ln` | Rename symbol | Rename symbol under cursor |
| `<leader>lh` | Hover documentation | Show hover documentation |
| `<leader>lS` | Signature help | Show signature help |

### Standard LSP Keybindings
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to symbol definition |
| `gD` | Go to declaration | Jump to symbol declaration |
| `gr` | Go to references | Find all references |
| `gi` | Go to implementation | Jump to implementation |
| `gt` | Go to type definition | Jump to type definition |
| `K` | Hover documentation | Show hover information |
| `<C-k>` | Signature help | Show function signature |

---

## ⚡ Diagnostics & Debugging

### Diagnostics Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>d` | Open diagnostic float | Show diagnostic popup |
| `]d` | Next diagnostic | Jump to next diagnostic |
| `[d` | Previous diagnostic | Jump to previous diagnostic |
| `]e` | Next error | Jump to next error |
| `[e` | Previous error | Jump to previous error |
| `]w` | Next warning | Jump to next warning |
| `[w` | Previous warning | Jump to previous warning |

### Debugging Breakpoints (`<leader>b`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>bb` | Toggle breakpoint | Toggle breakpoint |
| `<leader>bc` | Conditional breakpoint | Set conditional breakpoint |
| `<leader>bl` | Log point | Set log point |
| `<leader>br` | Clear breakpoints | Clear all breakpoints |
| `<leader>ba` | List breakpoints | List all breakpoints |

### Debug Operations (`<leader>d`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>dc` | Continue | Debug continue |
| `<leader>dj` | Step over | Debug step over |
| `<leader>dk` | Step into | Debug step into |
| `<leader>do` | Step out | Debug step out |
| `<leader>dd` | Disconnect & close UI | Stop debugging |
| `<leader>dt` | Terminate & close UI | Terminate debugging |
| `<leader>dr` | Toggle REPL | Toggle debug REPL |
| `<leader>dl` | Run last | Run last debug session |
| `<leader>di` | Hover variables | Show variable values |
| `<leader>d?` | Show scopes | Show debug scopes |
| `<leader>df` | Frames | Show debug frames |
| `<leader>dh` | Commands | Show debug commands |
| `<leader>de` | Error diagnostics | Show error diagnostics |

### Trouble Diagnostics (`<leader>x`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>xx` | Diagnostics | Toggle diagnostics (Trouble) |
| `<leader>xX` | Buffer diagnostics | Buffer diagnostics (Trouble) |
| `<leader>cs` | Symbols | Symbols (Trouble) |
| `<leader>cl` | LSP definitions | LSP definitions/references (Trouble) |
| `<leader>xL` | Location list | Location list (Trouble) |
| `<leader>xQ` | Quickfix list | Quickfix list (Trouble) |

### Quickfix/Diff Operations (`<leader>c`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>cn` | Next quickfix | Next quickfix item |
| `<leader>cp` | Previous quickfix | Previous quickfix item |
| `<leader>co` | Open quickfix | Open quickfix list |
| `<leader>cc` | Close quickfix | Close quickfix list |
| `<leader>cj` | Get diff from left | Get diff from left (merge) |
| `<leader>ck` | Get diff from right | Get diff from right (merge) |

---

## 🖥️ Terminal Management

### Terminal Operations (`<leader>T`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Tt` | Toggle terminal | Toggle terminal |
| `<leader>Tf` | Float terminal | Floating terminal |
| `<leader>Th` | Horizontal terminal | Horizontal terminal |
| `<leader>Tv` | Vertical terminal | Vertical terminal |

---

## 🤖 AI & Coding Assistance

### AI/Copilot Operations (`<leader>a`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ae` | Explain code | CopilotChat explain |
| `<leader>ar` | Review code | CopilotChat review |
| `<leader>af` | Fix code | CopilotChat fix |
| `<leader>ao` | Optimize code | CopilotChat optimize |
| `<leader>ad` | Generate docs | CopilotChat docs |
| `<leader>at` | Generate tests | CopilotChat tests |
| `<leader>ac` | Generate commit | CopilotChat commit message |

---

## 🏗️ Code Navigation & Editing

### Treesitter Operations (`<leader>t`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>ts` | Toggle highlighting | Toggle Treesitter highlighting |
| `<leader>tc` | Toggle context | Toggle Treesitter context |
| `<leader>tl` | Toggle folding | Toggle Treesitter folding |

### Todo Comments
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>td` | Find todo comments | TodoTelescope |
| `<leader>tq` | Todo quickfix | Todo QuickFix |
| `<leader>tl` | Todo location list | Todo Location List |

### Code Navigation (Treesitter Text Objects)

#### Next Navigation (`]`)
| Key | Description |
|-----|-------------|
| `]f` | Next Function |
| `]c` | Next Class |
| `]a` | Next Parameter |
| `]b` | Next Block |
| `]s` | Next Statement |
| `]d` | Next Conditional |
| `]l` | Next Loop |
| `]r` | Next Resource (Terraform) |
| `]p` | Next Property (JSON/YAML) |
| `]v` | Next Variable |
| `]k` | Next Call |
| `]t` | Next Comment |

#### Previous Navigation (`[`)
| Key | Description |
|-----|-------------|
| `[f` | Previous Function |
| `[c` | Previous Class |
| `[a` | Previous Parameter |
| `[b` | Previous Block |
| `[s` | Previous Statement |
| `[d` | Previous Conditional |
| `[l` | Previous Loop |
| `[r` | Previous Resource (Terraform) |
| `[p` | Previous Property (JSON/YAML) |
| `[v` | Previous Variable |
| `[k` | Previous Call |
| `[t` | Previous Comment |

#### Text Object Selection (Visual/Operator Mode)

**Around Objects (`a`):**
| Key | Description | Mode |
|-----|-------------|------|
| `af` | Around Function | v, o |
| `ac` | Around Class | v, o |
| `aa` | Around Parameter | v, o |
| `ab` | Around Block | v, o |
| `as` | Around Statement | v, o |
| `ad` | Around Conditional | v, o |
| `al` | Around Loop | v, o |
| `ak` | Around Call | v, o |
| `at` | Around Comment | v, o |
| `ar` | Around Resource (Terraform) | v, o |
| `ao` | Around Attribute (JSON/YAML) | v, o |
| `an` | Around Number | v, o |
| `aq` | Around String | v, o |
| `ap` | Around Property | v, o |
| `av` | Around Variable | v, o |

**Inside Objects (`i`):**
| Key | Description | Mode |
|-----|-------------|------|
| `if` | Inside Function | v, o |
| `ic` | Inside Class | v, o |
| `ia` | Inside Parameter | v, o |
| `ib` | Inside Block | v, o |
| `is` | Inside Statement | v, o |
| `id` | Inside Conditional | v, o |
| `il` | Inside Loop | v, o |
| `ik` | Inside Call | v, o |
| `it` | Inside Comment | v, o |
| `ir` | Inside Resource (Terraform) | v, o |
| `io` | Inside Attribute (JSON/YAML) | v, o |
| `in` | Inside Number | v, o |
| `iq` | Inside String | v, o |
| `ip` | Inside Property | v, o |
| `iv` | Inside Variable | v, o |

### Code Swapping

#### Swap Next (`<leader>n`)
| Key | Description |
|-----|-------------|
| `<leader>na` | Swap Next Parameter |
| `<leader>nf` | Swap Next Function |
| `<leader>nb` | Swap Next Block |
| `<leader>nr` | Swap Next Resource |
| `<leader>np` | Swap Next Property |
| `<leader>nv` | Swap Next Variable |
| `<leader>no` | Clear Search Highlights |

#### Swap Previous (`<leader>p`)
| Key | Description |
|-----|-------------|
| `<leader>pa` | Swap Previous Parameter |
| `<leader>pf` | Swap Previous Function |
| `<leader>pb` | Swap Previous Block |
| `<leader>pr` | Swap Previous Resource |
| `<leader>pp` | Swap Previous Property |
| `<leader>pv` | Swap Previous Variable |

### Copy/Paste/Move Operations
| Key | Description | Mode |
|-----|-------------|------|
| `<leader>p` | Paste without losing register | v |
| `<leader>yf` | Yank entire file | n |

### Move Operations (`<leader>m`)
| Key | Description |
|-----|-------------|
| `<leader>mj` | Move Down |
| `<leader>mk` | Move Up |

---

## 🎨 UI & Window Management

### Go Development (`<leader>G`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Gr` | Run Go file | GoRun |
| `<leader>Gb` | Build Go project | GoBuild |
| `<leader>Gt` | Run Go tests | GoTest |
| `<leader>Gc` | Go coverage | GoCoverage |
| `<leader>Gf` | Format Go file | GoFmt |
| `<leader>Gi` | Organize imports | GoImports |

### Markdown Operations (`<leader>M`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Mp` | Preview markdown | MarkdownPreview |
| `<leader>Ms` | Stop preview | MarkdownPreviewStop |
| `<leader>Mt` | Toggle preview | MarkdownPreviewToggle |

### Obsidian Note-taking (`<leader>o`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>on` | New note | ObsidianNew |
| `<leader>oo` | Open note | ObsidianOpen |
| `<leader>os` | Search notes | ObsidianSearch |
| `<leader>oq` | Quick switch | ObsidianQuickSwitch |
| `<leader>of` | Follow link | ObsidianFollowLink |
| `<leader>ob` | Show backlinks | ObsidianBacklinks |
| `<leader>ot` | Today's note | ObsidianToday |
| `<leader>oy` | Yesterday's note | ObsidianYesterday |
| `<leader>oT` | Tomorrow's note | ObsidianTomorrow |
| `<leader>od` | Daily notes | ObsidianDailies |
| `<leader>oO` | Show tags | ObsidianTags |
| `<leader>ow` | Switch workspace | ObsidianWorkspace |
| `<leader>or` | Rename note | ObsidianRename |
| `<leader>ol` | Show links | ObsidianLinks |
| `<leader>oe` | Extract note | ObsidianExtractNote |
| `<leader>oc` | Toggle checkbox | ObsidianToggleCheckbox |
| `<leader>oi` | Open inbox | Open vault inbox |
| `<leader>oD` | Main dashboard | Open main dashboard |
| `<leader>op` | Professional dashboard | Open professional dashboard |
| `<leader>oh` | Hobby dashboard | Open hobby dashboard |

### Quick Actions (`<leader>q`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>qq` | Quit all | Quit all windows |
| `<leader>qw` | Write and quit all | Save and quit all |
| `<leader>qQ` | Force quit all | Force quit without saving |

### Plugin Management (`<leader>L`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Ll` | Open Lazy | Open Lazy plugin manager |
| `<leader>Lu` | Update plugins | Update all plugins |
| `<leader>Ls` | Sync plugins | Sync plugins |
| `<leader>Lc` | Clean plugins | Clean unused plugins |
| `<leader>Lp` | Profile plugins | Profile plugin startup |

### Mason/Maximize (`<leader>m`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>mm` | Open Mason | Open Mason LSP manager |
| `<leader>mu` | Update Mason | Update Mason packages |
| `<leader>mi` | Install package | Install Mason package |

### Notifications (`<leader>N`)
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>Nd` | Dismiss notifications | Dismiss all notifications |
| `<leader>Nh` | Notification history | Show notification history |

---

## 🎯 Core Navigation

### Essential Non-Leader Mappings

#### Insert Mode
| Key | Action | Description |
|-----|--------|-------------|
| `jj` | `<Esc>` | Exit to normal mode |

#### Navigation Enhancement (Auto-centering)
| Key | Action | Description |
|-----|--------|-------------|
| `<C-u>` | `<C-u>zz` | Half page up and center |
| `<C-d>` | `<C-d>zz` | Half page down and center |
| `n` | `nzz` | Next search result and center |
| `N` | `Nzz` | Previous search result and center |
| `{` | `{zz` | Previous paragraph and center |
| `}` | `}zz` | Next paragraph and center |
| `G` | `Gzz` | Go to end and center |
| `gg` | `ggzz` | Go to beginning and center |
| `<C-i>` | `<C-i>zz` | Jump forward and center |
| `<C-o>` | `<C-o>zz` | Jump backward and center |
| `%` | `%zz` | Match bracket and center |
| `*` | `*zz` | Search word under cursor and center |
| `#` | `#zz` | Search word under cursor backward and center |

#### Visual Mode Enhancements
| Key | Action | Description |
|-----|--------|-------------|
| `<<` | Unindent and reselect | Unindent and keep selection |
| `>>` | Indent and reselect | Indent and keep selection |

#### Comment Operations
| Key | Action | Description |
|-----|--------|-------------|
| `gc` | Comment | Comment toggle |
| `gcc` | Comment line | Comment current line |
| `gcb` | Comment block | Block comment |
| `gco` | Comment line below | Comment line below |
| `gcO` | Comment line above | Comment line above |
| `gcA` | Comment end of line | Comment at end of line |

---

## 🚀 Quick Reference Card

### Most Used Shortcuts
```
┌─────────────────────── FILES ──────────────────────────┐
│ <leader>ff   Find files         <leader>fb   Buffers   │
│ <leader>fg   Live grep          <leader>fr   Recent    │
│ <leader>ee   Toggle explorer    <leader>ef   Find file │
├─────────────────────── AI ────────────────────────────┤
│ <leader>ae   Explain code       <leader>ar   Review    │
│ <leader>af   Fix code           <leader>ao   Optimize  │
├─────────────────────── LSP ───────────────────────────┤
│ gd           Go to def          gr           Go to ref  │
│ K            Hover              <leader>la   Actions    │
│ <leader>ln   Rename             <leader>lf   Format    │
├─────────────────────── GIT ───────────────────────────┤
│ <leader>gh   Preview hunk       <leader>gr   Reset     │
│ <leader>gB   Toggle blame       ]c           Next hunk │
├─────────────────────── TERMINAL ──────────────────────┤
│ <leader>Tt   Toggle terminal    <leader>Tf   Float     │
│ <leader>Th   Horizontal         <leader>Tv   Vertical  │
├─────────────────────── DEBUG ─────────────────────────┤
│ <leader>bb   Breakpoint         <leader>dc   Continue  │
│ <leader>dj   Step over          <leader>dk   Step into │
└────────────────────────────────────────────────────────┘
```

### Emergency Shortcuts
```
┌─────────────────── HELP & ESCAPE ─────────────────────┐
│ jj           Exit insert         <leader>fk   Keymaps  │
│ <leader>qq   Quit all           <leader>qQ   Force quit│
│ <leader>Ll   Plugin manager     <leader>mm   LSP mgr   │
└────────────────────────────────────────────────────────┘
```

---

*Press `<leader>` and wait for which-key popup to discover keybindings interactively!*
*For plugin-specific advanced configurations, refer to the [Plugin Guide](PLUGINS.md).*

### Telescope Navigation (In Telescope)
| Key | Action | Description |
|-----|--------|-------------|
| `<C-n>` | Next item | Move to next result |
| `<C-p>` | Previous item | Move to previous result |
| `<CR>` | Select | Open selected item |
| `<C-t>` | Open in tab | Open in new tab |
| `<C-v>` | Open in vsplit | Open in vertical split |
| `<C-x>` | Open in split | Open in horizontal split |
| `<C-u>` | Preview scroll up | Scroll preview up |
| `<C-d>` | Preview scroll down | Scroll preview down |
| `<C-q>` | Send to quickfix | Send results to quickfix |
| `<Tab>` | Toggle selection | Multi-select toggle |

---

## 🎯 Mode-Specific Keybindings

### Insert Mode
| Key | Action | Description |
|-----|--------|-------------|
| `jj` | `<Esc>` | Exit to normal mode |
| `<C-c>` | `<Esc>` | Alternative exit |
| `<Tab>` | Next completion | Next completion item |
| `<S-Tab>` | Previous completion | Previous completion item |
| `<C-Space>` | Trigger completion | Force completion |
| `<CR>` | Confirm completion | Accept completion |
| `<C-e>` | Close completion | Close completion menu |

### Visual Mode
| Key | Action | Description |
|-----|--------|-------------|
| `gc` | Toggle comment | Comment/uncomment selection |
| `gb` | Toggle block comment | Block comment selection |
| `>` | Indent | Indent selection |
| `<` | Unindent | Unindent selection |
| `J` | Move lines down | Move selected lines down |
| `K` | Move lines up | Move selected lines up |

### Command Mode
| Key | Action | Description |
|-----|--------|-------------|
| `<C-p>` | Previous command | Command history up |
| `<C-n>` | Next command | Command history down |
| `<C-a>` | Beginning of line | Move to start |
| `<C-e>` | End of line | Move to end |

---

## 🔧 Custom Leader Mappings

The leader key is set to `<Space>` (spacebar). Here's a summary of all leader-based mappings:

### File Operations
- `<leader>f*` - File finding and search operations (Telescope)
- `<leader>b*` - Buffer management (Barbar)
- `<leader>e*` - File explorer operations

### AI & Coding
- `<leader>a*` - Avante AI assistant
- `<leader>g*` - Git operations and ChatGPT
- `<leader>c*` - CopilotChat and code actions

### Development
- `<leader>r*` - Refactoring and renaming
- `<leader>d*` - Diagnostics
- `<leader>x*` - Trouble and error lists

### Text & Notes
- `<leader>o*` - Obsidian note-taking
- `<leader>s*` - Search and spell checking

### Terminal & System
- `<leader>t*` - Terminal management
- `<leader>n*` - Notifications and UI

---

## 🚀 Quick Reference Card

### Most Used Shortcuts
```
┌─────────────────────── FILES ──────────────────────────┐
│ <leader>ff   Find files         <leader>fb   Buffers   │
│ <leader>fg   Live grep          <leader>fr   Recent    │
│ <leader>bn   Next buffer        <leader>bc   Close     │
├─────────────────────── AI ────────────────────────────┤
│ <leader>gpt  ChatGPT             <leader>aa   Avante   │
│ <leader>cc   CopilotChat         <leader>ge   Edit AI  │
├─────────────────────── LSP ───────────────────────────┤
│ gd           Go to def           gr           Go to ref │
│ K            Hover               <leader>ca   Actions   │
│ <leader>rn   Rename              <leader>f    Format   │
├─────────────────────── GIT ───────────────────────────┤
│ <leader>gp   Preview hunk        <leader>gs   Stage    │
│ <leader>gb   Toggle blame        ]c           Next hunk│
├─────────────────────── TERMINAL ──────────────────────┤
│ <C-`>        Toggle terminal     <leader>gg   LazyGit  │
│ <leader>tf   Float terminal      <leader>tp   Python   │
└────────────────────────────────────────────────────────┘
```

### Emergency Shortcuts
```
┌─────────────────── HELP & ESCAPE ─────────────────────┐
│ jj           Exit insert         <F1>         Help     │
│ <leader>?    Show keymaps        :q!          Force quit│
│ :checkhealth Check system        :Lazy        Plugins  │
└────────────────────────────────────────────────────────┘
```

---

*For plugin-specific advanced keybindings and customization options, refer to the [Plugin Guide](PLUGINS.md).*
