vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map("n", "<space>", "<nop>", { noremap = true, silent = true })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { noremap = true, silent = true, desc = "Escape and clear hlsearch" })

-- Move to window using the <ctrl> hjkl keys
-- map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
-- map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
-- map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<leader>n", ":set relativenumber!<CR>", { noremap = true, silent = true })
map("v", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })
map("v", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
map("n", "n", "nzz", { noremap = true, silent = true })
map("n", "N", "Nzz", { noremap = true, silent = true })
map("n", "<C-n>", ":bn<CR>", { noremap = true, silent = true })
map("n", "<C-p>", ":bp<CR>", { noremap = true, silent = true })
map("n", "<leader>l", ":Lazy<CR>", { noremap = true, silent = true })

map("n", "<leader>cl", ":LspInfo<CR>", { noremap = true, silent = true })
map("n", "<leader>ch", "::TSBufToggle height<CR>", { noremap = true, silent = true })
map("n", "<leader>cH", "::TSToggle height<CR>", { noremap = true, silent = true })
