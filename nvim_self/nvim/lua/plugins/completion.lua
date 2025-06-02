return {
  {
    "saghen/blink.cmp",
    event = "VeryLazy",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "folke/lazydev.nvim",
      "mikavilpas/blink-ripgrep.nvim",
      {
        "Kaiser-Yang/blink-cmp-dictionary",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "dwyl/english-words",
        },
      },
      { "xzbdmw/colorful-menu.nvim", opts = {} },
      {
        "saghen/blink.compat",
        version = "*",
        opts = {},
      },
    },
    version = "1.*",
    opts = {
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<cr>"] = { "select_and_accept", "fallback" },
        ["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-n>"] = { "select_next", "snippet_forward", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },
      completion = {
        keyword = {
          range = "full",
        },
        list = { max_items = 50 },
        documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
        menu = {
          border = "rounded",
          auto_show = true,
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lazydev", "lsp", "path", "buffer", "snippets", "dictionary" },
        providers = {
          lsp = {
            name = "lsp",
            module = "blink.cmp.sources.lsp",
            score_offset = 7,
            fallbacks = {},
          },
          path = { name = "path", score_offset = 9 },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 8,
          },
          buffer = {
            name = "buffer",
            score_offset = 9,
            opts = {
              -- get all buffers, even ones like neo-tree
              get_bufnrs = vim.api.nvim_list_bufs,
              -- or (recommended) filter to only "normal" buffers
              -- get_bufnrs = function()
              --   return vim.tbl_filter(function(bufnr)
              --     return vim.bo[bufnr].buftype == ""
              --   end, vim.api.nvim_list_bufs())
              -- end,
            },
          },
          snippets = { name = "snippets", score_offset = 10 },
          cmdline = {
            min_keyword_length = function(ctx)
              -- when typing a command, only show when the keyword is 3 characters or longer
              if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                return 3
              end
              return 0
            end,
          },
          dictionary = {
            module = "blink-cmp-dictionary",
            name = "Dict",
            -- Make sure this is at least 2.
            -- 3 is recommended
            min_keyword_length = 3,
            opts = {
              -- options for blink-cmp-dictionary
              dictionary_files = {
                vim.fn.expand(vim.fn.stdpath("data") .. "/lazy/english-words/words.txt"),
                vim.fn.expand(vim.fn.stdpath("data") .. "/lazy/english-words/uk-us-dict.txt"),
              },
            },
          },
        },
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
        sorts = {
          "score",
        },
      },
      cmdline = {
        completion = {
          menu = { auto_show = true },
          list = { selection = { preselect = true, auto_insert = true } },
        },
        keymap = { preset = "inherit" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
