local M = {}

function M.set_bashls(capabilities)
  if vim.g.config_type == "RD" then
    local nvim_self = vim.env.NVIM_SELF or vim.fs.normalize(vim.fn.stdpath("config") .. "/..")
    vim.lsp.config("bashls", {
      cmd = { nvim_self .. "/app/bin/bash-language-server", "start" },
    })
  end
  vim.lsp.config("bashls", {
    capabilities = capabilities,
  })
  vim.lsp.enable("bashls")
end

return M
