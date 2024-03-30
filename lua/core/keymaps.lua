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
	require("spectre").open_visual({select_word = true})
end, { desc = "Search current word" })

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

-- Turn off highlight results
vim.keymap.set("n", "<leader>no", "<CMDv>noh<CR>")

-- Diagnostics

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

-- Mapping MaximizerToggle command (szw/nvim-maximizer) to leader-m
vim.keymap.set("n", "<leader>m", "<CMD>MaximizerToggle<CR>")

-- Press leader-rw to rotate open windows
vim.keymap.set("n", "<leader>rw", ":RotateWindows<CR>", { desc = "[R]otate [W]indows" })

-- Press leader-f to format
vim.keymap.set("n", "<leader>f", "<CMD>Format<CR>", { desc = "[F]ormat" })

-- Press leader-gx to open the URL under the cursor
vim.keymap.set("n", "<leader>gx", ":sil !open <cWORD><CR>", { desc = "Open URL under cursor" , silent = true})

--- LSP keybindings
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

-- Insert --
-- Map jj to <ESC>
vim.keymap.set("i", "jj", "<ESC>")

-- Visual -- 
-- Paste without loosing the content of the register
vim.keymap.set("v", "<leader>p", '"_dP')

-- Move selected text up/down
vim.keymap.set("v", "A-j", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k", ":m '<-2<CR>gv=gv")

-- Reselect last visual selection
vim.keymap.set("x", "<<", function()
	vim.cmd("normal! <<")
	vim.cmd("normal! gv")
end)

vim.keymap.set("x", ">>", function()
	vim.cmd("normal! >>")
	vim.cmd("normal! gv")
end)
