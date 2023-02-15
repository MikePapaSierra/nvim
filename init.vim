" TODO: Reviev this video for new plugins:
" https://www.youtube.com/watch?v=vdn_pKJUda8
" Code is available here: https://github.com/josean-dev/dev-environment-files/tree/main/.config/nvim
"
" TODO: Figure out how to open things in floating windows like in this case: https://www.youtube.com/watch?v=_1ijgc7G3pg
" Repo: https://github.com/kidp2h               
"
" General configuration
source $HOME/.config/nvim/general/settings.vim
" Filetype configuration
source $HOME/.config/nvim/general/filetypes.vim
" Keybindings
source $HOME/.config/nvim/keys/mappings.vim
" Plugin installation
source $HOME/.config/nvim/vim-plug/plugins.vim
" Plugins configuration
source $HOME/.config/nvim/plug-config/airline.vim
source $HOME/.config/nvim/plug-config/rainbow.vim
source $HOME/.config/nvim/plug-config/barbar.vim
source $HOME/.config/nvim/plug-config/signify.vim
source $HOME/.config/nvim/plug-config/markdown-preview.vim
" Treesiter configuration
lua require('treesitter')
" CMP configuration
lua require('nvim-cmp')
" Nvimtree configuration
lua require('tree')
" Colorization
lua require('plug-colorizer')
" Configure Dracula theme
packadd! dracula_pro
" Enable transparency
hi Normal guibg=None ctermbg=None
hi EndOfBuffer guibg=None ctermbg=None
" Lsp configuration
" TODO: Configure snippets; Add support for Go; Add support for Terraform
set completeopt=menuone,noinsert,noselect
let g:completetion_matching_strategy_list = [ 'exact', 'substring', 'fuzzy' ]
lua require('lspinstaller')
" Vimwiki configurationr
let g:vimwiki_list = [{'path':'$HOME/vimwiki', 'syntax':'markdown', 'ext': '.md', 'auto_diary_index': 1, 'diary_rel_path': './battlelog', 'diary_index': 'battlelog', 'diary_header': 'Battlelog'}]
autocmd FileType vimwiki set ft=markdown
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown':'markdown'}
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_folding = ''
let g:vimwiki_diary_months = {
      \ 1: 'January', 2: 'February', 3: 'March',
      \ 4: 'April', 5: 'May', 6: 'June',
      \ 7: 'July', 8: 'August', 9: 'September',
      \ 10: 'October', 11: 'November', 12: 'December'
      \ }
