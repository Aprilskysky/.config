return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = "VeryLazy",
	config = function()
		local status, treesitter = pcall(require, "nvim-treesitter.configs")
		if not status then
			vim.notify("not found nvim-treesitter")
			return
		end

		treesitter.setup({
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
				"verilog",
			},
			-- enable highlight
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = {
					"verilog",
					"systemverilog",
				},
			},
			indent = {
				enable = true,
			},
		})
	end,
}
