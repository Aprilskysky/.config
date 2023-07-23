local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    require("plugin_cfg.colorscheme"),
    require("plugin_cfg.telescope"),
    require("plugin_cfg.lspconfig"),
    require("plugin_cfg.mason"),
    require("plugin_cfg.nvim_tree"),
    require("plugin_cfg.bufferline"),
    require("plugin_cfg.lualine"),
    require("plugin_cfg.dashboard"),
    require("plugin_cfg.project"),
    require("plugin_cfg.autopairs"),
    require("plugin_cfg.treesitter"),
    require("plugin_cfg.comment"),
})
