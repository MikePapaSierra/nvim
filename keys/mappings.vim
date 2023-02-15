" My ESC key is jamming from time to time so here's workaround
inoremap qq <Esc>
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
nmap <F2> :set invlist<CR>
imap <F2> <ESC>:set invlist<CR>
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
" Mapping for nvim-tree
nnoremap <silent> <C-A-n> :NvimTreeToggle<CR>
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
" Barbar configuration
" Move to previous/next
nnoremap <A-,> :BufferPrevious<CR>
nnoremap <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <C-A-,> :BufferMovePrevious<CR>
nnoremap <C-A-.> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <A-1> :BufferGoto 1<CR>
nnoremap <A-2> :BufferGoto 2<CR>
nnoremap <A-3> :BufferGoto 3<CR>
nnoremap <A-4> :BufferGoto 4<CR>
nnoremap <A-5> :BufferGoto 5<CR>
nnoremap <A-6> :BufferGoto 6<CR>
nnoremap <A-7> :BufferGoto 7<CR>
nnoremap <A-8> :BufferGoto 8<CR>
nnoremap <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <A-p> :BufferPin<CR>
" Close buffer
nnoremap <A-c> :BufferClose<CR>
" Sort automatically by...
nnoremap <silent> <leader>bb :BufferOrderByBufferNumber<CR>
nnoremap <silent> <leader>bd :BufferOrderByDirectory<CR>
nnoremap <silent> <leader>bl :BufferOrderByLanguage<CR>
nnoremap <silent> <leader>bw :BufferOrderByWindowNumber<CR>
" End BarBar configuration

" VimWiki
" Default keybindings for diary (<leader>w<leader>w) wasn't working
" Open diary index
nmap <leader>di <Plug>VimwikiDiaryIndex
" Open today diar
nmap <leader>dn <Plug>VimwikiMakeDiaryNote
nmap <leader>db <Plug>VimwikiTabMakeDiaryNote
" Open tomorrow diary
nmap <leader>dt <Plug>VimwikiMakeTomorrowDiaryNote
" Opent yesterday diary
nmap <leader>dy <Plug>VimwikiMakeYesterdayDiaryNote
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

" markdown-preview
nmap <C-m> <Plug>MarkdownPreviewToggle
