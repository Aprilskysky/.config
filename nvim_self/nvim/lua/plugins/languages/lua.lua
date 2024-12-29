local M = {}

function M.set_lua_ls(lspconfig, capabilities)
  -- configure lua server (with special settings)
  lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
end

return M
