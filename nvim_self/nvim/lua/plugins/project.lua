return {
  {
    "airblade/vim-rooter",
    event = "VeryLazy",
    config = function()
      vim.cmd([[
        let g:rooter_patterns += [".root"]
        let g:rooter_patterns += [">IPCRV"]
        let g:rooter_patterns += [">check_flow"]
      ]])
    end,
  },
}
