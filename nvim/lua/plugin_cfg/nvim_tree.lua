return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local status, nvim_tree = pcall(require, "nvim-tree")
        if not status then
            vim.notify("not found nvim-tree")
            return
        end

        local list_keys = require("keybindings").nvimtreelist
        nvim_tree.setup({
            -- not show git icon
            git = {
                enable = false,
            },
            -- project plugin set
            update_cwd = true,
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
            -- don't show .file and node_modules folder
            filters = {
                dotfiles = true,
                custom = {"node_modules"},
            },
            view = {
                width = 35,
                side = "left",
                hide_root_folder = false,
                -- Customize shortcut keys in the list
                mappings = {
                    custom_only = false,
                    list = list_keys,
                },
                -- don't show line number
                number = false,
                relativenumber = false,
                -- show icon
                signcolumn = "yes",
            },
            actions = {
                open_file = {
                    -- The size fit is enabled for the first time
                    resize_window = true,
                    -- close when open file?
                    quit_on_open = false,
                },
            },
            -- wsl install -g wsl-open
            -- https://github.com/4U6U57/wsl-open/
            system_open = {
                cmd = 'wsl-open', -- mac set open
            },
        })
        -- auto close
        vim.cmd([[
          autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
        ]])
    end,
}
