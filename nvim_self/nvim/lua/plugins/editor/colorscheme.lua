return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = false,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function(_, opts)
			local tokyonight = require("tokyonight")
			tokyonight.setup(opts)
			-- vim.cmd([[colorscheme tokyonight]])
		end,
	},

	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		config = function()
			-- vim.cmd([[colorscheme catppuccin]])
		end,
	},

	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				overrides = {
					SignColumn = { bg = "#282828" },
				},
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
			})
			vim.cmd([[colorscheme gruvbox]])
		end,
	},

	{
		"luisiacc/gruvbox-baby",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_baby_comment_style = "NONE"
			vim.g.gruvbox_baby_keyword_style = "NONE"
			-- Enable telescope theme
			vim.g.gruvbox_baby_telescope_theme = 1
			-- vim.cmd([[colorscheme gruvbox-baby]])
		end,
	},
}
