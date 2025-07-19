return {
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
      "BufWritePost",
    },
    config = function()
      local lint = require("lint")

      -- require("plugins.languages.systemverilog").set_sv_linter(lint, { "verilator" })
      require("plugins.languages.makefile").set_makefile_linter(lint)

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
