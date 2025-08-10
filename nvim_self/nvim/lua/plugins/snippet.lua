_G.my_snippets_path = vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath("config"), "/snippets"))
return {
  {
    "chrisgrieser/nvim-scissors",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    opts = { snippetDir = my_snippets_path },
    keys = {
      {
        "<leader>se",
        function()
          require("scissors").editSnippet()
        end,
        mode = "n",
        desc = "Snippet: Edit",
      },
      {
        "<leader>sa",
        function()
          require("scissors").addNewSnippet()
        end,
        mode = { "n", "x" },
        desc = "Snippet: Add",
      },
    },
  },
}
