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
opt.updatetime = 200
opt.timeoutlen = 500 -- Wait for keyboard shortcut combo time
-- A split window appears from the bottom and right
opt.splitbelow = true
opt.splitright = true
-- Auto complete is not selected automatically
opt.completeopt = "menu,menuone,noselect,noinsert"
-- style
opt.background = "dark"
opt.termguicolors = true
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
-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.list = true -- Show some invisible characters (tabs...
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.spelllang = { "en" }
opt.splitkeep = "screen"
opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.conceallevel = 0
opt.nrformats = "unsigned"

-- vim.cmd([[set shell=/bin/bash\ -i]])
vim.cmd([[set shell=/bin/bash\ -noprofile]])
vim.cmd([[
  set suffixesadd+=.sv,.v,.svh,.csh,.tcl,.pl,.py
  set path+=**
  set ttyfast
]])

-- GUI
vim.o.guifont = "FiraCode Nerd Font Mono:h12"
if vim.g.neovide then
  vim.g.neovide_refresh_rate = 60
end

-- add filetype
vim.filetype.add({
  extension = {
    list = "list",
    csh = "tcsh",
    f = "file",
    -- v = "systemverilog",
    -- sv = "systemverilog",
    -- svh = "systemverilog",
  },
  filename = {
    -- [".bashrc"] = "bash",
    -- [".cshrc"] = "tcsh",
    -- [".cshrc.user"] = "tcsh",
    -- [".tmux.conf"] = "tmux",
    -- ["tmux.conf"] = "tmux",
  },
})

local icons = require("config.icons")
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostics.BoldError,
      [vim.diagnostic.severity.WARN] = icons.diagnostics.BoldWarning,
      [vim.diagnostic.severity.INFO] = icons.diagnostics.BoldInformation,
      [vim.diagnostic.severity.HINT] = icons.diagnostics.BoldHint,
    },
    -- linehl = {
    --   [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    -- },
    -- numhl = {
    --   [vim.diagnostic.severity.WARN] = "WarningMsg",
    -- },
  },
})

if vim.env.NVIM_APP_CONFIG_TYPE then
  vim.g.config_type = vim.env.NVIM_APP_CONFIG_TYPE
else
  vim.g.config_type = "NORMAL"
end
