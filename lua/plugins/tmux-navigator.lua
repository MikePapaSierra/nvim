return {
	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
		keys = {
			-- Enhanced tmux navigation (VS Code style)
			{ "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "󰁍 Navigate left (tmux)" },
			{ "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "󰁅 Navigate down (tmux)" },
			{ "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "󰁝 Navigate up (tmux)" },
			{ "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "󰁔 Navigate right (tmux)" },
		},
		init = function()
			-- Enhanced tmux integration settings
			vim.g.tmux_navigator_no_mappings = 1
			vim.g.tmux_navigator_save_on_switch = 2
			vim.g.tmux_navigator_disable_when_zoomed = 1
		end,
		config = function()
			-- Custom tmux navigation with better integration
			local function tmux_navigate(direction)
				local tmux_directions = {
					h = "left",
					j = "down", 
					k = "up",
					l = "right"
				}
				
				local tmux_dir = tmux_directions[direction]
				if tmux_dir then
					vim.fn.system("tmux select-pane -" .. string.upper(direction:sub(1,1)))
				end
			end
			
			-- Enhanced tmux awareness (notification disabled)
			-- Silent tmux integration - no notifications needed
		end,
	},
}
