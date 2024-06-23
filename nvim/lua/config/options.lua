-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- nobackup
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.wrap = true

-- GUI
vim.o.guifont = "FiraCode Nerd Font Mono:h12"
if vim.g.neovide then
  vim.g.neovide_refresh_rate = 60
end
