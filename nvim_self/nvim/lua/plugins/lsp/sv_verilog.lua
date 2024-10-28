return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "verilog" })
			else
				print("treesitter ensure_installed is not a table in sv")
			end
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				-- vim.list_extend(opts.ensure_installed, { "svlangserver", "verible", "svls" })
				-- vim.list_extend(opts.ensure_installed, { "verible" })
			else
				print("mason ensure_installed is not a table in sv")
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				veridian = {
					cmd = { "/home/wxl/.config/nvim_self//share/nvim/mason/bin/veridian" },
				},
			},
		},
	},
}
