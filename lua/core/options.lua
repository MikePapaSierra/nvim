-- Consider - as a part of the kayword
vim.o.iskeyword = vim.o.iskeyword .. ",-"

-- Line wrapping
vim.o.wrap = false

-- Encoding
vim.o.encoding = "utf-8"
vim.scriptencoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.pumheight = 10
--
-- Clipboard
vim.o.clipboard = "unnamedplus"

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

-- Tab and indentation
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

-- Split windows
vim.o.splitright = true
vim.o.splitbelow = true

-- Apperance
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.diagnostic.config({
    float = { boarder = "rounded" },
})
vim.o.title = true
vim.o.scrolloff = 10
vim.o.updatetime = 300

-- Mouse
vim.o.mouse = "a"

-- Netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Configure white characters that will be shown
vim.opt.listchars = "space:.,tab:> ,trail:-,eol:↴"
vim.opt.list = true

-- Obsidian plugin required settings
vim.opt.conceallevel = 1
