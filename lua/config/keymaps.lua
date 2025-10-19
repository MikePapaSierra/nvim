---- Essential keymaps not covered by which-key
-- These are basic vim behavior modifications and non-leader mappings

---- General keymaps
-- Map jj to <ESC>
vim.keymap.set("i", "jj", "<ESC>")

---- Navigation enhancements - Center buffer while navigating
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "%", "%zz")
vim.keymap.set("n", "*", "*zz")
vim.keymap.set("n", "#", "#zz")

---- Text editing improvements
-- Reselect last visual selection
vim.keymap.set("x", "<<", function()
    vim.cmd("normal! <<")
    vim.cmd("normal! gv")
end)

vim.keymap.set("x", ">>", function()
    vim.cmd("normal! >>")
    vim.cmd("normal! gv")
end)
-- Note: Most leader-based keymaps are now defined in which-key.lua for better organization
-- This file contains only essential non-leader mappings and basic vim behavior modifications


