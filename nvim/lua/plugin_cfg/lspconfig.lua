return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "nvimdev/lspsaga.nvim",
        "folke/neoconf.nvim",
        "folke/neodev.nvim",
        {
            "j-hui/fidget.nvim",
            tag = "legacy",
            event = "LspAttach",
            opts = {
                -- options
            },
        }
    },
    config = function()
        require("neoconf").setup({})
        require("neodev").setup({})
        require("lspsaga").setup({})
        require("fidget").setup({})
        local status, lspcfg = pcall(require, "lspconfig")
        if not status then
            vim.notify("not found lspconfig")
            return
        end
        local on_attach = require("keybindings").on_attach
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        lspcfg.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        lspcfg.pyright.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        lspcfg.svls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        lspcfg.verible.setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
        lspcfg.svlangserver.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            on_init = function(client)
                local path = client.workspace_folders[1].name

                if path == '/path/to/project1' then
                    client.config.settings.systemverilog = {
                        includeIndexing     = {"**/*.{sv,svh}"},
                        excludeIndexing     = {"test/**/*.sv*"},
                        defines             = {},
                        launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
                        formatCommand       = "/tools/verible-verilog-format"
                    }
                elseif path == '/path/to/project2' then
                    client.config.settings.systemverilog = {
                        includeIndexing     = {"**/*.{sv,svh}"},
                        excludeIndexing     = {"sim/**/*.sv*"},
                        defines             = {},
                        launchConfiguration = "/tools/verilator -sv -Wall --lint-only",
                        formatCommand       = "/tools/verible-verilog-format"
                    }
                end

                client.notify("workspace/didChangeConfiguration")
                return true
            end
        })
    end,
}
