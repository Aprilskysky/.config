local M = {}

function M.set_makefile_linter(lint)
  lint.linters_by_ft = {
    make = { "checkmake" },
  }
  local checkmake = lint.linters.checkmake
  if vim.g.config_type == "RD" then
    local nvim_self = vim.env.NVIM_SELF or vim.fs.normalize(vim.fn.stdpath("config") .. "/..")
    checkmake.cmd = nvim_self .. "/app/bin/checkmake"
  end
end

return M
