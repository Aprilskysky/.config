return {
  {
    "romus204/tree-sitter-manager.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>cT", "<cmd>TSManager<cr>", desc = "open TSManager" },
    },
    config = function()
      require("tree-sitter-manager").setup({
        -- Default Options
        ensure_installed = {
          "bash",
          "c",
          "diff",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "systemverilog",
          "perl",
          "tcl",
          "csv",
          "make",
          "ruby",
        },                   -- list of parsers to install at the start of a neovim session
        -- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
        auto_install = true, -- if enabled, install missing parsers when editing a new file
        highlight = true,    -- treesitter highlighting is enabled by default
        -- languages = {}, -- override or add new parser sources
        -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
        -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
      })
    end
  }
}
