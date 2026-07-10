# 🤖 AI Tools Setup Guide

Comprehensive setup guide for AI-powered development tools in this Neovim configuration.

## Table of Contents

- [🚀 Quick Start](#-quick-start)
- [🤖 Avante.nvim Setup](#-avantenvim-setup)
- [💬 ChatGPT.nvim Setup](#-chatgptnvim-setup)
- [👨‍💻 GitHub Copilot Setup](#-github-copilot-setup)
- [🔧 Troubleshooting](#-troubleshooting)
- [🎯 Best Practices](#-best-practices)

---

## 🚀 Quick Start

### Prerequisites
1. **Node.js 22+** (required for Copilot)
2. **1Password CLI** (optional, for secure API key management)
3. **OpenAI API Key** or **Claude API Key**
4. **GitHub Copilot subscription** (for Copilot features)

### Installation Check
```bash
# Check if AI tools are properly configured
nvim --headless -c 'checkhealth' -c 'qa!'

# Test specific tools
:AvanteBuild
:ChatGPTStatus
:Copilot status
```

---

## 🤖 Avante.nvim Setup

### Overview
Avante provides a VS Code-like AI coding assistant with a right sidebar interface, supporting multiple AI providers.

### Configuration
Located in: `lua/plugins/avante.lua`

### Supported Providers
- **Claude** (Anthropic) - Default, best for coding
- **OpenAI** (GPT-4) - Alternative option
- **Local Models** - Ollama integration

### Setup Steps

#### 1. Install Dependencies
```bash
# Avante builds automatically on first use
# Manual build if needed:
cd ~/.local/share/nvim/lazy/avante.nvim
make BUILD_FROM_SOURCE=true
```

#### 2. Configure API Keys

**Option A: Environment Variables**
```bash
# For Claude (recommended)
export ANTHROPIC_API_KEY="your-claude-api-key"

# For OpenAI
export OPENAI_API_KEY="your-openai-api-key"
```

**Option B: 1Password Integration**
```bash
# Store API key in 1Password
op item create --category=login --title="Claude API" \
  --vault="Personal" \
  username="claude" \
  password="your-claude-api-key"

# Configure 1Password CLI access
eval $(op signin)
```

#### 3. First Use
```vim
" Open Avante sidebar
:lua require('avante').toggle()

" Or use keybinding
<leader>aa
```

### Key Features

#### Right Sidebar Interface
- **Chat Interface**: Natural language coding conversations
- **Code Context**: Automatic file and selection context
- **Diff Preview**: Visual code suggestions with apply/reject
- **Multiple Sessions**: Maintain separate conversation threads

#### Code Actions
```vim
" Toggle Avante sidebar
<leader>aa

" Edit selection with Avante
<leader>ae

" Focus Avante sidebar
<leader>af

" Refresh Avante
<leader>ar
```

### Customization

#### Provider Configuration
```lua
-- In lua/plugins/avante.lua
provider = "claude",  -- or "openai", "local"
auto_suggestions = true,
claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20241022",
    temperature = 0,
    max_tokens = 4096,
},
```

#### UI Customization
```lua
windows = {
    width = 30,           -- Sidebar width (percentage)
    sidebar_header = {
        align = "center",
        rounded = true,
    },
},
```

---

## 💬 ChatGPT.nvim Setup

### Overview
ChatGPT integration with intelligent 1Password support, custom actions, and graceful fallback mechanisms.

### Configuration
Located in: `lua/plugins/chatgpt.lua`

### Features
- **Smart API Key Detection**: Automatic 1Password CLI integration
- **Graceful Fallback**: Environment variable support
- **Interactive Setup**: User-guided configuration
- **Custom Actions**: Predefined code analysis workflows
- **Context Awareness**: Automatic code context inclusion

### Setup Steps

#### 1. API Key Configuration

**Method 1: 1Password CLI (Recommended)**
```bash
# Install 1Password CLI
# macOS
brew install --cask 1password-cli

# Linux
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

# Store OpenAI API key in 1Password
op item create --category=login --title="OpenAI API" \
  --vault="Personal" \
  username="openai" \
  password="your-openai-api-key"

# Sign in to 1Password
eval $(op signin)
```

**Method 2: Environment Variable**
```bash
export OPENAI_API_KEY="your-openai-api-key"
```

**Method 3: Interactive Setup**
```vim
" Run interactive setup
:ChatGPTSetup
```

#### 2. Verify Configuration
```vim
" Check ChatGPT status
:ChatGPTStatus

" Should show:
" ✅ ChatGPT is properly configured
" 📋 API Key: Retrieved from 1Password CLI
" 🔗 Model: gpt-3.5-turbo
```

### Usage

#### Basic Commands
```vim
" Open ChatGPT interface
:ChatGPT

" Edit with instructions
:ChatGPTEditWithInstructions

" Check configuration
:ChatGPTStatus

" Manual setup
:ChatGPTSetup
```

#### Keybindings
```vim
" Quick ChatGPT access
<leader>gpt

" Edit with ChatGPT
<leader>ge

" Code review
<leader>gc

" Optimize code
<leader>go

" Fix bugs
<leader>gf

" Generate documentation
<leader>gd

" Add tests
<leader>gt
```

#### Custom Actions

**Code Review**
```vim
" Select code and run:
<leader>gc
" Or:
:ChatGPTRun code_review
```

**Security Analysis**
```vim
" Analyze for security issues:
:ChatGPTRun security_review
```

**Performance Optimization**
```vim
" Get performance suggestions:
:ChatGPTRun optimize_code
```

### Configuration Details

#### API Key Detection Logic
```lua
local function get_api_key_with_guidance()
    -- 1. Try 1Password CLI
    local success, key = pcall(function()
        return vim.fn.system("op read 'op://Personal/OpenAI API/password' 2>/dev/null"):gsub("\n", "")
    end)
    
    if success and key ~= "" then
        return key, "1Password CLI"
    end
    
    -- 2. Try environment variable
    local env_key = os.getenv("OPENAI_API_KEY")
    if env_key and env_key ~= "" then
        return env_key, "Environment Variable"
    end
    
    -- 3. Prompt for interactive setup
    return nil, "Not Found"
end
```

#### Custom Actions Configuration
```lua
actions_paths = {
    "~/.config/nvim/chatgpt-actions.json",
},
edit_with_instructions = {
    diff = true,
    keymaps = {
        close = "<C-c>",
        accept = "<C-y>",
        toggle_diff = "<C-d>",
        toggle_settings = "<C-o>",
        cycle_windows = "<Tab>",
        use_output_as_input = "<C-i>",
    },
},
```

---

## 👨‍💻 GitHub Copilot Setup

### Overview
GitHub Copilot integration with CopilotChat for enhanced AI pair programming.

### Configuration
Located in: `lua/plugins/copilotchat.lua` and completion configuration

### Setup Steps

#### 1. GitHub Copilot Subscription
- Sign up at [GitHub Copilot](https://github.com/features/copilot)
- Individual or Business plan required

#### 2. Authentication
```vim
" Authenticate with GitHub
:Copilot auth

" Check status
:Copilot status
```

#### 3. Enable Copilot
```vim
" Enable Copilot
:Copilot enable

" Disable if needed
:Copilot disable
```

### CopilotChat Features

#### Enhanced Prompts
Custom prompts for cloud security engineering:

```lua
prompts = {
    CloudSecurity = {
        prompt = "You are a cloud security expert. Review this code for security vulnerabilities, compliance issues, and best practices for AWS/Azure/GCP.",
        mapping = "<leader>ccs",
    },
    Terraform = {
        prompt = "Review this Terraform code for security, best practices, and resource optimization.",
        mapping = "<leader>cct",
    },
    Kubernetes = {
        prompt = "Analyze this Kubernetes configuration for security, resource management, and best practices.",
        mapping = "<leader>cck",
    },
    Performance = {
        prompt = "Analyze this code for performance issues and suggest optimizations.",
        mapping = "<leader>ccp",
    },
}
```

#### Key Commands
```vim
" Open CopilotChat
<leader>cc

" Explain code
<leader>ce

" Review code
<leader>cr

" Optimize code
<leader>co

" Security analysis
<leader>cs

" Cloud security review
<leader>ccs

" Fix diagnostic
<leader>cf

" Generate commit message
<leader>cm
```

### Inline Completions

#### Auto-completion Integration
- Integrated with nvim-cmp
- Smart ranking with LSP and Copilot
- Ghost text previews
- Multi-line suggestions

#### Acceptance Keys
```vim
" Accept suggestion
<Tab>

" Accept word
<C-Right>

" Accept line
<C-l>

" Dismiss suggestion
<C-e>
```

---

## 🔧 Troubleshooting

### Common Issues

#### Avante Not Working
```vim
" Check build status
:AvanteBuild

" Manual rebuild
:lua require('avante').build()

" Check dependencies
:checkhealth avante
```

**Solution**: Usually requires a manual build
```bash
cd ~/.local/share/nvim/lazy/avante.nvim
make BUILD_FROM_SOURCE=true
```

#### ChatGPT API Key Issues
```vim
" Check configuration
:ChatGPTStatus

" Manual setup
:ChatGPTSetup
```

**Common fixes**:
1. **1Password not signed in**:
   ```bash
   eval $(op signin)
   ```

2. **Environment variable not set**:
   ```bash
   export OPENAI_API_KEY="your-key"
   ```

3. **API key format issues**:
   - Should start with `sk-`
   - No extra whitespace or newlines

#### Copilot Authentication
```vim
" Re-authenticate
:Copilot auth

" Check node.js version
:checkhealth copilot
```

**Node.js version fix**:
```bash
# Update to Node.js 22+
nvm install 22
nvm use 22
```

#### Network/Proxy Issues
```bash
# Set proxy if needed
export HTTPS_PROXY=http://proxy:port
export HTTP_PROXY=http://proxy:port

# Test connectivity
curl -I https://api.openai.com
curl -I https://api.anthropic.com
```

### Health Checks

#### Comprehensive Health Check
```vim
:checkhealth
```

#### Specific Tool Health
```vim
:checkhealth copilot
:checkhealth lsp
:checkhealth mason
```

### Debug Mode

#### Enable Debug Logging
```vim
" ChatGPT debug
:lua vim.g.chatgpt_debug = true

" Copilot debug
:Copilot status

" Avante debug
:lua require('avante').debug()
```

#### Log Locations
```bash
# Neovim log
~/.local/state/nvim/log

# Copilot log
~/.local/state/nvim/copilot/

# Check latest logs
tail -f ~/.local/state/nvim/log
```

---

## 🎯 Best Practices

### API Key Security

#### 1Password Best Practices
1. **Separate Vault**: Store API keys in dedicated vault
2. **Access Control**: Limit vault access
3. **Rotation**: Regularly rotate API keys
4. **Monitoring**: Monitor API usage

#### Environment Variables
```bash
# Use .bashrc/.zshrc for persistent keys
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.bashrc

# Or use .env files with direnv
echo 'export OPENAI_API_KEY="sk-..."' >> .env
direnv allow
```

### Usage Optimization

#### Prompt Engineering
1. **Be Specific**: Detailed, context-rich prompts
2. **Include Context**: File type, framework, requirements
3. **Set Constraints**: Specify coding standards, security requirements
4. **Iterative Refinement**: Build on previous responses

#### Example Prompts
```
# Good prompt
"Review this Python AWS Lambda function for security vulnerabilities, 
performance issues, and compliance with cloud security best practices. 
Consider IAM permissions, input validation, and error handling."

# Better prompt  
"As a cloud security engineer, review this Python AWS Lambda function 
that processes S3 events. Check for: 1) Input validation and sanitization, 
2) Proper IAM principle of least privilege, 3) Secure error handling 
without data leakage, 4) Performance optimization for cold starts, 
5) Compliance with SOC2 and AWS security best practices."
```

### Performance Tips

#### Model Selection
- **Claude 3.5 Sonnet**: Best for complex coding tasks
- **GPT-4**: Good alternative, faster responses
- **GPT-3.5**: Fastest, suitable for simple tasks

#### Usage Patterns
1. **Large Tasks**: Use Avante for complex refactoring
2. **Quick Questions**: Use CopilotChat for explanations
3. **Code Review**: Use ChatGPT custom actions
4. **Inline Help**: Use Copilot completions

### Cost Management

#### API Usage Monitoring
```bash
# Check OpenAI usage
curl -H "Authorization: Bearer $OPENAI_API_KEY" \
  https://api.openai.com/v1/usage

# Set usage alerts in provider dashboards
```

#### Efficient Usage
1. **Context Management**: Include only relevant code
2. **Batch Operations**: Group related questions
3. **Local Models**: Consider Ollama for development
4. **Caching**: Reuse responses for similar tasks

### Security Considerations

#### API Key Protection
- Never commit API keys to version control
- Use environment variables or secure vaults
- Rotate keys regularly
- Monitor for unauthorized usage

#### Code Review
- Always review AI-generated code
- Test thoroughly before deployment
- Consider security implications
- Validate against coding standards

#### Privacy
- Avoid sending sensitive data to AI services
- Review provider privacy policies
- Consider on-premise solutions for sensitive projects
- Use code sanitization before sending to AI

---

## 🔗 Additional Resources

### Official Documentation
- [Avante.nvim GitHub](https://github.com/yetone/avante.nvim)
- [ChatGPT.nvim GitHub](https://github.com/jackMort/ChatGPT.nvim)
- [CopilotChat.nvim GitHub](https://github.com/CopilotC-Nvim/CopilotChat.nvim)
- [GitHub Copilot](https://github.com/features/copilot)

### API Documentation
- [OpenAI API](https://platform.openai.com/docs)
- [Anthropic Claude API](https://docs.anthropic.com/)
- [1Password CLI](https://developer.1password.com/docs/cli)

### Community Resources
- [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)
- [r/neovim](https://reddit.com/r/neovim)
- [Neovim Discourse](https://neovim.discourse.group/)

---

*For more configuration details, see the individual plugin files in `lua/plugins/` and the main [Plugin Guide](PLUGINS.md).*
