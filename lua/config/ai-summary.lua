-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ VS Code-like AI Integration Summary                                         │
-- │ Key bindings and commands for enhanced AI experience                       │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

-- This file provides a summary of all AI-related keybindings and features
-- configured to match VS Code's Copilot and AI assistant experience

--[[
=== VS CODE-LIKE KEYBINDINGS ===

Primary AI Commands (Ctrl+K prefix like VS Code):
  <C-k><C-i>  - Toggle Copilot Chat / Avante Ask
  <C-k><C-e>  - Explain selection with AI
  <C-k><C-r>  - Review code with AI
  <C-k><C-f>  - Fix code with AI
  <C-k><C-d>  - Generate documentation
  <C-k><C-t>  - Generate tests
  <C-k><C-c>  - Open Avante Chat

Copilot Suggestions (Alt prefix like VS Code):
  <M-l>       - Accept Copilot suggestion
  <M-]>       - Next Copilot suggestion
  <M-[>       - Previous Copilot suggestion
  <C-]>       - Dismiss Copilot suggestion

Leader Key Commands:
  <leader>ac  - Avante Chat
  <leader>aa  - Avante Toggle
  <leader>ar  - Avante Refresh
  <leader>ae  - Avante Edit Selection (visual mode)

  <leader>gpt - ChatGPT Open Chat
  <leader>gpe - ChatGPT Edit with Instructions
  <leader>gpd - ChatGPT Generate Docstring
  <leader>gpr - ChatGPT Code Review
  <leader>gpf - ChatGPT Fix Bugs
  <leader>gpo - ChatGPT Optimize Code
  <leader>gpx - ChatGPT Explain Code

  <leader>cc* - Copilot Chat commands (see copilotchat.lua for full list)

=== AI FEATURES CONFIGURED ===

1. Avante (Modern AI Assistant):
   - VS Code-like sidebar chat interface
   - Dual AI provider support (Copilot + Claude)
   - Cloud security engineering focused prompts
   - Auto-formatting after AI suggestions
   - Floating windows for quick interactions

2. ChatGPT Integration:
   - Direct ChatGPT API access with GPT-4o
   - Cloud security specialized actions
   - Custom prompts for DevSecOps workflows
   - Infrastructure as Code review capabilities
   - Compliance and security analysis

3. GitHub Copilot Chat:
   - Native GitHub Copilot integration
   - VS Code-like chat experience
   - Intelligent code suggestions
   - Git integration for commit messages
   - Security-focused prompt templates

4. Enhanced Completion:
   - Intelligent source prioritization
   - Copilot suggestions in completion menu
   - Cloud security snippets
   - Performance optimized configuration

=== CLOUD SECURITY FOCUS ===

All AI tools are configured with cloud security engineering in mind:
- Security vulnerability analysis
- Infrastructure as Code best practices
- DevSecOps pipeline recommendations
- Compliance framework alignment
- Zero Trust architecture guidance
- Container and API security reviews
- Secrets management improvements
- Cost optimization with security maintained

=== STARTUP BEHAVIOR ===

- All AI plugins are enabled and ready to use
- Silent startup (no notification spam)
- Performance optimized for large codebases
- VS Code-compatible experience out of the box
--]]

-- Export configuration metadata for other modules
return {
  ai_providers = {
    "avante",      -- Primary AI assistant (right sidebar panel)
    "chatgpt",     -- Direct ChatGPT access  
    "copilot",     -- GitHub Copilot integration
  },
  keybind_style = "vscode",
  focus_area = "cloud_security_engineering",
  performance_optimized = true,
  startup_silent = true,
  ui_style = "vscode_sidebar", -- Right panel layout like VS Code
}
