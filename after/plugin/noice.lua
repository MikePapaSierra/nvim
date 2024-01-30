local map = vim.api.nvim_set_keymap

--- Dismiss Noice Messages
map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", {desc = "Dismiss Noice Message"})
