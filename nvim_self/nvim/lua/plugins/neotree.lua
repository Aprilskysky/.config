return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		-- enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		-- keys = {
		-- 	{
		-- 		"<leader>e",
		-- 		function()
		-- 			require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
		-- 		end,
		-- 		desc = "Explorer NeoTree (root)",
		-- 	},
		-- 	{
		-- 		"<leader>E",
		-- 		function()
		-- 			require("neo-tree.command").execute({
		-- 				toggle = true,
		-- 				dir = vim.api.nvim_buf_get_name(0):match("(.*/)"),
		-- 			})
		-- 		end,
		-- 		desc = "Explorer NeoTree (current)",
		-- 	},
		-- 	{
		-- 		"<leader>be",
		-- 		function()
		-- 			require("neo-tree.command").execute({ source = "buffers", toggle = true })
		-- 		end,
		-- 		desc = "Buffer Explorer",
		-- 	},
		-- },
		init = function()
			-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
			-- because `cwd` is not set up properly.
			vim.api.nvim_create_autocmd("BufEnter", {
				group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
				desc = "Start Neo-tree with directory",
				once = true,
				callback = function()
					if package.loaded["neo-tree"] then
						return
					else
						local stats = vim.uv.fs_stat(vim.fn.argv(0))
						if stats and stats.type == "directory" then
							require("neo-tree")
						end
					end
				end,
			})
		end,
		opts = {
			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
			sources = { "filesystem", "buffers", "git_status" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				-- bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				position = "left",
				width = 35,
			},
			default_component_configs = {
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				indent = {
					with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						unstaged = "󰄱",
						staged = "󰱒",
					},
				},
			},
		},
		config = function(_, opts)
			require("neo-tree").setup(opts)
			-- auto close
			vim.api.nvim_create_autocmd("QuitPre", {
				callback = function()
					local tree_wins = {}
					local floating_wins = {}
					local wins = vim.api.nvim_list_wins()
					for _, w in ipairs(wins) do
						local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
						if bufname:match("Neo-tree") ~= nil then
							table.insert(tree_wins, w)
						end
						if vim.api.nvim_win_get_config(w).relative ~= "" then
							table.insert(floating_wins, w)
						end
					end
					if 1 == #wins - #floating_wins - #tree_wins then
						-- Should quit, so we close all invalid windows.
						for _, w in ipairs(tree_wins) do
							vim.api.nvim_win_close(w, true)
						end
					end
				end,
			})
		end,
	},
}
