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
      local severity, code, file, lnum, message
      for _, line in ipairs(results) do
        if pre_is_empty then
          if line == "" then
            parse_en = false
            severity, code, file, lnum, message = nil, nil, nil, nil, nil
            pre_is_empty = true
          else
            pre_is_empty = false
            _, _, severity, code, message = string.find(line, "^([EWNL][raoi][rtn][onet][ri]?%a*)-%[(.*)%]%s*(.*)")
            if severity ~= nil and code ~= nil then
              parse_en = true
            end
          end
        else
          if line == "" then
            parse_en = false
            severity, code, file, lnum, message = nil, nil, nil, nil, nil
            pre_is_empty = true
          else
            if parse_en then
              if file == nil and lnum == nil then
                _, _, file, lnum = string.find(line, "^%s*(.-[%w_]%.%a+)%s*,%s*(%d+)%s*$")
              end
              if file == nil then
                _, _, file = string.find(line, '^%s*"(.*[%w_]+%.%a+)%s*"%s*,%s*$')
              end
              if lnum == nil then
                _, _, lnum = string.find(line, "^%s*(%d+).-:%s*.*")
              end
              if lnum == nil then
                _, _, lnum = string.find(line, "^%s*(%d+)%s*$")
              end
              if severity ~= nil and code ~= nil and file ~= nil and lnum ~= nil and message ~= nil then
                if vim.api.nvim_buf_get_name(bufnr) == file then
                  diagnostic = {
                    source = "vcs",
                    severity = severities[severity],
                    code = code,
                    lnum = tonumber(lnum) - 1,
                    message = message,
                    col = 0,
                  }
                  for i, v in ipairs(diagnostics) do
                    if vim.deep_equal(diagnostic, diagnostics[i]) then
                      goto NOT_INSERT
                    end
                  end
                  table.insert(diagnostics, diagnostic)
                  ::NOT_INSERT::
                end
                severity, code, file, lnum, message = nil, nil, nil, nil, nil
                diagnostic = {}
              end
            end
          end
        end
      end
      return diagnostics
    end,
  }
end

function M.set_sv_linter(lint, linter_type)
  local set_cnt = 0
  if vim.tbl_contains(linter_type, "verilator") then
    M.set_verilator(lint)
    set_cnt = set_cnt + 1
  end
  if vim.tbl_contains(linter_type, "vcs") then
    M.set_vcs(lint)
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

function M.set_veridian(lspconfig, capabilities)
  lspconfig["veridian"].setup({
    cmd = { "/home/wxl/.config/nvim_self/share/nvim/mason/bin/veridian" },
    capabilities = capabilities,
  })
end

return M
