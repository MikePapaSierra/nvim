return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "gcc", desc = "Toggle comment line" },
			{ "gbc", desc = "Toggle comment block" },
			{ "gc", desc = "Toggle comment", mode = { "n", "v" } },
			{ "gb", desc = "Toggle comment block", mode = { "n", "v" } },
		},
		config = function()
			require("Comment").setup({
				padding = true,
				sticky = true,
				ignore = nil,
				toggler = {
					line = 'gcc',
					block = 'gbc',
				},
				opleader = {
					line = 'gc',
					block = 'gb',
				},
				extra = {
					above = 'gcO',
					below = 'gco',
					eol = 'gcA',
				},
				mappings = {
					basic = true,
					extra = true,
				},
			})
		end,
	}
}
