-- add the systemverilog type for ripgrep (rg doesn't have it built-in).
-- set lazily on first use so other rg consumers (e.g. telescope) are not
-- affected at startup; the rg.conf content is additive-only
local function with_rg_conf(cmd)
  if vim.env.RIPGREP_CONFIG_PATH == nil then
    vim.env.RIPGREP_CONFIG_PATH = vim.fn.stdpath("config") .. "/rg.conf"
  end
  vim.cmd(cmd)
end

return {
  "pechorin/any-jump.vim",
  event = "VeryLazy",
  keys = {
    { "<leader>jj", mode = { "n" }, function() with_rg_conf("AnyJump") end, desc = "Jump to definition" },
    { "<leader>jj", mode = { "v" }, function() with_rg_conf("AnyJumpVisual") end, desc = "jump to selected text" },
    { "<leader>jb", mode = { "n" }, function() with_rg_conf("AnyJumpBack") end, desc = "open previous opened file" },
    { "<leader>jl", mode = { "n" }, function() with_rg_conf("AnyJumpLastResults") end, desc = "open last closed search window again" },
  },
  init = function()
    vim.cmd([[
      let g:any_jump_disable_default_keybindings = 1
    ]])
  end,
}
