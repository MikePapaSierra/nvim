" My ESC key is jamming from time to time so here's workaround
inoremap jj <Esc>
inoremap <C-c> <Esc>
" Buffers
" Navigate between buffers
nmap bn :bnext<CR>
nmap bp :bprevious<CR>
" TODO: Add option to close buffer
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
" Open new tab
nmap te :tabedit
" Navigate between tabs
nmap tn :tabnext<Return>
nmap tp :tabprev<Return>
" TODO: Add option to close tab
" Mapping to run LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>
" Mapping for Floaterm
nnoremap  <C-t> :FloatermToggle<CR>
tnoremap <C-t> <C-\><C-n>:FloatermToggle<CR>
" Mapping for nnn
tnoremap <C-A-n> <cmd>NnnExplorer<CR>
nnoremap <C-A-n> <cmd>NnnExplorer %:p:h<CR>
tnoremap <C-A-p> <cmd>NnnPicker<CR>
nnoremap <C-A-p> <cmd>NnnPicker<CR>
