return {
	{
		"numToStr/Comment.nvim",
		enent = "VeryLazy",
		keys = {
			{ "gc", mode = { "n", "v" }, desc = "comment" },
			{ "gcc", mode = { "n", "v" }, desc = "line comment toggle" },
			{ "gb", mode = { "n", "v" }, desc = "block comment" },
		},
		config = function()
			require("Comment").setup()
			local ft = require("Comment.ft")
			ft.systemverilog = { "//%s", "/*%s*/" }
			ft.verilog = { "//%s", "/*%s*/" }
			ft.verilog_systemverilog = { "//%s", "/*%s*/" }
			ft.list = { "//%s" }
		end,
	},
}
