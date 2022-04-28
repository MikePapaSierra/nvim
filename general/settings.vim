map <Space> <Leader>
set iskeyword+=-            " Treat dash separated words as a word text object

syntax enable               " Enable syntax hightlighting
set nowrap                  " Do not wrap lines - display long lines as a single line
set encoding=utf-8          " Encoding displayed
set pumheight=10            " Makes popup menu smaller
set fileencoding=utf-8      " Encoding writtent to a file
set shiftwidth=2            " Tabspacing to 2 characters for indents
set smarttab                " Smart tabbing will realize you have 2 vs 4
set expandtab               " Convert tabs to spaces
set smartindent             " Enable smart indenting
set cursorline              " Enable highlighting of the cursor line
set laststatus=2            " Always display the status line
set clipboard=unnamed       " Set the clipboard to pbcopy
set lcs+=space:.            " Set the blank character to '.'
set formatoptions-=cro      " Stop newline continution of comments
set t_Co=256                " Support 256 colors
set termguicolors           " Sets terminal gui colors
set spelllang=en         " Configure spell checking " Disabling Polish spell checking due to the issue with encoding.
"Enable deoplate
let g:deoplete#enable_at_startup = 1
" This is probably depreciated
let g:deoplete#complete_method = "omnifunc"
" Enable Go in Omniplate
"call deoplete#custom#option('omni_patterns', {
"\ 'go': '[^. *\t]\.\w*',
"\})
" disable autocompletion, because we use deoplete for completion
let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"Popup window for Go Doc
let g:go_doc_popup_window = 1
"Dracula theme
let g:dracula_colorterm=0
colorscheme dracula_pro
