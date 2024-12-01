return {
	"m4xshen/hardtime.nvim",
	-- lazy = false,
	dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{ "<leader>ht", "<cmd>Hardtime toggle<cr>", desc = "hardtime toggle" },
	},
	config = function(_, opts)
		require("hardtime").setup(opts)
	end,
}
