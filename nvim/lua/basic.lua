-- utf8
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
-- set number
vim.o.number = true
vim.o.relativenumber = true
-- set tab
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop =4
-- set clipboard
vim.o.clipboard = "unnamed"
-- set mouse
vim.o.mouse = 'a'
-- keep 5 lines when moving
vim.o.scrolloff = 5
vim.o.sidescrolloff = 5
-- highlight line and column
vim.o.cursorline = true
vim.o.cursorcolumn = true
-- Displays the left icon indicator column
vim.wo.signcolumn = "yes"
-- set indent
vim.o.autoindent = true
vim.o.smartindent = true
-- set search
vim.o.incsearch = true -- search as characters are entered
vim.o.hlsearch = true -- highlight matchs
vim.o.ignorecase = true -- ignore case in searches by default
vim.o.smartcase = true -- but make it case sensitive if an uppercase is entered
-- set cmd height
vim.o.cmdheight = 2 -- The command line height is 2 to provide sufficient display space
-- line folding
vim.o.wrap = true
-- Allows modified buffers to be hidden
vim.o.hidden = true
-- nobackup
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- set time
vim.o.updatetime = 300
vim.opt.timeoutlen = 400 -- Wait for keyboard shortcut combo time
-- A split window appears from the bottom and right
vim.o.splitbelow = true
vim.o.splitright = true
-- Auto complete is not selected automatically
vim.o.completeopt = "menu,menuone,noselect,noinsert"
-- style
vim.o.background = "dark"
vim.o.termguicolors = true
vim.o.termguicolors = true
-- Display of invisible characters
vim.o.list = false
vim.o.listchars = "space:·"
-- Complete enhancement
vim.o.wildmenu = true
-- show tabline forever
vim.o.showtabline = 2
-- don't show vim mode
vim.o.showmode = false
-- When the file is modified by an external program, it is automatically loaded
vim.o.autoread = true
vim.bo.autoread = true
-- highligt when copy
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = { "*" },
    callback = function()
        vim.highlight.on_yank({
            timeout = 150,
        })
    end,
})
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
