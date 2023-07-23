return {
    -- { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local status, treesitter = pcall(require, "nvim-treesitter.configs")
        if not status then
            vim.notify("not found nvim-treesitter")
            return
        end

        treesitter.setup({
            -- install language parser
            -- :TSInstallInfo will show the languages
            ensure_installed = { "verilog", "python", "vim", "lua", "perl", "typescript" },
            -- enable highlight
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
        })
    end,
}
