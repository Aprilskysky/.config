local M = {}

function M.set_lua_ls(capabilities)
  if vim.g.config_type == "RD" then
    local nvim_self = vim.env.NVIM_SELF or vim.fs.normalize(vim.fn.stdpath("config") .. "/..")
    vim.lsp.config("lua_ls", { cmd = { nvim_self .. "/app/bin/lua-language-server" } })
  end
  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
  vim.lsp.enable("lua_ls")
end

return M
