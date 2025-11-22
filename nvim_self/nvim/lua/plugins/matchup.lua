return {
  "andymass/vim-matchup",
  event = { "BufReadPost", "BufNewFile" },
  init = function()
    vim.cmd([[
      let g:matchup_matchparen_offscreen = {'method': 'popup'}
      let g:matchup_matchparen_nomode = "i" " for cmp conflict
    ]])
  end,
}
