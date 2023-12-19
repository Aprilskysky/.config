return {
	"numToStr/Comment.nvim",
	keys = {
		{ "gc", mode = { "n", "v" }, desc = "comment" },
		{ "gb", mode = { "n", "v" }, desc = "block comment" },
	},
	config = function()
		require("Comment").setup()
		local ft = require("Comment.ft")
		ft.systemverilog = { "//%s", "/*%s*/" }
		ft.verilog = { "//%s", "/*%s*/" }
		ft.list = { "//%s" }
	end,
}
