local M = {}

function M.set_perlnavigator(capabilities)
  if vim.g.config_type == "RD" then
    local nvim_self = vim.env.NVIM_SELF or vim.fs.normalize(vim.fn.stdpath("config") .. "/..")
    vim.lsp.config("perlnavigator", { cmd = { nvim_self .. "/app/bin/perlnavigator" } })
  end
  vim.lsp.config("perlnavigator", {
    capabilities = capabilities,
  })
  vim.lsp.enable("perlnavigator")
end

return M
