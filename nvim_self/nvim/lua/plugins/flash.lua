return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          jump_labels = true,
        },
      },
    },
    init = function()
      local hls = {
        -- FlashBackdrop = { fg = "#545c7e" },
        FlashCurrent = { bg = "#ff966c", fg = "#1b1d2b" },
        FlashLabel = { bg = "#ff007c", bold = true, fg = "#c8d3f5" },
        FlashMatch = { bg = "#3e68d7", fg = "#c8d3f5" },
        FlashCursor = { reverse = true },
      }
      for hl_group, hl in pairs(hls) do
        hl.default = true
        vim.api.nvim_set_hl(0, hl_group, hl)
      end
    end,
    -- stylua: ignore
    keys = {
      { "<leader>ss", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "<leader>sr", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "<leader>sR", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}
