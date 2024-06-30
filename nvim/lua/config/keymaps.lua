-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opt = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<C-f>", "<Nop>", opt)
vim.api.nvim_set_keymap("n", "<C-b>", "<Nop>", opt)
