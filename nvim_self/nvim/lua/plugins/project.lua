return {
  "ahmedkhalf/project.nvim",
  event = "VeryLazy",
  config = function()
    -- vim.g.nvim_tree_respect_buf_cwd = 1
    require("project_nvim").setup({
      detection_methods = { "lsp", "pattern" },
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        ".root",
        -- "Makefile",
        "package.json",
        ">IPCRV",
        ">check_flow",
      },
    })
    require("telescope").load_extension("projects")
  end,
}
