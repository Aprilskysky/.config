local M = {}

function M.set_marksman(capabilities)
  -- if vim.g.config_type == "RD" then
  --   vim.lsp.config(
  --     "perlnavigator",
  --     { cmd = { vim.fn.stdpath("data") .. "/mason/packages/local/perlnavigator-linux-x86_64/perlnavigator" } }
  --   )
  -- end
  vim.lsp.config("marksman", {
    capabilities = capabilities,
  })
  vim.lsp.enable("marksman")
end

return M
