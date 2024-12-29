return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local status, lualine = pcall(require, "lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    if not status then
      vim.notify("not found lualine")
      return
    end
    lualine.setup({
      options = {
        -- component_separators = { left = "|", right = "|" },
        -- https://github.com/ryanoasis/powerline-extra-symbols
        -- section_separators = { left = " ", right = "" },
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      extensions = { "nvim-tree", "toggleterm" },
      sections = {
        -- +-------------------------------------------------+
        -- | A | B | C                             X | Y | Z |
        -- +-------------------------------------------------+
        lualine_c = {
          "filename",
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
          -- {
          --     "lsp_progress",
          --     spinner_symbols = { " ", " ", " ", " ", " ", " " },
          -- },
        },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          "filesize",
          {
            "fileformat",
            symbols = {
              unix = "", -- e712
              dos = "", -- e70f
              mac = "", -- e711
            },
            -- symbols = {
            --     unix = "LF",
            --     dos = "CRLF",
            --     mac = "CR",
            -- },
          },
          "encoding",
          "filetype",
        },
      },
    })
  end,
}
