return {
	"iamcco/markdown-preview.nvim",
	ft = "markdown",
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
	cmd = {
		"MarkdownPreviewToggle",
		"MarkdownPreview",
		"MarkdownPreviewStop",
	},
	keys = {
		{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview", ft = "markdown" },
	},
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_auto_start = 0
		vim.g.mkdp_auto_close = 1
		vim.g.mkdp_refresh_slow = 0
		vim.g.mkdp_open_to_the_world = 0
		vim.g.mkdp_echo_preview_url = 0
		vim.g.mkdp_theme = 'dark' -- Always use dark theme to match Catppuccin mocha
		vim.g.mkdp_page_title = '「${name}」'
		-- Additional Catppuccin-friendly settings
		vim.g.mkdp_preview_options = {
			mkit = {},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = 0,
			sync_scroll_type = 'middle',
			hide_yaml_meta = 1,
			sequence_diagrams = {},
			flowchart_diagrams = {},
			content_editable = false,
			disable_filename = 0,
			toc = {}
		}
	end,
}
