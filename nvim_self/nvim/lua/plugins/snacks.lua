return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    init = function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = {
        enabled = true,
        scope = {
          enabled = true, -- enable highlighting the current scope
          underline = true,
          hl = {
            "RainbowRed",
            "RainbowOrange",
            "RainbowYellow",
            "RainbowGreen",
            "RainbowCyan",
            "RainbowBlue",
            "RainbowViolet",
          },
        },
        chunk = {
          -- enabled = true,
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
          },
        },
      },
      input = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}
