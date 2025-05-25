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
  -- {
  -- "ahmedkhalf/project.nvim",
  -- -- event = "VeryLazy",
  -- config = function()
  --   -- vim.g.nvim_tree_respect_buf_cwd = 1
  --   require("project_nvim").setup({
  --     detection_methods = { "lsp", "pattern" },
  --     patterns = {
  --       ".git",
  --       "_darcs",
  --       ".hg",
  --       ".bzr",
  --       ".svn",
  --       ".root",
  --       -- "Makefile",
  --       "package.json",
  --       ">IPCRV",
  --       ">check_flow",
  --     },
  --   })
  --   require("telescope").load_extension("projects")
  -- end,
  -- }
}
