return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "verilog" })
			end
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "verible", "svlangserver" })
			else
				print("mason ensure_installed is not a table")
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				svlangserver = {},
				verible = {},
			},
		},
	},
}
