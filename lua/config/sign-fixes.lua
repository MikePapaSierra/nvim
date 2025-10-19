-- ╭─────────────────────────────────────────────────────────────────────────────╮
-- │ Sign Text Fixes for Neovim Configuration                                   │
-- │ All sign text has been converted to ASCII-safe characters                  │
-- ╰─────────────────────────────────────────────────────────────────────────────╯

--[[
FIXES APPLIED:

1. ChatGPT Plugin (lua/plugins/chatgpt.lua):
   - question_sign: "User:" → "U"
   - answer_sign: "GPT:" → "G"  
   - active_sign: " * " → "*"
   - inactive_sign: " - " → "-"
   - setting_sign: "  " → ">"
   - Added error handling with pcall

2. Diagnostic Signs (lua/config/options.lua):
   - Error: Unicode icon → "E"
   - Warn: Unicode icon → "W"
   - Hint: Unicode icon → "H"
   - Info: Unicode icon → "I"

3. Avante Plugin (lua/plugins/avante.lua):
   - prefix: "💬 " → "> "
   - nerd_font_icon: Unicode → "*"

4. File Structure Cleanup:
   - Removed duplicate core/options.lua
   - All configuration now in config/options.lua

ERROR RESOLVED:
E239: Invalid sign text errors caused by:
- Colons in sign text ("User:", "GPT:")
- Unicode characters in diagnostic signs
- Multi-character signs with spaces
- Emoji characters in config

All sign text is now single ASCII characters or safe ASCII strings.
--]]

return {
  fixes_applied = {
    "chatgpt_signs",
    "diagnostic_signs", 
    "avante_signs",
    "file_structure_cleanup"
  },
  status = "all_sign_errors_resolved"
}
