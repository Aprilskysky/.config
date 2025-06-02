local M = {}

function M.set_bashls(capabilities)
  vim.lsp.config("bashls", {
    capabilities = capabilities,
  })
  vim.lsp.enable("bashls")
end

return M
