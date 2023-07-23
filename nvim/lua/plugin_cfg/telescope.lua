return {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local status, telescope = pcall(require, "telescope")
        if not status then
            vim.notify("not found telescope")
            return
        end

        telescope.setup({
            defaults = {
                -- The initial mode entered after popup is opened, which defaults to insert or can be normal
                initial_mode = "insert",
                -- shortcut in window
                mappings = require("keybindings").telescopelist,
            },
            pickers = {
                find_files = {
                    -- theme when find file: dropdown, cursor, ivy
                    -- :wq
                    -- theme = "ivy",
                    
                }
            },
            extensions = {
            },
        })
    end,
}
