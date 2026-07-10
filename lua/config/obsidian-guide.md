# Obsidian Three-Domain Note System

## 📁 Folder Structure
```
/home/mps/second-brain/vaults/personal-obsidian-vault/
├── 00-daily/          # Unified daily notes (common for all domains)
├── 01-private/        # Private notes (prv-*)
├── 02-professional/   # Professional notes (pro-*)
├── 03-hobby/          # Hobby notes (hby-*)
├── inbox/             # Quick capture notes (unsorted)
├── templates/         # Note templates for all domains
└── assets/            # Attachments (images, files)
```

## 🔄 Sync Optimization

### Sync-Friendly Features
- **Conflict Resolution**: Configured to ask for user input on conflicts
- **Auto-Pull**: 5-minute intervals to stay synchronized
- **Minimal File Watching**: Optimized for sync services (iCloud, Dropbox, Syncthing)
- **Pre-Write Hooks**: Ensures proper formatting before sync

### Best Practices for Sync
1. **Use Absolute Paths**: Configuration uses full paths for sync reliability
2. **Conflict Resolution**: Always review conflicts before merging
3. **Regular Pulls**: Let the system auto-pull changes every 5 minutes
4. **Asset Organization**: Keep all attachments in dedicated `assets/` folder
5. **Template Consistency**: Use templates to maintain format across devices

## 🏷️ Domain Prefixes

### Private Domain (prv-)
- **prv-health-** : Health logs, medical appointments, fitness tracking
- **prv-finance-** : Budget reviews, investment tracking, expense logs
- **prv-home-** : Home management, maintenance schedules, utilities
- **prv-** : General private notes

### Professional Domain (pro-)
- **pro-project-** : Work project documentation and progress
- **pro-meeting-** : Meeting notes with timestamps
- **pro-** : General professional knowledge and notes

### Hobby Domain (hby-)
- **hby-woodwork-** : Woodworking projects and techniques
- **hby-3dprint-** : 3D printing projects and settings
- **hby-smarthome-** : IoT devices and smart home automation
- **hby-improvement-** : Home improvement projects
- **hby-** : General hobby notes

## ⚡ Quick Commands

### Core Commands
- `:ObsidianNew` - Create new note
- `:ObsidianDailies` - Open daily note
- `:ObsidianSearch` - Search all notes
- `:ObsidianQuickSwitch` - Quick note switcher

### Enhanced Markdown Commands
- `:MarkdownPreview` - Live preview in browser
- `:MarkdownPreviewToggle` - Toggle live preview
- `:RenderMarkdown toggle` - Toggle beautiful rendering
- `:TableModeToggle` - Enhanced table editing

### Domain-Specific Commands
- `:PrivateNote` - New private note
- `:HealthNote` - Health log (auto-dated)
- `:FinanceNote` - Finance note (auto-dated)
- `:HomeNote` - Home management note

- `:ProNote` - New professional note
- `:ProjectNote` - Project note with name input
- `:MeetingNote` - Meeting note (auto-timestamped)

- `:HobbyNote` - New hobby note
- `:WoodworkNote` - Woodworking project note
- `:PrintNote` - 3D printing project note
- `:SmartHomeNote` - Smart home device note
- `:ImprovementNote` - Home improvement note

### Utility Commands
- `:ObsidianStats` - Show vault structure
- `:ObsidianDomain` - Quick domain switcher

## 🔗 Key Bindings

### Core Bindings
- `<leader>on` - New note
- `<leader>od` - Daily notes
- `<leader>os` - Search notes
- `<leader>oq` - Quick switch
- `<leader>ot` - Insert template

### Enhanced Markdown Bindings
- `<leader>mp` - Preview markdown in browser
- `<leader>mt` - Toggle live preview
- `<leader>mr` - Toggle beautiful rendering
- `<leader>tm` - Toggle table mode
- `<leader>tr` - Realign table

### Quick Text Formatting
- `<leader>mb` - **Bold** text (visual mode)
- `<leader>mi` - *Italic* text (visual mode)
- `<leader>mc` - `Code` text (visual mode)
- `<leader>md` - ~~Strikethrough~~ text (visual mode)

### Enhanced Navigation
- `]]` - Next heading
- `[[` - Previous heading
- `]c` - Current heading
- `]p` - Parent heading

### Domain Quick Notes
- `<leader>onp` - New private note
- `<leader>onh` - New health note
- `<leader>onf` - New finance note
- `<leader>onm` - New home note

- `<leader>onP` - New professional note
- `<leader>onj` - New project note
- `<leader>onM` - New meeting note

- `<leader>onH` - New hobby note
- `<leader>onw` - New woodwork note
- `<leader>on3` - New 3D print note
- `<leader>ons` - New smart home note
- `<leader>oni` - New improvement note

## 📝 Daily Notes Workflow

1. **Unified Daily Notes**: All domains share the same daily note system in `00-daily/`
2. **Daily Template**: Create specific sections for each domain in your daily template:
   ```markdown
   # {{date:YYYY-MM-DD}} Daily Note

   ## 🏠 Private
   - [ ] 

   ## 💼 Professional  
   - [ ] 

   ## 🔨 Hobby
   - [ ] 

   ## 📝 Notes
   
   ## 🔗 Created Today
   - 
   ```

3. **Link to Domain Notes**: From daily notes, create links to specific domain notes as needed

## 🎯 Best Practices

1. **Use Prefixes Consistently**: Always use domain prefixes for automatic organization
2. **Daily Capture**: Use daily notes as the central hub for all domains
3. **Template Usage**: Create templates for common note types in each domain
4. **Tagging Strategy**: Use consistent tags like #private, #professional, #hobby
5. **Regular Review**: Weekly review of each domain folder for organization

## 📊 Template Examples

### Daily Template (daily-template.md)
```markdown
# {{date:YYYY-MM-DD}} - {{date:dddd}}

## 🌅 Morning Review
- [ ] Check calendar
- [ ] Review priorities

## 🏠 Private Domain
### Health & Wellness
- [ ] 

### Home & Finance
- [ ] 

## 💼 Professional Domain
### Work & Projects
- [ ] 

### Learning & Development
- [ ] 

## 🔨 Hobby Domain
### Woodworking
- [ ] 

### 3D Printing & IoT
- [ ] 

### Home Improvements
- [ ] 

## 🌙 Evening Reflection
- 
- 
- 

## 🔗 Notes Created Today
<!-- Auto-populate with links to notes created today -->
```

### Health Note Template (prv-health-template.md)
```markdown
# Health Log - {{date:YYYY-MM-DD}}

## 📊 Vitals
- Weight: 
- Sleep: hours ( - )
- Energy Level: /10
- Mood: /10

## 💊 Medications
- [ ] 

## 🍎 Nutrition
### Meals
- Breakfast: 
- Lunch: 
- Dinner: 
- Snacks: 

### Water: glasses

## 🏃 Exercise
- Type: 
- Duration: 
- Intensity: /10
- Notes: 

## 🩺 Health Notes
- 

## 📅 Next Actions
- [ ] 

---
Tags: #health #private #daily-tracking
Created: {{date:YYYY-MM-DD HH:mm}}
```

## ✨ Enhanced Markdown Features

### 🎨 Beautiful Rendering
- **Live Rendering**: Beautiful in-editor markdown rendering with `render-markdown.nvim`
- **Syntax Highlighting**: Enhanced syntax highlighting for code blocks and inline code
- **Beautiful Headers**: Styled headers with domain-specific colors and icons
- **Enhanced Tables**: Beautiful pipe tables with rounded borders
- **Custom Checkboxes**: Domain-specific task states:
  - `[ ]` - Unchecked (󰄱)
  - `[x]` - Checked (󰱒)
  - `[>]` - Todo (󰅂)
  - `[!]` - Urgent (󰀦)
  - `[?]` - Question/Note (󰍨)
  - `[/]` - In Progress (󰡖)
  - `[p]` - Private task (󰒡)
  - `[w]` - Work task (󰼏)
  - `[h]` - Hobby task (󰠱)

### 📊 Enhanced Tables
- **Table Mode**: Advanced table editing with automatic alignment
- **Visual Editing**: Real-time table formatting and alignment
- **Smart Navigation**: Easy movement between table cells
- **Auto-formatting**: Automatic table structure maintenance

### 🔍 Live Preview
- **Browser Preview**: Live markdown preview in your default browser
- **Auto-refresh**: Automatic updates as you type
- **Synchronized Scrolling**: Preview scrolls with your editor
- **Custom Styling**: Dark theme optimized for Obsidian-style notes

### 🧭 Smart Navigation
- **Heading Navigation**: Jump between headings with `]]` and `[[`
- **Folding Support**: Hierarchical folding based on heading levels
- **Link Following**: Smart link following for wiki-style and regular links
- **Cross-references**: Automatic linking between notes in your vault

### 📝 Quick Formatting
- **Inline Styles**: Quick bold, italic, code, and strikethrough formatting
- **Visual Mode**: Format selected text with simple key combinations
- **Link Management**: Easy link creation and following
- **Quote Blocks**: Beautiful quote rendering with custom styling

### 🎯 Domain Integration
The markdown enhancements are fully integrated with your three-domain system:
- **Color Coding**: Headers use domain-specific colors
- **Task Management**: Custom checkboxes for each domain
- **Cross-linking**: Smart linking between domain folders
- **Template Integration**: Enhanced templates with beautiful formatting

This system provides a comprehensive framework for organizing your personal knowledge across all life domains while maintaining a unified daily workflow.
