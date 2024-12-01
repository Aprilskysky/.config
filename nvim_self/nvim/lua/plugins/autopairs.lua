return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    local cond = require("nvim-autopairs.conds")
    local remove_filetype_rules = {
      systemverilog = { "`", "'" },
      verilog = { "`", "'" },
      verilog_systemverilog = { "`", "'" },
    }
    npairs.setup()
    for filetype, rules in pairs(remove_filetype_rules) do
      for i = 1, #rules do
        require("nvim-autopairs").get_rules(remove_filetype_rules[filetype][i])[1].not_filetypes = { filetype }
        require("nvim-autopairs")
          .get_rules(remove_filetype_rules[filetype][i])[1]
          :with_pair(cond.not_filetypes({ filetype }))
      end
    end
  end,
}
