local icons = require("config.icons")
local lsp_utils = require("plugins.language.lsp.utils.utils")
local keymaps = require("plugins.language.lsp.utils.keymaps")

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			-- { "j-hui/fidget.nvim", config = true },
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			servers = {},
			format = {
				timeout_ms = 3000,
			},
			setup = {},
		},
		config = function(plugin, opts)
			local signs = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.BoldWarning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.BoldHint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.BoldInformation },
			}
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
			end

			lsp_utils.on_attach(function(client, bufnr)
				keymaps.on_attach(client, bufnr)
			end)

			local servers = opts.servers
			local capabilities = lsp_utils.capabilities()
			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = capabilities,
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			-- get all the servers that are available thourgh mason-lspconfig
			local has_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if has_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			local ensure_installed = {}
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
						setup(server)
					else
						setup(server)
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if has_mason then
				mlsp.setup({ ensure_installed = ensure_installed })
				mlsp.setup_handlers({ setup })
			end
		end,
	},
}
