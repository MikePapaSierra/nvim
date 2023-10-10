return {
		'vimwiki/vimwiki',
		init = function()
			vim.g.vimwiki_list = {{ path = '$HOME/Documents/wiki', syntax = 'markdown', ext = '.md', auto_diary_index = 1, diary_rel_path = 'log', diary_index = 'log', diary_header = 'Log' }}

			vim.cmd("autocmd FileType vimwiki set ft=markdown")

			vim.g.vimwiki_ext2syntax = { ['.md'] = 'markdown', ['.markdown'] =  'markdown', ['.mdown'] = 'markdown' }

			vim.g.vimwiki_listsyms = '✗○◐●✓'
			vim.g.vimwiki_markdown_link_ext = 1
			vim.g.vimwiki_folding = ''
			vim.g.vimwiki_diary_months = { ['1'] =  'January', ['2'] = 'February', ['3'] = 'March', ['4'] = 'April', ['5'] = 'May', ['6'] = 'June', ['7'] = 'July', ['8'] = 'August', ['9'] = 'September', ['10'] = 'October', ['11'] = 'November', ['12'] = 'December' }
		end
}
