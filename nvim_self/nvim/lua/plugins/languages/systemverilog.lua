local M = {}

function M.set_verilator(lint)
  lint.linters_by_ft = {
    systemverilog = { "verilator" },
    verilog = { "verilator" },
  }

  -- require("lint").linters.verilator.args = {
  --   "-sv",
  --   "-Wall",
  --   "--bbox-sys",
  --   "--bbox-unsup",
  --   "--lint-only",
  --   "-f",
  --   vim.fs.find("verilator.f", { upward = true, stop = vim.env.HOME })[1],
  -- }
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

function M.set_verible(lspconfig, capabilities) end

return M