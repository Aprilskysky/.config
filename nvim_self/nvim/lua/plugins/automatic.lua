return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local cond = require("nvim-autopairs.conds")
      npairs.setup()
      -- don't autopair backtick and single quote in SV (used for macros/text)
      local no_pair_fts = {
        systemverilog = { "`", "'" },
        verilog = { "`", "'" },
        verilog_systemverilog = { "`", "'" },
      }
      for ft, chars in pairs(no_pair_fts) do
        for _, char in ipairs(chars) do
          for _, rule in ipairs(npairs.get_rules(char)) do
            rule:with_pair(cond.not_filetypes({ ft }))
          end
        end
      end
    end,
  },
}
