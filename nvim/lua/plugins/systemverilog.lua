return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "verilog" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        svlangserver = {},
        verible = {},
      },
    },
    -- setup = {
    --   svlangserver = function()
    --     require("lazyvim.util").on_attach(function(client, _)
    --       if client.name == "svlangserver" then
    --       end
    --     end)
    --   end,
    -- },
  },
}
