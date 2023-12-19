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

vim.cmd([[
  augroup _usr_last_place
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup end
]])
