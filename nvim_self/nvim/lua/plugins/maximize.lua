return {
  {
    "declancm/maximize.nvim",
    config = true,
    keys = {
      {
        "<leader>zt",
        function()
          require("maximize").toggle()
        end,
        desc = "window maximize toggle",
      },
      {
        "<leader>zm",
        function()
          require("maximize").maximize()
        end,
        desc = "window maximize",
      },
      {
        "<leader>zr",
        function()
          require("maximize").restore()
        end,
        desc = "window restore",
      },
    },
  },
}
