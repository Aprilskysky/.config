return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = "VeryLazy",
  lazy = vim.fn.argc(-1) == 0,
  init = function()
    require("nvim-treesitter.query_predicates")
  end,
  opts = {
    -- ensure_installed = "all",
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
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
      -- "systemverilog",
      "verilog",
      "perl",
      "tcl",
      "csv",
      "make",
    },
    -- enable highlight
    highlight = {
      enable = true,
      -- additional_vim_regex_highlighting = {
      -- 	"verilog",
      -- 	"systemverilog",
      -- },
    },
    indent = {
      enable = true,
    },
    matchup = {
      enable = true,
    },
  },
  config = function(_, opts)
    local status, treesitter = pcall(require, "nvim-treesitter.configs")
    if not status then
      vim.notify("not found nvim-treesitter")
      return
    end

    if type(opts.ensure_installed) == "table" then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    treesitter.setup(opts)
  end,
}
