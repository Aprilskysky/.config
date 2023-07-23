return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- "arkav/lualine-lsp-progress",
    },
    config = function()
        local status, lualine = pcall(require, "lualine")
        if not status then
            vim.notify("not found lualine")
            return
        end

        lualine.setup ({
            options = {
                -- theme = "tokyonight",
                component_separators = { left = "|", right = "|" },
                -- https://github.com/ryanoasis/powerline-extra-symbols
                section_separators = { left = " ", right = "" },
            },
            extensions = { "nvim-tree", "toggleterm" },
            sections = {
                -- +-------------------------------------------------+
                -- | A | B | C                             X | Y | Z |
                -- +-------------------------------------------------+
                lualine_c = {
                    "filename",
                    -- {
                    --     "lsp_progress",
                    --     spinner_symbols = { " ", " ", " ", " ", " ", " " },
                    -- },
                },
                lualine_x = {
                    "filesize",
                    {
                        "fileformat",
                        symbols = {
                          unix = '', -- e712
                          dos = '', -- e70f
                          mac = '', -- e711
                        },
                        -- symbols = {
                        --     unix = "LF",
                        --     dos = "CRLF",
                        --     mac = "CR",
                        -- },
                    },
                    "encoding",
                    "filetype",
                },
            },
        })
    end,
}
