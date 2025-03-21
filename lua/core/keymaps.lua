---- General keymaps
-- Map jj to <ESC>
vim.keymap.set("i", "jj", "<ESC>")
-- Press leader-gx to open the URL under the cursor
vim.keymap.set("n", "<leader>gx", ":sil !open <cWORD><CR>", { desc = "Open URL under cursor", silent = true })

-- Split window management
vim.keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
vim.keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
vim.keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
vim.keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
vim.keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger
vim.keymap.set("n", "<leader>sh", "<C-w><5") -- make split windows width smaller
---
---- Diff keymaps
vim.keymap.set("n", "<leader>cc", ":diffput<CR>") -- put diff from current to other during diff
vim.keymap.set("n", "<leader>cj", ":diffget 1<CR>") -- get diff from left (local) during merge
vim.keymap.set("n", "<leader>ck", ":diffget 3<CR>") -- get diff from right (remote) during merge
vim.keymap.set("n", "<leader>cn", "]c") -- next diff hunk
vim.keymap.set("n", "<leader>cp", "[c") -- previous diff hunk

---- Buffers
-- Center buffer while navigating
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
---- Barbar
-- Move to previous/next
vim.api.nvim_set_keymap("n", "<A-h>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-l>", "<Cmd>BufferNext<CR>", { noremap = true, silent = true })
-- Re-order to previous/next
vim.api.nvim_set_keymap("n", "<A-C-h>", "<Cmd>BufferMovePrevious<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-C-l>", "<Cmd>BufferMoveNext<CR>", { noremap = true, silent = true })
-- Goto buffer in position...
vim.api.nvim_set_keymap("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-0>", "<Cmd>BufferLast<CR>", { noremap = true, silent = true })
-- Pin/unpin buffer
vim.api.nvim_set_keymap("n", "<A-p>", "<Cmd>BufferPin<CR>", { noremap = true, silent = true })
-- Close buffer
vim.api.nvim_set_keymap("n", "<A-c>", "<Cmd>BufferClose<CR>", { noremap = true, silent = true })
-- Magic buffer-picking mode
vim.api.nvim_set_keymap("n", "<C-p>", "<Cmd>BufferPick<CR>", { noremap = true, silent = true })
-- Sort automatically by...
vim.api.nvim_set_keymap("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", { noremap = true, silent = true })

---- Search and replace
-- Press S for quick find/replace for the word under the cursor
vim.keymap.set("n", "S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", true)
end)
-- Open Spectre for global find/replace
vim.keymap.set("n", "<leader>S", function()
	require("spectre").toggle()
end)
-- Open Spectre for global find/replace for the word under the cursor in normal mode
vim.keymap.set("n", "<leader>sw", function()
	require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })
-- Turn off highlight results
vim.keymap.set("n", "<leader>no", "<CMDv>noh<CR>")

---- Git keymappings
vim.keymap.set({ "n", "v" }, "<leader>gbf", ":GBrowse<cr>", { desc = "[G]it [B]rowse [F]ile" })
vim.keymap.set("n", "<leader>glc", function()
	vim.cmd(":GBrowse!")
end, { desc = "[G]it [L]ink [C]opy" })
vim.keymap.set("n", "<leader>gdf", ":Gvdiffsplit<cr>", { desc = "[G]it [D]iff" })

-- Debugging
vim.keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
vim.keymap.set(
	"n",
	"<leader>bl",
	"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>"
)
vim.keymap.set("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>")
vim.keymap.set("n", "<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>")
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
vim.keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
vim.keymap.set("n", "<leader>dd", function()
	require("dap").disconnect()
	require("dapui").close()
end)
vim.keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
	require("dapui").close()
end)
vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
vim.keymap.set("n", "<leader>di", function()
	require("dap.ui.widgets").hover()
end)
vim.keymap.set("n", "<leader>d?", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end)
vim.keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<cr>")
vim.keymap.set("n", "<leader>dh", "<cmd>Telescope dap commands<cr>")
vim.keymap.set("n", "<leader>de", function()
	require("telescope.builtin").diagnostics({ default_text = ":E:" })
end)

---- Diagnostics
-- Goto next diagnostic of any severity
vim.keymap.set("n", "]d", function()
	vim.lsp.diagnostic.goto_next()
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Goto previous diagnostic of any severity
vim.keymap.set("n", "[d", function()
	vim.lsp.diagnostic.goto_prev()
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Coto next error diagnostic
vim.keymap.set("n", "]e", function()
	vim.lsp.diagnostic.goto_next({ severity = vim.lsp.protocol.DiagnosticSeverity.Error })
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Goto previous error diagnostic
vim.keymap.set("n", "[e", function()
	vim.lsp.diagnostic.goto_prev({ severity = vim.lsp.protocol.DiagnosticSeverity.Error })
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Goto next warning diagnostic
vim.keymap.set("n", "]w", function()
	vim.lsp.diagnostic.goto_next({ severity = vim.lsp.protocol.DiagnosticSeverity.Warning })
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Goto previous warning diagnostic
vim.keymap.set("n", "[w", function()
	vim.lsp.diagnostic.goto_prev({ severity = vim.lsp.protocol.DiagnosticSeverity.Warning })
	vim.api.nvim_feedkeys("zz", "n", false)
end)
-- Open diagnostic in pop-up window
vim.keymap.set("n", "<leader>d", function()
	vim.diagnostic.open_float({
		border = "rounded",
	})
end)
-- Place all diagnostics in the quickfix list
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
-- Navigate to the next qflist item
vim.keymap.set("n", "<leader>cn", ":cnext<CR>zz")
-- Navigate to the previous qflist item
vim.keymap.set("n", "<leader>cp", ":cprev<CR>zz")
-- Open the qflist
vim.keymap.set("n", "<leader>co", ":copen<CR>zz")
-- Close the qflist
vim.keymap.set("n", "<leader>cc", ":cclose<CR>zz")

---- Maximizer
-- Mapping MaximizerToggle command (szw/nvim-maximizer) to leader-m
vim.keymap.set("n", "<leader>m", "<CMD>MaximizerToggle<CR>")

---- LSP keybindings
-- Press leader-f to format
vim.keymap.set("n", "<leader>f", "<CMD>Format<CR>", { desc = "[F]ormat" })
--vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
--vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })
--
--vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })
--vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
--vim.keymap.set("n", "td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
--
---- Telescope keybindings
--vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number })
--vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, { desc = "LSP: [G]oto [I]mplementations", buffer = buffer_number })
--
--vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
--vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature documentation", buffer = buffer_number })
--vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature documentation", buffer = buffer_number })

-- Nvim-tree
vim.keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>") -- toggle file explorer
vim.keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>") -- toggle focus to file explorer
vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer

---- Telescope

-- Copy and paste --
-- Paste without loosing the content of the register
vim.keymap.set("v", "<leader>p", '"_dP')
-- Yank current file in to the cloppboard buffer
vim.keymap.set("n", "<leader>yf", ":%y<cr>", { desc = "[Y]ank [F]ile" })
-- Paste from selected register
vim.keymap.set("i", "<c-r>", function()
	require("telescope.builtin").registers()
end, { remap = true, silent = false, desc = "Paste from selected register" })

-- Move selected text up/down
vim.keymap.set("v", "<leader>mj", ":m '>+1<CR>gv=gv", { desc = "Move selected text down" })
vim.keymap.set("v", "<leader>mk", ":m '<-2<CR>gv=gv", { desc = "Move selected text up" })
vim.keymap.set("n", "<leader>mj", ":m .+1<CR>==", { desc = "Move current line down" })
vim.keymap.set("n", "<leader>mk", ":m .-2<CR>==", { desc = "Move current line up" })

-- Reselect last visual selection
vim.keymap.set("x", "<<", function()
	vim.cmd("normal! <<")
	vim.cmd("normal! gv")
end)

vim.keymap.set("x", ">>", function()
	vim.cmd("normal! >>")
	vim.cmd("normal! gv")
end)
