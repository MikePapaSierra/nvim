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

- <kbd>Leader</kbd>+<kbd>f</kbd> - fuzzy find over files
- <kbd>Leader</kbd>+<kbd>b</kbd> - fuzzy find over buffers
- <kbd>Leader</kbd>+<kbd>r</kbd> - fuzzy find using ripgrep
- <kbd>Leader</kbd>+<kbd>t</kbd> - fuzzy find over tags
- <kbd>Leader</kbd>+<kbd>m</kbd> - fuzzy find over marks
- <kbd>Leader</kbd>+<kbd>g</kbd> - fuzzy find over commits

- <kbd>Ctr</kbd>+<kbd>t</kbd> - open file in new tab
- <kbd>Ctr</kbd>+<kbd>v</kbd> - open file in verical split
- <kbd>Ctr</kbd>+<kbd>x</kbd> - open file in horizontal split

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

Recently I went thru some resources in the web that are describing NeoVim configuration in Lua language:
- https://www.youtube.com/watch?v=6mxWayq-s9I
- https://www.youtube.com/watch?v=NL8D8EkphUw
- https://www.youtube.com/watch?v=aeQn9MRTjxc
- https://www.youtube.com/watch?v=RziPWdTzSV8
- https://www.youtube.com/watch?v=GYVbYCST_Yc
- https://www.youtube.com/watch?v=7k0KZsheLP4
- https://www.youtube.com/watch?v=5HXINnalrAQ
- https://www.youtube.com/watch?v=FuYQ7M73bC0
- https://www.youtube.com/watch?v=Co7gcSvq6jA

## License

This code is distributed on [MIT License](/LICENSE).
