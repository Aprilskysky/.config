return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- cmd = "WhichKey",
    opts_extend = { "spec" },
    opts = {
      defaults = {},
      spec = {
        mode = { "n", "v" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>h", group = "harpoon" },
        { "<leader>q", group = "quit/session" },
        { "<leader>r", group = "re/" },
        { "<leader>n", group = "noice" },
        { "<leader>s", group = "flash/scissors" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "<leader>j", group = "anyjump" },
        { "<leader>g", group = "grug-far" },
        { "<leader>m", group = "format" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      if not vim.tbl_isempty(opts.defaults) then
        wk.register(opts.defaults)
      end
    end,
  },
}
