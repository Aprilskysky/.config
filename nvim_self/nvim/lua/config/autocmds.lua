local function augroup(name)
	return vim.api.nvim_create_augroup("_usr_" .. name, { clear = true })
end

-- highligt when copy
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim.cmd([[
--   augroup _usr_last_place
--     autocmd!
--     autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
--   augroup end
-- ]])
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	group = augroup("last_place"),
	callback = function()
		local pos = vim.fn.getpos("'\"")
		if pos[2] > 0 and pos[2] <= vim.fn.line("$") then
			vim.api.nvim_win_set_cursor(0, { pos[2], pos[3] - 1 })
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})
