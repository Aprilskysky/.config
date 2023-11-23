return {
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "nvimtreetoggle" },
		},
		-- lazy = false,
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
				-- https://github.com/4U6U57/wsl-open/
				system_open = {
					cmd = "wsl-open", -- mac set open
				},
			})
			-- auto close
			vim.cmd([[
	         autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
	       ]])
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
	   -- stylua: ignore
	   keys = {
	     { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
	     { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
	     { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
	     { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
	   },
		opts = {
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = function(...)
							require("telescope.actions").move_selection_next(...)
						end,
						["<C-k>"] = function(...)
							require("telescope.actions").move_selection_previous(...)
						end,
						["<C-n>"] = function(...)
							require("telescope.actions").cycle_history_next(...)
						end,
						["<C-p>"] = function(...)
							require("telescope.actions").cycle_history_prev(...)
						end,
					},
				},
			},
		},
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				-- always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = require("lazyvim.config").icons.diagnostics
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "left",
					},
				},
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			-- vim.api.nvim_create_autocmd("BufAdd", {
			-- 	callback = function()
			-- 		vim.schedule(function()
			-- 			pcall(nvim_bufferline)
			-- 		end)
			-- 	end,
			-- })
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local status, lualine = pcall(require, "lualine")
			if not status then
				vim.notify("not found lualine")
				return
			end

			lualine.setup({
				options = {
					-- theme = "tokyonight",
					component_separators = { left = "|", right = "|" },
					-- https://github.com/ryanoasis/powerline-extra-symbols
					section_separators = { left = " ", right = "" },
				},
				extensions = { "nvim-tree", "toggleterm" },
				sections = {
					-- +-------------------------------------------------+
					-- | A | B | C                             X | Y | Z |
					-- +-------------------------------------------------+
					lualine_c = {
						"filename",
						-- {
						--     "lsp_progress",
						--     spinner_symbols = { " ", " ", " ", " ", " ", " " },
						-- },
					},
					lualine_x = {
						"filesize",
						{
							"fileformat",
							symbols = {
								unix = "", -- e712
								dos = "", -- e70f
								mac = "", -- e711
							},
							-- symbols = {
							--     unix = "LF",
							--     dos = "CRLF",
							--     mac = "CR",
							-- },
						},
						"encoding",
						"filetype",
					},
				},
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		opts = {
			indent = {
				char = "│",
				tab_char = "¦", --"¦"
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
			},
		},
		main = "ibl",
	},

	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		opts = function()
			local logo = [[
        ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗     
        ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║     
        ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║     
        ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║     
        ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║     
        ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝     
      ]]

			logo = string.rep("\n", 8) .. logo .. "\n\n"

			local opts = {
				theme = "doom",
				hide = {
					-- this is taken care of by lualine
					-- enabling this messes up the actual laststatus setting after loading a file
					statusline = false,
				},
				config = {
					header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files",                                     desc = " Find file",       icon = " ", key = "f" },
            { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
            { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
					footer = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return {
							"⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
						}
					end,
				},
			}
			for _, button in ipairs(opts.config.center) do
				button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
				button.key_format = "  %s"
			end
			-- close Lazy and re-open when the dashboard is ready
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "DashboardLoaded",
					callback = function()
						require("lazy").show()
					end,
				})
			end
			return opts
		end,
	},

	{
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function()
			-- vim.g.nvim_tree_respect_buf_cwd = 1
			require("project_nvim").setup({
				detection_methods = { "lsp", "pattern" },
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
			})
			require("telescope").load_extension("projects")
		end,
	},

	{
		"nathom/filetype.nvim",
		lazy = false,
		-- event = "User FileOpened",
		config = function()
			require("filetype").setup({
				-- overrides = {
				-- 	extensions = {
				-- 		h = "cpp",
				-- 	},
				-- },
			})
		end,
	},

	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
		keys = {
			-- restore the session for the current directory
			vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {}),
			-- restore the last session
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ql",
				[[<cmd>lua require("persistence").load({ last = true })<cr>]],
				{}
			),
			-- stop Persistence => session won't be saved on exit
			vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {}),
		},
	},
}
