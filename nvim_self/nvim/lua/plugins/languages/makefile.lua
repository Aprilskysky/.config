local M = {}

function M.set_makefile_linter(lint)
  lint.linters_by_ft = {
    make = { "checkmake" },
  }
  local checkmake = lint.linters.checkmake
  if vim.g.config_type == "RD" then
    checkmake.cmd = vim.fn.stdpath("data") .. "/mason/packages/local/checkmake-0.2.2.linux.amd64"
  end
end

return M
