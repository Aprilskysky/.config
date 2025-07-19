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

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- map("n", "<leader>n", ":set relativenumber!<CR>", { noremap = true, silent = true })
map("v", "J", ":move '>+1<CR>gv-gv", { noremap = true, silent = true })
map("v", "K", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
map("n", "n", "nzz", { noremap = true, silent = true })
map("n", "N", "Nzz", { noremap = true, silent = true })
map("n", "<C-n>", "<cmd>bn<cr>", { noremap = true, silent = true })
map("n", "<C-p>", "<cmd>bp<cr>", { noremap = true, silent = true })
map("n", "<leader>l", ":Lazy<CR>", { noremap = true, silent = true })

map("n", "<leader>cl", "<cmd>LspInfo<cr>", { noremap = true, silent = true })
-- show diagnostics for line
map("n", "<leader>d", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show line diagnostics" })

map("n", "<leader>ch", "<cmd>TSBufToggle highlight<cr>", { noremap = true, silent = true })
map("n", "<leader>cH", "<cmd>TSToggle highlight<cr>", { noremap = true, silent = true })
map("n", "<leader>ct", function()
  if vim.bo.syntax == "systemverilog" then
    vim.bo.syntax = "verilog_systemverilog"
  elseif vim.bo.syntax == "verilog_systemverilog" then
    vim.bo.syntax = "systemverilog"
  end
end, { noremap = true, silent = true, desc = "verilog_systemverilog and sv Toggle" })

map({ "i", "s" }, "<Tab>", function()
  if vim.snippet.active({ direction = 1 }) then
    return "<Tab>"
  else
    return "<Tab>"
  end
end, { desc = "...", expr = true, silent = true })
