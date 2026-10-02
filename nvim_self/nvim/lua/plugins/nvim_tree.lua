return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "nvimtreetoggle" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  init = function()
    -- open the tree when nvim is started with a directory: `nvim .` or
    -- `nvim dir`. The plugin is lazy loaded, so its own directory hijack
    -- autocmds are not registered yet when the startup buffer is created;
    -- requiring it here loads it and hijacks the directory buffer.
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("NvimTreeStartDirectory", { clear = true }),
      callback = function()
        if vim.fn.argc() ~= 1 then
          return
        end
        local path = vim.fn.fnamemodify(vim.fn.argv(0), ":p")
        if vim.fn.isdirectory(path) == 1 then
          require("nvim-tree.api").tree.open({ path = path })
        end
      end,
    })
  end,
  config = function()
    local status, nvim_tree = pcall(require, "nvim-tree")
    if not status then
      vim.notify("not found nvim-tree")
      return
    end
    local function my_on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- default mappings
      api.config.mappings.default_on_attach(bufnr)
      -- custom mappings
      vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    end
    -- Floating-label window picker.
    --
    -- The built-in picker writes the letter into each window's 'statusline'
    -- option. lualine re-renders statuslines on a timer and on
    -- WinEnter/BufEnter, so the letter of the window it refreshes (with
    -- globalstatus=true that is the current window, usually the bottom one)
    -- gets overwritten and can no longer be seen.
    --
    -- This picker draws the letters as floating windows on the last row of
    -- each window instead, so it works with any 'laststatus' setting.
    local function floating_window_picker()
      local api = vim.api
      local cfg = require("nvim-tree.config").g.actions.open_file.window_picker
      local chars = cfg.chars
      local exclude = cfg.exclude or {}

      -- windows that can receive the node, mirroring nvim-tree's usable_win_ids
      local selectable = {}
      for _, w in ipairs(api.nvim_tabpage_list_wins(0)) do
        local buf = api.nvim_win_get_buf(w)
        local win_config = api.nvim_win_get_config(w)
        local ft = api.nvim_get_option_value("filetype", { buf = buf })
        local bt = api.nvim_get_option_value("buftype", { buf = buf })
        local blocked = ft == "NvimTree"
          or vim.tbl_contains(exclude.filetype or {}, ft)
          or vim.tbl_contains(exclude.buftype or {}, bt)
        if not blocked and win_config.focusable and not win_config.hide and not win_config.external then
          selectable[#selectable + 1] = w
        end
      end

      -- -1 means "no selectable window": nvim-tree then falls back to its
      -- default target and opens the file in a new split (this is the case
      -- right after `nvim .`, when the tree is the only window).
      -- nil would mean "cancelled" and abort the open, so it must not be
      -- used here.
      if #selectable == 0 then
        return -1
      end
      -- a single window needs no picking
      if #selectable == 1 then
        return selectable[1]
      end
      if #selectable > #chars then
        vim.notify(
          ("nvim-tree: %d windows but only %d window_picker.chars"):format(#selectable, #chars),
          vim.log.levels.ERROR
        )
        return nil
      end

      -- draw a letter on the last row of every selectable window
      local float_wins, float_bufs = {}, {}
      for i, w in ipairs(selectable) do
        local label = (" %s "):format(chars:sub(i, i))
        local buf = api.nvim_create_buf(false, true)
        api.nvim_buf_set_lines(buf, 0, -1, false, { label })
        float_bufs[#float_bufs + 1] = buf
        local ok, float = pcall(api.nvim_open_win, buf, false, {
          relative = "win",
          win = w,
          row = math.max(api.nvim_win_get_height(w) - 1, 0),
          col = math.max(math.floor((api.nvim_win_get_width(w) - #label) / 2), 0),
          width = #label,
          height = 1,
          style = "minimal",
          -- 'winborder' is set globally, force no border so the label stays
          -- a single row on the window's last line
          border = "none",
          focusable = false,
          noautocmd = true,
          zindex = 100,
        })
        if ok then
          api.nvim_set_option_value("winhighlight", "NormalFloat:NvimTreeWindowPicker", { win = float })
          float_wins[#float_wins + 1] = float
        end
      end

      vim.cmd("redraw")
      if vim.o.cmdheight ~= 0 then
        vim.api.nvim_echo({ { "Pick window: ", "None" } }, false, {})
      end

      local ok, c = pcall(vim.fn.getchar)
      local pressed = (ok and type(c) == "number") and vim.fn.nr2char(c):upper() or nil

      for _, f in ipairs(float_wins) do
        if api.nvim_win_is_valid(f) then
          api.nvim_win_close(f, true)
        end
      end
      for _, b in ipairs(float_bufs) do
        if api.nvim_buf_is_valid(b) then
          api.nvim_buf_delete(b, { force = true })
        end
      end
      vim.cmd("redraw")

      if not pressed then
        return nil
      end
      for i, w in ipairs(selectable) do
        if chars:sub(i, i) == pressed then
          return w
        end
      end
      return nil
    end

    nvim_tree.setup({
      on_attach = my_on_attach,
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
        custom = { "node_modules" },
      },
      view = {
        width = 35,
        side = "left",
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
          -- floating-label picker, see floating_window_picker() above
          window_picker = {
            enable = true,
            picker = floating_window_picker,
          },
        },
      },
      -- wsl install -g wsl-open
      -- system_open = {
      --   cmd = "wsl-open", -- mac set open
      -- },
      renderer = {
        full_name = false,
        group_empty = true,
        special_files = {},
        symlink_destination = false,
        indent_markers = {
          enable = true,
        },
        icons = {
          git_placement = "signcolumn",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
    })
    -- auto close
    vim.api.nvim_create_autocmd("QuitPre", {
      callback = function()
        local tree_wins = {}
        local floating_wins = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
          local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
          if bufname:match("NvimTree_") ~= nil then
            table.insert(tree_wins, w)
          end
          if vim.api.nvim_win_get_config(w).relative ~= "" then
            table.insert(floating_wins, w)
          end
        end
        if 1 == #wins - #floating_wins - #tree_wins then
          -- Should quit, so we close all invalid windows.
          for _, w in ipairs(tree_wins) do
            vim.api.nvim_win_close(w, true)
          end
        end
      end,
    })
  end,
}
