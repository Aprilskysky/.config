return {
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    keys = {
      { "gc",  mode = { "n", "x" }, desc = "comment" },
      { "gcc", mode = { "n", "x" }, desc = "line comment toggle" },
      { "gb",  mode = { "n", "x" }, desc = "block comment" },
    },
    config = function()
      require("Comment").setup({
        pre_hook = function(ctx)
          local disabled_fts = {
            "tmux",
          }
          if vim.tbl_contains(disabled_fts, vim.bo.filetype) then
            return false
          end
        end,
        ft = {
          systemverilog = { "//%s", "/*%s*/" },
          verilog = { "//%s", "/*%s*/" },
          verilog_systemverilog = { "//%s", "/*%s*/" },
          list = { "//%s" },
        },
      })
    end,
  },
}
