local opt = vim.opt
-- utf8
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
-- set number
opt.number = true
opt.relativenumber = true
-- set tab
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
-- set clipboard
opt.clipboard = "unnamedplus"
-- set mouse
opt.mouse = "a"
-- keep 5 lines when moving
opt.scrolloff = 5
opt.sidescrolloff = 5
-- highlight line and column
opt.cursorline = true
opt.cursorcolumn = false
-- Displays the left icon indicator column
opt.signcolumn = "yes"
-- set indent
opt.autoindent = true
opt.smartindent = true
-- set search
opt.incsearch = true -- search as characters are entered
opt.hlsearch = true -- highlight matchs
opt.ignorecase = true -- ignore case in searches by default
opt.smartcase = true -- but make it case sensitive if an uppercase is entered
-- set cmd height
opt.cmdheight = 0 -- The command line height is 2 to provide sufficient display space
-- line folding
opt.wrap = true
-- Allows modified buffers to be hidden
opt.hidden = true
-- nobackup
opt.backup = false
opt.writebackup = false
opt.swapfile = false
-- set time
opt.updatetime = 300
opt.timeoutlen = 500 -- Wait for keyboard shortcut combo time
-- A split window appears from the bottom and right
opt.splitbelow = true
opt.splitright = true
-- Auto complete is not selected automatically
opt.completeopt = "menu,menuone,noselect,noinsert"
-- style
opt.background = "dark"
opt.termguicolors = true
-- Display of invisible characters
opt.list = false
-- Complete enhancement
opt.wildmenu = true
-- show tabline forever
opt.showtabline = 2
-- opt.tabstop = 2 -- Number of spaces tabs count for
-- don't show vim mode
opt.showmode = false
-- When the file is modified by an external program, it is automatically loaded
opt.autoread = true
vim.bo.autoread = true
-- highligt when copy
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 100,
		})
	end,
})
-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.list = true -- Show some invisible characters (tabs...
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.wildmode = "longest:full,full" -- Command-line completion mode

vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
