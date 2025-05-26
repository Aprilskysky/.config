local icons = require("config.icons")
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "folke/lazydev.nvim",
        fl = "lua",
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local signs_tb = {
        { name = "DiagnosticSignError", text = icons.diagnostics.BoldError },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.BoldWarning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.BoldHint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.BoldInformation },
      }
      for _, sign in ipairs(signs_tb) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lspattach_key", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local opts = { noremap = true, silent = true, buffer = bufnr }
          local keymap = vim.keymap
          -- set keybinds
          opts.desc = "Show LSP references"
          keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
          opts.desc = "Go to declaration"
          keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
          opts.desc = "Show LSP definitions"
          keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
          opts.desc = "Show LSP implementations"
          keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations
          opts.desc = "Show LSP type definitions"
          keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions
          opts.desc = "See available code actions"
          keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
          opts.desc = "Smart rename"
          keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
          opts.desc = "Restart LSP"
          keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end,
      })

      -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      require("plugins.languages.lua").set_lua_ls(capabilities)
      require("plugins.languages.systemverilog").set_veridian(capabilities)
    end,
  },
}
