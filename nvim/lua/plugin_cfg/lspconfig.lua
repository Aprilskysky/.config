return {
    "neovim/nvim-lspconfig",
    dependencies = {
        -- "nvimdev/lspsaga.nvim",
        "folke/neodev.nvim",
    },
    config = function()
        require("neodev").setup({})
        -- require("lspsaga").setup({})
        local status, lspcfg = pcall(require, "lspconfig")
        if not status then
            vim.notify("not found lspconfig")
            return
        end
        lspcfg.lua_ls.setup({})
        lspcfg.svlangserver.setup({})
    end,
}
