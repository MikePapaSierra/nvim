return {
	"nvim-pack/nvim-spectre",
	lazy = true,
	cmd = { "Spectre" },
	depedencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- local theme = require("DraculaPro.pallets").get_pallettte("dark")

		-- vim.api.nvim_set_hl(0, "SpectreSearch", { bg = theme.red, fg = theme.bg })
		-- vim.api.nvim_set_hl(0, "SpectreReplace", { bg = theme.green, fg = theme.bg })

		require('spectre').setup({
			hilight = {
				ui = "DraculaPro",
				replace = {
					ui = "DraculaPro",
				},
				search = {
					ui = "DraculaPro",
				},
			},
			mapping = {
				["send_to_qf"] = {
					map = "<C-q>",
					cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
					desc = "Send all item to quickfix",
				},
			},
		})
	end,
}
