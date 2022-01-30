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
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/rainbow.vim
source $HOME/.config/nvim/plug-config/start-screen.vim
" Treesiter configuration
lua require('treesitterconf')
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" Colorization
lua require'plug-colorizer'
"Configure colorscheme to codedark
"(https://github.com/tomasiser/vim-code-dark#readme) 
colorscheme codedark
let g:airline_theme = 'codedark'
" Enable transparency
hi Normal guibg=None ctermbg=None
hi EndOfBuffer guibg=None ctermbg=None
" Lsp configuration
" TODO: Configure snippets; Add support for Go; Add support for Terraform
set completeopt=menuone,noinsert,noselect
let g:completetion_matching_strategy_list = [ 'exact', 'substring', 'fuzzy' ]
lua require('lspinstaller')
lua require('cmpconf')
" Vimwiki and Taskwarrior
" TODO: Figure out why diary doesn't work and why not all keybundings works.
let g:vimwiki_list = [{'path':'$HOME/vimwiki', 'syntax':'markdown', 'ext': '.md'}]
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown':'markdown'}
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_markup_syntax = 'markdown'
let g:vimwiki_markdown_folding = 1
let g:vimwiki_diary_months = {
      \ 1: 'January', 2: 'February', 3: 'March',
      \ 4: 'April', 5: 'May', 6: 'June',
      \ 7: 'July', 8: 'August', 9: 'September',
      \ 10: 'October', 11: 'November', 12: 'December'
      \ }
