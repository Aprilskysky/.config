local icons = require("config.icons")
return {
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
			"BufWritePost",
			"TextChanged",
			"InsertLeave",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				systemverilog = { "verilator" },
				verilog = { "verilator" },
			}

			local signs = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.BoldWarning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.BoldHint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.BoldInformation },
			}
			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
			end

			-- local verilator = lint.linters.verilator
			-- verilator.args = {
			-- 	"-sv",
			-- 	"-Wall",
			-- 	"--bbox-sys",
			-- 	"--bbox-unsup",
			-- 	"--lint-only",
			-- 	"-f",
			-- 	vim.fs.find("verilator.f", { upward = true, stop = vim.env.HOME })[1],
			-- }

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
				callback = function()
					vim.defer_fn(function()
						-- try_lint() will run every linter configured with linters_by_ft().
						-- See lua\setup_systemverilog.lua
						lint.try_lint()
					end, 1)
				end,
			})
		end,
	},
}
