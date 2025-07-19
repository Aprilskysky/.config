local M = {}

function M.set_perlnavigator(capabilities)
  if vim.g.config_type == "RD" then
    vim.lsp.config(
      "perlnavigator",
      { cmd = { vim.fn.stdpath("data") .. "/mason/packages/local/perlnavigator-linux-x86_64/perlnavigator" } }
    )
  end
  vim.lsp.config("perlnavigator", {
    capabilities = capabilities,
  })
  vim.lsp.enable("perlnavigator")
end

return M
