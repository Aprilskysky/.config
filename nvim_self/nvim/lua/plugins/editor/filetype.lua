return {
	{
		"nathom/filetype.nvim",
		lazy = false,
		-- event = "User FileOpened",
		config = function()
			require("filetype").setup({
				overrides = {
					extensions = {
						-- Set the filetype of *.pn files to potion
						pl = "perl",
						list = "list",
						sv = "verilog_systemverilog",
						v = "verilog_systemverilog",
						svh = "verilog_systemverilog",
					},
					literal = {
						-- Set the filetype of files named "MyBackupFile" to lua
						-- MyBackupFile = "lua",
					},
					complex = {
						-- Set the filetype of any full filename matching the regex to gitconfig
						[".bashrc"] = "bash", -- Included in the plugin
						[".cshrc"] = "csh",
						[".cshrc.user"] = "csh",
						[".tmux.conf"] = "tmux",
						["tmux.conf"] = "tmux",
					},
				},
			})
		end,
	},

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
