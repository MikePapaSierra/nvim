return {
	'romgrk/barbar.nvim',
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		'lewis6991/gitsigns.nvim',
		'nvim-tree/nvim-web-devicons',
	},
	init = function() 
		vim.g.barbar_auto_setup = false 
	end,
	keys = {
		-- Buffer navigation
		{ "<A-h>", "<Cmd>BufferPrevious<CR>", desc = "Previous buffer" },
		{ "<A-l>", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
		{ "<A-c>", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
		
		-- Buffer reordering
		{ "<A-S-h>", "<Cmd>BufferMovePrevious<CR>", desc = "Move buffer left" },
		{ "<A-S-l>", "<Cmd>BufferMoveNext<CR>", desc = "Move buffer right" },
		
		-- Buffer jumping (goto buffer in position)
		{ "<A-1>", "<Cmd>BufferGoto 1<CR>", desc = "Go to buffer 1" },
		{ "<A-2>", "<Cmd>BufferGoto 2<CR>", desc = "Go to buffer 2" },
		{ "<A-3>", "<Cmd>BufferGoto 3<CR>", desc = "Go to buffer 3" },
		{ "<A-4>", "<Cmd>BufferGoto 4<CR>", desc = "Go to buffer 4" },
		{ "<A-5>", "<Cmd>BufferGoto 5<CR>", desc = "Go to buffer 5" },
		{ "<A-6>", "<Cmd>BufferGoto 6<CR>", desc = "Go to buffer 6" },
		{ "<A-7>", "<Cmd>BufferGoto 7<CR>", desc = "Go to buffer 7" },
		{ "<A-8>", "<Cmd>BufferGoto 8<CR>", desc = "Go to buffer 8" },
		{ "<A-9>", "<Cmd>BufferGoto 9<CR>", desc = "Go to buffer 9" },
		{ "<A-0>", "<Cmd>BufferLast<CR>", desc = "Go to last buffer" },
		
		-- Buffer management
		{ "<A-p>", "<Cmd>BufferPin<CR>", desc = "Pin/unpin buffer" },
		{ "<A-S-c>", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Close all but current" },
		{ "<A-S-p>", "<Cmd>BufferCloseAllButPinned<CR>", desc = "Close all but pinned" },
		{ "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", desc = "Order by buffer number" },
		{ "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", desc = "Order by directory" },
		{ "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", desc = "Order by language" },
		{ "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", desc = "Order by window number" },
		
		-- Magic buffer-picking mode
		{ "<C-p>", "<Cmd>BufferPick<CR>", desc = "Pick buffer" },
		{ "<C-A-p>", "<Cmd>BufferPickDelete<CR>", desc = "Pick buffer to delete" },
	},
	opts = {
		-- Enable/disable animations
		animation = true,
		
		-- Automatically hide the tabline when there are this many buffers or fewer.
		auto_hide = false,
		
		-- Enable/disable current/total tabpages indicator (top right corner)
		tabpages = true,
		
		-- Enables/disable clickable tabs
		clickable = true,
		
		-- Excludes buffers from the tabline
		exclude_ft = { 'javascript' },
		exclude_name = { 'package.json' },
		
		-- A buffer to this direction will be focused (if it exists) when closing the current buffer.
		focus_on_close = 'left',
		
		-- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
		hide = { extensions = false, inactive = false },
		
		-- Disable highlighting alternate buffers
		highlight_alternate = false,
		
		-- Disable highlighting file icons in inactive buffers
		highlight_inactive_file_icons = false,
		
		-- Enable highlighting visible buffers
		highlight_visible = true,
		
		icons = {
			-- Configure the base icons on the bufferline.
			-- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
			buffer_index = false,
			buffer_number = false,
			button = '',
			-- Enables / disables diagnostic symbols
			diagnostics = {
				[vim.diagnostic.severity.ERROR] = { enabled = true, icon = '' },
				[vim.diagnostic.severity.WARN] = { enabled = false },
				[vim.diagnostic.severity.INFO] = { enabled = false },
				[vim.diagnostic.severity.HINT] = { enabled = true, icon = '' },
			},
			gitsigns = {
				added = { enabled = true, icon = '+' },
				changed = { enabled = true, icon = '~' },
				deleted = { enabled = true, icon = '-' },
			},
			filetype = {
				-- Sets the icon's highlight group.
				-- If false, will use nvim-web-devicons colors
				custom_colors = false,
				
				-- Requires `nvim-web-devicons`
				enabled = true,
			},
			separator = { left = '▎', right = '' },
			
			-- If true, add an additional separator at the end of the buffer list
			separator_at_end = true,
			
			-- Configure the icons on the bufferline when modified or pinned.
			modified = { button = '●' },
			pinned = { button = '', filename = true },
			
			-- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
			preset = 'default',
			
			-- Configure the icons on the bufferline based on the visibility of a buffer.
			alternate = { filetype = { enabled = false } },
			current = { buffer_index = true },
			inactive = { button = '×' },
			visible = { modified = { buffer_number = false } },
		},
		
		-- If true, new buffers will be inserted at the start/end of the list.
		insert_at_end = false,
		insert_at_start = false,
		
		-- Sets the maximum padding width with which to surround each tab
		maximum_padding = 1,
		
		-- Sets the minimum padding width with which to surround each tab
		minimum_padding = 1,
		
		-- Sets the maximum buffer name length.
		maximum_length = 30,
		
		-- Sets the minimum buffer name length.
		minimum_length = 0,
		
		-- If set, the letters for each buffer in buffer-pick mode will be
		-- assigned based on their name. Otherwise or in case all letters are
		-- already assigned, the behavior is to assign letters in order of
		-- usability (see order below)
		semantic_letters = true,
		
		-- Set the filetypes which barbar will offset itself for
		sidebar_filetypes = {
			-- Use the default values: {event = 'BufWinLeave', text = '', align = 'left'}
			NvimTree = true,
			-- Or, specify the text used for the offset:
			undotree = {
				text = 'undotree',
				align = 'center', -- *optionally* specify an alignment (either 'left', 'center', or 'right')
			},
			-- Or, specify the event which the sidebar executes when leaving:
			['neo-tree'] = { event = 'BufWipeout' },
			-- Or, specify both
			Outline = { event = 'BufWinLeave', text = 'symbols-outline', align = 'right' },
		},
		
		-- New buffer letters are assigned in this order. This order is
		-- optimal for the qwerty keyboard layout, but might need adjustment
		-- for other layouts.
		letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
		
		-- To disable tabline completely if only one buffer
		no_name_title = nil,
	},
	version = '^1.0.0',
}
