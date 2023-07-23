return {
    'akinsho/bufferline.nvim', version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "moll/vim-bbye",
    },
    config = function()
        local status, bufferline = pcall(require, "bufferline")
        if not status then
            vim.notify("not found bufferline")
            return
        end

        bufferline.setup({
            options = {
                -- close tab cmd, there use moll/vim-bbye Bdelete
                close_command = "Bdelete! %0d",
                right_mouse_command = "Bdelete! %d",
                -- Sidebar configuration
                -- Leave the nviim-tree on the left and display the text File Explorer
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
                -- use nvim lsp
                diagnostics = "nvim_lsp",
                -- show lsp error icon
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local s = " "
                    for e, n in pairs(diagnostics_dict) do
                        local sym = e == "error" and " " or (e == "warning" and " " or "")
                        s = s .. n .. sym
                    end
                    return s
                end,
            },
        })
    end,
}
