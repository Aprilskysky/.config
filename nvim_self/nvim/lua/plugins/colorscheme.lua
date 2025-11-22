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
    priority = 1000,
    opts = {
      highlight_overrides = {
        mocha = function(mocha)
          return {
            CursorLineNr = { fg = mocha.yellow },
            TelescopeSelection = { bg = mocha.surface0 },
            TelescopeSelectionCaret = { fg = mocha.yellow, bg = mocha.surface0 },
            TelescopePromptPrefix = { fg = mocha.yellow },
            FlashCurrent = { bg = mocha.peach, fg = mocha.base },
            FlashMatch = { bg = mocha.red, fg = mocha.base },
            FlashLabel = { bg = mocha.teal, fg = mocha.base },
            NormalFloat = { bg = mocha.base },
            FloatBorder = { bg = mocha.base },
            FloatTitle = { bg = mocha.base },
          }
        end,
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      -- vim.cmd([[colorscheme catppuccin-mocha]])
      vim.cmd.hi("Comment gui=none")
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        overrides = {
          SignColumn = { bg = "#282828" },
        },
        bold = true,
        -- italic = {
        --   strings = false,
        --   emphasis = false,
        --   comments = false,
        --   operators = false,
        --   folds = false,
        -- },
      })
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
}
