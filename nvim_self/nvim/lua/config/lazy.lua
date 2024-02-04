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

-- Configure lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins.editor" },
		{ import = "plugins.language.treesitter" },
		{ import = "plugins.language.lsp" },
		{ import = "plugins.language.lua" },
		{ import = "plugins.language.sv_verilog" },
	},
	defaults = {
		lazy = true,
		version = nil,
	},
	install = { missing = true, colorscheme = { "gruvbox", "tokyonight", "catppuccin" } },
	checker = {
		enabled = true,
		notify = false,
	},
})
