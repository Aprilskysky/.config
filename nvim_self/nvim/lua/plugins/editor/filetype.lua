return {
	{
		"vhda/verilog_systemverilog.vim",
		lazy = false,
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
}
