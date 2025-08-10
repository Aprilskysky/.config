return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "folke/lazydev.nvim",
      "mikavilpas/blink-ripgrep.nvim",
      "archie-judd/blink-cmp-words",
      {
        "Kaiser-Yang/blink-cmp-dictionary",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "arstgit/high-frequency-vocabulary",
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
      enabled = function()
        return not vim.tbl_contains({ "DressingInput" }, vim.bo.filetype)
      end,
      completion = {
        keyword = {
          range = "full",
        },
        list = { max_items = 30 },
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
        default = function()
          if vim.g.config_type == "RD" then
            return {
              "lazydev",
              "lsp",
              "path",
              "buffer",
              "snippets",
              "dictionary",
              "words_dictionary",
              "thesaurus",
            }
          else
            return {
              "lazydev",
              "lsp",
              "path",
              "buffer",
              "snippets",
              "words_dictionary",
            }
          end
        end,
        providers = {
          lsp = {
            name = "lsp",
            module = "blink.cmp.sources.lsp",
            score_offset = 9,
            fallbacks = {},
          },
          path = { name = "path", score_offset = 11 },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 10,
          },
          buffer = {
            name = "buffer",
            score_offset = 11,
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
          snippets = {
            name = "snippets",
            score_offset = 12,
            opts = {
              search_paths = { "my_snippets_path" },
            },
          },
          cmdline = {
            min_keyword_length = function(ctx)
              -- when typing a command, only show when the keyword is 3 characters or longer
              if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                return 3
              end
              return 0
            end,
          },
          thesaurus = {
            name = "blink-cmp-words",
            module = "blink-cmp-words.thesaurus",
            score_offset = -120,
            min_keyword_length = 3,
            max_items = 5,
            -- All available options
            opts = {
              -- A score offset applied to returned items.
              -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
              -- score_offset = 0,
              -- Default pointers define the lexical relations listed under each definition,
              -- see Pointer Symbols below.
              -- Default is as below ("antonyms", "similar to" and "also see").
              definition_pointers = { "!", "&", "^" },
            },
          },
          -- Use the dictionary source
          words_dictionary = {
            name = "blink-cmp-words",
            module = "blink-cmp-words.dictionary",
            score_offset = -100,
            min_keyword_length = 3,
            max_items = 5,
            -- All available options
            opts = {
              -- The number of characters required to trigger completion.
              -- Set this higher if completion is slow, 3 is default.
              dictionary_search_threshold = 3,
              -- See above
              -- score_offset = 0,
              -- See above
              definition_pointers = { "!", "&", "^" },
            },
          },
          dictionary = {
            module = "blink-cmp-dictionary",
            async = true,
            name = "Dict",
            score_offset = -100,
            -- Make sure this is at least 2.
            -- 3 is recommended
            min_keyword_length = 3,
            max_items = 5,
            opts = {
              -- options for blink-cmp-dictionary
              dictionary_files = {
                vim.fn.expand(vim.fn.stdpath("data") .. "/lazy/high-frequency-vocabulary/10k.txt"),
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
          menu = {
            auto_show = function()
              return vim.fn.getcmdtype() == ":"
            end,
          },
          ghost_text = {
            enabled = function()
              return vim.fn.getcmdtype() == ":"
            end,
          },
          list = { selection = { preselect = true, auto_insert = true } },
        },
        keymap = { preset = "inherit" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
