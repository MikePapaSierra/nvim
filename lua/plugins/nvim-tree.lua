return {
	'nvim-tree/nvim-tree.lua',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local nvimtree = require('nvim-tree')

		--Recommended settings for nvim-treee
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- Config of the nvim-tree
		nvimtree.setup({
			sort_by = 'case_sensitive',
			view = {
				width = 30,
			},
			filters = {
				dotfiles = true,
			},
		})
		local keymap = vim.keymap
		keymap.set('n', '<leader>te', '<cmd>NvimTreeToggle<CR>')
		keymap.set('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>')
	end,
}
