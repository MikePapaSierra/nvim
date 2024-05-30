-- Assign lader key to a space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.iskeyword = vim.o.iskeyword .. ",-"

vim.cmd('syntax enable') -- Setting is required by Vimwiki

vim.o.wrap = false
vim.o.encoding = 'utf-8'
vim.scriptencoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.pumheight = 10
vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.title = true

vim.o.smarttab = true
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.cursorline = true
vim.o.laststatus = 2
vim.o.breakindent = true

-- vim.o.noflodenable = true
vim.o.scrolloff = 10

vim.o.updatetime = 300
vim.o.termguicolors = true

vim.o.mouse = 'a'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Configure white characters that will be shown
vim.opt.listchars = "space:.,tab:> ,trail:-,eol:↴"
vim.opt.list = true

-- Vimwiki required settings
vim.g.nocompatible = true
vim.cmd("filetype plugin on")

-- Obsidian plugin required settings
vim.opt.conceallevel = 1
