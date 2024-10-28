return {
	"nvim-tree/nvim-tree.lua",
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "nvimtreetoggle" },
	},
	-- enabled = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local status, nvim_tree = pcall(require, "nvim-tree")
		if not status then
			vim.notify("not found nvim-tree")
			return
		end
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			-- default mappings
			api.config.mappings.default_on_attach(bufnr)
			-- custom mappings
			vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		end
		nvim_tree.setup({
			on_attach = my_on_attach,
			-- not show git icon
			git = {
				enable = false,
			},
			-- project plugin set
			update_cwd = true,
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			-- don't show .file and node_modules folder
			filters = {
				dotfiles = true,
				custom = { "node_modules" },
			},
			view = {
				width = 35,
				side = "left",
				-- don't show line number
				number = false,
				relativenumber = false,
				-- show icon
				signcolumn = "yes",
			},
			actions = {
				open_file = {
					-- The size fit is enabled for the first time
					resize_window = true,
					-- close when open file?
					quit_on_open = false,
				},
			},
			-- wsl install -g wsl-open
			system_open = {
				cmd = "wsl-open", -- mac set open
			},
			renderer = {
				full_name = true,
				group_empty = true,
				special_files = {},
				symlink_destination = false,
				indent_markers = {
					enable = true,
				},
				icons = {
					git_placement = "signcolumn",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
				},
			},
		})
		-- auto close
		vim.api.nvim_create_autocmd("QuitPre", {
			callback = function()
				local tree_wins = {}
				local floating_wins = {}
				local wins = vim.api.nvim_list_wins()
				for _, w in ipairs(wins) do
					local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
					if bufname:match("NvimTree_") ~= nil then
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
}
