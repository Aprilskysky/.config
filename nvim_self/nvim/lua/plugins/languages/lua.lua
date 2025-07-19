local M = {}

function M.set_lua_ls(capabilities)
  if vim.g.config_type == "RD" then
    vim.lsp.config(
      "lua_ls",
      { cmd = { vim.fn.stdpath("data") .. "/mason/packages/local/lua_ls/bin/lua-language-server" } }
    )
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
