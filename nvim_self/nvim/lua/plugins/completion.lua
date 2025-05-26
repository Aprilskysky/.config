return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      "delphinus/cmp-ctags",
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
        },
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
      },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.snippet.active({ direction = 1 }) then
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.snippet.active({ direction = -1 }) then
              vim.schedule(function()
                vim.snippet.jump(-1)
              end)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          {
            name = "ctags",
            -- default values
            option = {
              executable = "ctags",
              trigger_characters = { "." },
              trigger_characters_ft = {},
            },
          },
          {
            name = "buffer",
            option = {
              -- get all buffers
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          { name = "snippets" },
          { name = "path" },
        }),
        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
      })
    end,
  },

  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "folke/lazydev.nvim",
      "mikavilpas/blink-ripgrep.nvim",
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
        default = { "lazydev", "lsp", "path", "buffer", "snippets" },
        providers = {
          lsp = { score_offset = 7, fallbacks = {} },
          path = { score_offset = 9 },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 8,
          },
          buffer = {
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
          snippets = { score_offset = 10 },
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
