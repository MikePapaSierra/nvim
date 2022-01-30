# nvim-config

Neovim configuration files.

Below is example screenshot of neovim configuration:
![Neovim configuration screenshot](/images/neovim-config-screenshot.png)

## Keybindings

 - <kbd>j</kbd><kbd>j</kbd> - mapped to work as <kbd>Esc</kbd>
 - <kbd>Ctrl</kbd> + <kbd>c</kbd> - mapped to work as <kbd>Esc</kbd>
 - 2x <kbd>Ctrl</kbd> + <kbd>n</kbd> - toggle line numering
 - 2x <kbd>Ctrl</kbd> + <kbd>r</kbd> - toggle line numering between absolute and
   hibrid
 - <kbd>F5</kbd> - toggle showing white spaces
 - <kbd>F6</kbd> - toggle between paste no-paste
 - <kbd>F7</kbd> - toggle spell checking
 - <kbd>ss</kbd> - split window horizontally
 - <kbd>sv</kbd> - split window vertically
 - <kbd>sh</kbd> - move to the left window
 - <kbd>sj</kbd> - move to the upper window
 - <kbd>sk</kbd> - move to the lower window
 - <kbd>sl</kbd> - move to the right window
 - <kbd>te</kbd> - create new tab

### Plugin key bindings

#### Floaterm

- <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>t</kbd> - toggle floating terminal (if not opne it
  will create new instance of the terminal)
- <kbd>Ctrl</kbd>+<kbd>\</kbd><kbd>Ctrl</kbd>+<kbd>n</kbd> - enable
  navigation/normal mode in floating terminal
- <kbd>Ctrl</kbd>+<kbd>u</kbd> - move up in the normal mode
- <kbd>Ctrl</kbd>+<kbd>d</kbd> - move down in the normal mode

#### Fzf

- <kbd>Leader</kbd>+<kbd>f</kbd> - Fuzzy find over files
- <kbd>Leader</kbd>+<kbd>b</kbd> - Fuzzy find over buffers
- <kbd>Leader</kbd>+<kbd>r</kbd> - Fuzzy find using ripgrep
- <kbd>Leader</kbd>+<kbd>t</kbd> - Fuzzy find over tags
- <kbd>Leader</kbd>+<kbd>m</kbd> - Fuzzy find over marks
- <kbd>Leader</kbd>+<kbd>g</kbd> - Fuzzy find over commits

## Plugins

Here's list of all plugins used in the configuration:

- [Fzf](https://github.com/junegunn/fzf.vim)
- [colorizer.lua](https://github.com/norcalli/nvim-colorizer.lua)
- [Much simpler Rainbow Parentheses](https://github.com/junegunn/rainbow_parentheses.vim)
- [Foreword](https://github.com/ParamagicDev/vim-medic_chalk)
- [Janah](https://github.com/mhinz/vim-janah)
- [lightline.vim](https://github.com/itchyny/lightline.vim)
- [sneak.vim](https://github.com/justinmk/vim-sneak)
- [VimDevIcons](https://github.com/ryanoasis/vim-devicons)
- [Startify](https://github.com/mhinz/vim-startify)
- [Signify](https://github.com/mhinz/vim-signify)
- [fugitive.vim](https://github.com/tpope/vim-fugitive)
- [rhubarb.vim](https://github.com/tpope/vim-rhubarb)
- [Conquer of Completion](https://github.com/neoclide/coc.nvim)
- [Terraform](https://github.com/hashivim/vim-terraform)
- [vim-you-autocorrect](https://github.com/sedm0784/vim-you-autocorrect)

Big kudos for authors of that plugins.

## Inspiration

My main inspiration to create this configuration was stream one of the AWS developer advocate [Darko Mesaros](https://github.com/darko-mesaros).
Recording from that session can be find [here](https://www.youtube.com/watch?v=kPnYFsXml-I).

## License

This code is distributed on [MIT License](/LICENSE).
