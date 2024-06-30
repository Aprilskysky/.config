return {
  { "echasnovski/mini.comment", enabled = false },

  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    config = function()
      require("Comment").setup()
      local ft = require("Comment.ft")
      ft.systemverilog = { "//%s", "/*%s*/" }
      ft.verilog = { "//%s", "/*%s*/" }
      ft.list = { "//%s" }
    end,
  },
}
