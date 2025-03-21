-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key (this must be done before initializing lazy)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Initialize Lazy with dynamic loading of anything in plugins directory
require("lazy").setup("plugins", {
	change_detection = {
		enabled = true, -- automatically chack for config file changes and reload ui
		notify = false, -- turn off notifications whenever plugin config was changed
	},
})

-- Modules not loaded by Lazy
require("core.options")
require("core.keymaps")
