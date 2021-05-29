" General configuration
source $HOME/.config/nvim/general/settings.vim
" Filetype configuration
source $HOME/.config/nvim/general/filetypes.vim
" Keybindings
source $HOME/.config/nvim/keys/mappings.vim
" Plugin installation
source $HOME/.config/nvim/vim-plug/plugins.vim
" Plugins configuration
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/rainbow.vim
source $HOME/.config/nvim/plug-config/start-screen.vim
" Colorization
lua require'plug-colorizer'
" colorscheme medic_chalk
colorscheme janah
