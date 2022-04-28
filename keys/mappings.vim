" My ESC key is jamming from time to time so here's workaround
inoremap jj <Esc>
inoremap <C-c> <Esc>
" Buffers
" Navigate between buffers
nmap bn :bnext<CR>
nmap bp :bprevious<CR>
nmap bd :bdelete<CR>
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
"nnoremap <F7> :set spell! <CR>
"inoremap <F7> <C-o> :set spell! <CR>
" Moving between windows
nmap sh <C-w>h
nmap sk <C-w>k
nmap sj <C-w>j
nmap sl <C-w>l
" Mapping to run LazyGit
nnoremap <silent> <leader>gg :LazyGit<CR>
" Mapping for Floaterm
nnoremap  <C-A-t> :FloatermToggle<CR>
tnoremap <C-A-t> <C-\><C-n>:FloatermToggle<CR>
" Mapping for NerdTree
nnoremap <silent> <C-A-n> :NERDTreeToggle<CR>
" Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
" Deoplate
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" Common Go commands
"au FileType go nmap <leader>r <Plug>(go-run)
"au FileType go nmap <leader>b <Plug>(go-build)
"au FileType go nmap <leader>t <Plug>(go-test)
"au FileType go nmap <leader>c <Plug>(go-coverage-toggle)
"au FileType go nmap <Leader>e <Plug>(go-rename)
"au FileType go nmap <Leader>s <Plug>(go-implements)
"au FileType go nmap <Leader>i <Plug>(go-info)
" Go navigation commands
"au FileType go nmap <Leader>ds <Plug>(go-def-split)
"au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
" Alternate commands
"au FileType go nmap <Leader>ae <Plug>(go-alternate-edit)
"au FileType go nmap <Leader>av <Plug>(go-alternate-vertical)
