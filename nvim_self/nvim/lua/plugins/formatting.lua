return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  enabled = function()
    if vim.g.config_type == "NORMAL" then
      return true
    else
      return false
    end
  end,
  config = function()
    local conform = require("conform")

    conform.setup({
      -- Set the log level. Use `:ConformInfo` to see the location of the log file.
      log_level = vim.log.levels.ERROR,
      -- Conform will notify you when a formatter errors
      notify_on_error = true,
      formatters_by_ft = {
        verilog = { "verible" },
        systemverilog = { "verible" },
        lua = { "stylua" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
