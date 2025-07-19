return {
  {
    "echasnovski/mini.files",
    opts = {
      windows = {
        preview = true,
        width_nofocus = 20,
        width_preview = 60,
      },
      options = {
        use_as_default_explorer = true,
      },
    },
    keys = {
      {
        "<leader>fE",
        function()
          require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = "Explorer (Current File)",
      },
      {
        "<leader>fe",
        function()
          require("mini.files").open(vim.loop.cwd(), true)
        end,
        desc = "Explorer (Current Directory)",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)
    end,
  },
}
