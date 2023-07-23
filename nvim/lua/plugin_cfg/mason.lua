return {
    -- event = "VeryLazy",
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", -- :MasonUpdate updates registry contents
    },

    config = function()
        require("mason").setup({
            -- ui = {
            --     icons = {
            --         package_installed = "✓",
            --         package_pending = "➜",
            --         package_uninstalled = "✗",
            --     },
            -- },
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "pyright",
                "svlangserver",
            },
            automatic_installation = true,
        })
    end,
}
