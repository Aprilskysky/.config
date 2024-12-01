return {
	{
		"echasnovski/mini.files",
		opts = {
			windows = {
				preview = true,
				width_nofocus = 20,
				width_preview = 60,
			},
			options = {
				use_as_default_explorer = true,
			},
		},
		keys = {
			{
				"<leader>fE",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
				end,
				desc = "Explorer (Current File)",
			},
			{
				"<leader>fe",
				function()
					require("mini.files").open(vim.loop.cwd(), true)
				end,
				desc = "Explorer (Current Directory)",
			},
		},
		config = function(_, opts)
			require("mini.files").setup(opts)
		end,
	},

	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>bd",
				function()
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice =
							vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
}
