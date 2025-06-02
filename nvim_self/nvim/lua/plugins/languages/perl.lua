local M = {}

function M.set_perlnavigator(capabilities)
  vim.lsp.config("perlnavigator", {
    capabilities = capabilities,
  })
  vim.lsp.enable("perlnavigator")
end

return M
