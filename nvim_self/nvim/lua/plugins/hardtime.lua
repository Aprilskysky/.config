return {
  "m4xshen/hardtime.nvim",
  -- lazy = false,
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ht", "<cmd>Hardtime toggle<cr>", desc = "hardtime toggle" },
  },
  config = function()
    require("hardtime").setup()
  end,
}
