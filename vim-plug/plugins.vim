" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " FZF
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kyazdani42/nvim-web-devicons'

    " Floaterm
    Plug 'voldikss/vim-floaterm'

    " vim tmux navigator
    "Plug 'christoomey/vim-tmux-navigator'

    " Nnn file manager support
    Plug 'luukvbaal/nnn.nvim'

    " numbertoggle
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    
    "Add airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Add some color
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'junegunn/rainbow_parentheses.vim'
    
    " Add some themes
    Plug 'tomasiser/vim-code-dark'

    " sneak
    Plug 'justinmk/vim-sneak'

    " devicons
    Plug 'ryanoasis/vim-devicons'

    " Telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    " startify
    Plug 'mhinz/vim-startify'
    
    " Git related plugins
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'kdheepak/lazygit.nvim'

    " Python completion plugin
    Plug 'davidhalter/jedi-vim'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-jedi'

    " coc
    "Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }

    " terraform
    Plug 'hashivim/vim-terraform'
    Plug 'vim-syntastic/syntastic'
    Plug 'juliosueiras/vim-terraform-completion'

    " go
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " Spell checking
    Plug 'sedm0784/vim-you-autocorrect'

call plug#end()

" nnn
lua require('nnncfg') 
" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
