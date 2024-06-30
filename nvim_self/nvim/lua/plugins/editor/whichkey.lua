return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		-- cmd = "WhichKey",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
				["<leader>s"] = { name = "+search" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>r"] = { name = "+re/" },
				["<leader>c"] = { name = "+code" },
				["<leader>h"] = { name = "+harpoon" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
}
