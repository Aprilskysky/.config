local M = {}

function M.set_bashls(capabilities)
  if vim.g.config_type == "RD" then
    vim.lsp.config(
      "bashls",
      {
        cmd = {
          vim.fn.stdpath("data") .. "/mason/packages/bash-language-server/node_modules/bash-language-server/out/cli.js",
          "start",
        },
      }
    )
  end
  vim.lsp.config("bashls", {
    capabilities = capabilities,
  })
  vim.lsp.enable("bashls")
end

return M
