return {
  "pechorin/any-jump.vim",
  event = "VeryLazy",
  keys = {
    { "<leader>jj", mode = { "n" }, "<cmd>AnyJump<cr>", desc = "Jump to definition" },
    { "<leader>jj", mode = { "v" }, "<cmd>AnyJumpVisual<cr>", desc = "jump to selected text" },
    { "<leader>jb", mode = { "n" }, "<cmd>AnyJumpBack<cr>", desc = "open previous opened file" },
    { "<leader>jl", mode = { "n" }, "<cmd>AnyJumpLastResults<cr>", desc = "open last closed search window again" },
  },
  init = function()
    vim.cmd([[
      let g:any_jump_disable_default_keybindings = 1
    ]])
    -- add systemverilog type for ripgrep (rg doesn't have it built-in)
    vim.env.RIPGREP_CONFIG_PATH = vim.fn.stdpath("config") .. "/rg.conf"
  end,
}
