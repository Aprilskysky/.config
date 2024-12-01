return {
  {
    "vhda/verilog_systemverilog.vim",
    -- lazy = false,
    dependencies = {
      "Konfekt/FastFold",
      ft = "verilog_systemverilog",
    },
    init = function()
      -- set smartindent for verilog_systemverilog
      vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
        group = vim.api.nvim_create_augroup("verilog_systemverilog_cfg", { clear = true }),
        pattern = { "*.sv", "*.v", "*.svh", "*.svi" },
        callback = function()
          vim.bo.smartindent = false
          -- vim.cmd([[let g:verilog_quick_syntax = 1]])
        end,
      })
      vim.cmd([[
			     augroup systemverilog_settings_2
			         au!
			         " Enable folding for normal size files. Folding is really slow for large files.
			         au Filetype verilog_systemverilog if line('$') < 2000
			         au Filetype verilog_systemverilog     let g:verilog_syntax_fold_lst = "all"
			         au Filetype verilog_systemverilog     syntax enable "Trigger fold calculation
			         au Filetype verilog_systemverilog else
			         au Filetype verilog_systemverilog     let g:verilog_syntax_fold_lst = ""
			         au Filetype verilog_systemverilog endif
			     augroup END
			   ]])
    end,
  },
}
