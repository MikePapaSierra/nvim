return {
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>m", "<cmd>MaximizerToggle<cr>", desc = "󰊓 Toggle window maximizer" },
			{ "<leader>wm", "<cmd>MaximizerToggle<cr>", desc = "󰊓 Maximize window" },
			{ "<leader>wr", "<cmd>MaximizerRestore<cr>", desc = "󰊔 Restore window" },
		},
		config = function()
			-- Enhanced window maximizer configuration
			vim.g.maximizer_set_default_mapping = 0  -- Disable default mappings
			vim.g.maximizer_restore_on_winleave = 1  -- Auto-restore on window leave
			
			-- Custom maximize function with better feedback
			local function smart_maximize()
				local was_maximized = vim.g.maximizer_is_maximized
				vim.cmd("MaximizerToggle")
				
				local action = was_maximized and "restored" or "maximized"
				local icon = was_maximized and "󰊔" or "󰊓"
				
				vim.notify(
					string.format("Window %s", action),
					vim.log.levels.INFO,
					{ 
						title = icon .. " Window Manager",
						timeout = 1500
					}
				)
			end
			
			-- Override default keymap with enhanced function
			vim.keymap.set("n", "<leader>m", smart_maximize, { 
				desc = "󰊓 Smart window maximize/restore" 
			})
			
			-- Auto-restore on specific events for better UX
			vim.api.nvim_create_autocmd({ "WinLeave", "TabLeave" }, {
				group = vim.api.nvim_create_augroup("MaximizerAutoRestore", { clear = true }),
				callback = function()
					if vim.g.maximizer_is_maximized then
						vim.cmd("MaximizerRestore")
					end
				end,
			})
			
			-- Integration with other window management
			vim.api.nvim_create_autocmd("VimResized", {
				group = vim.api.nvim_create_augroup("MaximizerResize", { clear = true }),
				callback = function()
					if vim.g.maximizer_is_maximized then
						vim.cmd("MaximizerToggle")
						vim.cmd("MaximizerToggle")
					end
				end,
			})
		end,
	},
}
