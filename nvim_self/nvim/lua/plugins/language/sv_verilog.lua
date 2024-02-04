return {
	{
		"vhda/verilog_systemverilog.vim",
		-- lazy = false,
		init = function()
			-- set smartindent for verilog_systemverilog
			vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
				group = vim.api.nvim_create_augroup("verilog_systemverilog_cfg", { clear = true }),
				pattern = { "*.sv", "*.v", "*.svh" },
				callback = function()
					vim.bo.smartindent = false
				end,
			})
		end,
	},

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
