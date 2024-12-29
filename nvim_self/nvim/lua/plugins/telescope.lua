return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
    -- stylua: ignore
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Show all buffer diagnostics" },
      { "<leader>fD", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Show current buffer diagnostics" }
    },
  opts = {
    defaults = {
      file_ignore_patterns = { "^luac", "%.luac" },
      mappings = {
        i = {
          ["<Down>"] = function(...)
            require("telescope.actions").cycle_history_next(...)
          end,
          ["<Up>"] = function(...)
            require("telescope.actions").cycle_history_prev(...)
          end,
        },
      },
      preview = {
        treesitter = false,
      },
      -- borderchars = {
      --   prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
      --   results = { " " },
      --   preview = { " " },
      -- },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("fzf")
  end,
}
