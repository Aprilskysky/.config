return {
	"andymass/vim-matchup",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
		vim.cmd([[let g:matchup_matchparen_pumvisible = 0]]) -- for cmp conflict
	end,
}
