return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  lazy = false,
  -- event = "VeryLazy",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      automatic_enable = false,
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "perlnavigator",
        "bashls",
        -- "svlangserver",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "stylua", -- lua formatter
        "verible",
        -- "beautysh",
      },
    })
  end,
}
