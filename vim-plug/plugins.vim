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
    Plug 'tpope/vim-fugitive'

    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'saadparwaiz1/cmp_luasnip'

    " Snippets
    Plug 'L3MON4D3/LuaSnip'
    Plug 'rafamadriz/friendly-snippets'

    " Telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'kyazdani42/nvim-web-devicons'

    " Floaterm
    Plug 'voldikss/vim-floaterm'

    " NerdTree plugin
    Plug 'scrooloose/nerdtree'

    " numbertoggle
    Plug 'jeffkreeftmeijer/vim-numbertoggle'
    
    "Add airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Add some color
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'junegunn/rainbow_parentheses.vim'
    

    " sneak
    "Plug 'justinmk/vim-sneak'

    " devicons
    Plug 'ryanoasis/vim-devicons'

    " Git related plugins
    "Plug 'mhinz/vim-signify'
    "Plug 'tpope/vim-rhubarb'
    Plug 'kdheepak/lazygit.nvim'

    " Python completion plugin
    "Plug 'davidhalter/jedi-vim'
    "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "Plug 'zchee/deoplete-jedi'

    " coc
    "Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }

    " terraform
    "Plug 'hashivim/vim-terraform'
    "Plug 'vim-syntastic/syntastic'
    "Plug 'juliosueiras/vim-terraform-completion'

    " go
    "Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " Spell checking
    "Plug 'sedm0784/vim-you-autocorrect'

    " Vimwiki and Taskwarrior
    Plug 'vimwiki/vimwiki'
    Plug 'tbabej/taskwiki'
    Plug 'plasticboy/vim-markdown'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
