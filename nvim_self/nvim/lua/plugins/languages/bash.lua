local M = {}

function M.set_bashls(lspconfig, capabilities)
  lspconfig["bashls"].setup({
    capabilities = capabilities,
  })
end

return M
