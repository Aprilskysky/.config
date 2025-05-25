local M = {}

function M.set_lua_ls(capabilities)
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
