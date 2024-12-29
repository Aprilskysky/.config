local M = {}

function M.set_verilator(lint)
  lint.linters_by_ft = {
    systemverilog = { "verilator" },
    verilog = { "verilator" },
  }
  local verilator = lint.linters.verilator
  verilator.args = {
    "-sv",
    "-Wall",
    "--bbox-sys",
    "--bbox-unsup",
    "--lint-only",
    "-f",
    vim.fs.find("verilator.f", { upward = true, stop = vim.env.HOME })[1],
  }
end

function M.set_vcs(lint)
  lint.linters_by_ft = {
    systemverilog = { "verilator" },
    verilog = { "verilator" },
  }
  local severities = {
    ["Error"] = vim.diagnostic.severity.ERROR,
    ["Warning"] = vim.diagnostic.severity.WARN,
    ["Note"] = vim.diagnostic.severity.INFO,
    ["Lint"] = vim.diagnostic.severity.HINT,
  }

  require("lint").linters.vcs = {
    cmd = "vcs",
    stdin = false,
    append_fname = function()
      local filelist = vim.fs.find("filelist.f", { upward = true, stop = vim.env.HOME })[1]
      if filelist then
        return false
      else
        return true
      end
    end,
    stream = "stdout",
    args = {
      "full64",
      "-sverilog",
      "+lint=all",
      "-parse_only",
      "Mupdate",
      function()
        local filelist = vim.fs.find("filelist.f", { upward = true, stop = vim.env.HOME })[1]
        if filelist ~= nil then
          return "-f"
        end
      end,
      function()
        local filelist = vim.fs.find("filelist.f", { upward = true, stop = vim.env.HOME })[1]
        if filelist ~= nil then
          return filelist
        end
      end,
    },
    ignore_exitcode = true,
    parser = function(output)
      if output then
        return {}
      end
      local diagnostics = {}
      local diagnostic = {}
      local results = vim.fn.split(output, "\n")
      local parse_en = false
      local pre_is_empty = false
      local severity, code, file, lnum, Message
      for _, line in ipairs(results) do
        if pre_is_empty then
          if line == "" then
            parse_en = false
            severity, code, file, lnum, Message = nil, nil, nil, nil, nil
            pre_is_empty = true
          end
        end
      end
    end,
  }
end

function M.set_sv_linter(lint, linter_type)
  local set_cnt = 0
  if vim.tbl_contains(linter_type, "verilator") then
    M.set_verilator(lint)
    set_cnt = set_cnt + 1
  end
  if set_cnt ~= #linter_type then
    vim.print("error linter_type for systemverilog")
  end
end

function M.set_verible(lspconfig, capabilities)
  lspconfig["verible"].setup({
    capabilities = capabilities,
  })
end

return M
