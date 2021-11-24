" My ESC key is jamming from time to time so here's workaround
inoremap jj <Esc>
inoremap <C-c> <Esc>
" TAB in general mode will move to text buffer
"nnoremap <TAB> :bnext<CR>
" SHIFT-TAB will go back
"nnoremap <S-TAB> :bprevious<CR>
" Show/hide line numbers
nnoremap <C-N><C-N> :set invnu<CR>
" Toggle relative numbers
nnoremap <C-R><C-R> :set invrnu<CR>
" Show/hide blank characters
noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>
" Toggle no-paste
nnoremap <F6> :set invpaste paste?<CR>
" Enable spell checking
nnoremap <F7> :set spell! <CR>
inoremap <F7> <C-o> :set spell! <CR>
" Split window
nmap ss :split<Return><C-w>w
nmap sv :split<Return><C-w>w
" Moving between windows
nmap sh <C-w>h
nmap sk <C-w>k
nmap sj <C-w>j
nmap sl <C-w>l
" Tabs
nmap  te :tabedit
" Moving between tabs
nmap <S-Tab> :tabprev<Return>
nmap <Tab> :tabnext<Return>
" Mapping to run LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>
" Mapping for Floaterm
nnoremap  <C-t> :FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>
