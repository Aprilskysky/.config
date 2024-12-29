return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      local tokyonight = require("tokyonight")
      tokyonight.setup(opts)
      -- vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    config = function()
      -- vim.cmd([[colorscheme catppuccin]])
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    -- init = function()
    --   vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    --   vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    --   vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    --   vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    --   vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    --   vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    --   vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    -- end,
    config = function()
      require("gruvbox").setup({
        overrides = {
          SignColumn = { bg = "#282828" },
        },
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = false,
          operators = false,
          folds = false,
        },
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
