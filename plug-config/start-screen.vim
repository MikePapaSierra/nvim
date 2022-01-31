let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']                        },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]

let g:startify_bookmarks = [
          \ { 'v': '~/.config/nvim/init.vim' },
          \ { 'f': '~/.config/fish/config.fish' },
          \ ]

let g:startify_fortune_use_unicode = 1
nmap <c-n> :Startify<cr>
