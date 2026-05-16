-- install with vim.pack directly
vim.pack.add({
  "https://github.com/zuqini/zpack.nvim",
})
require("zpack").setup({
  import = {"plugins"},
  default = {
    lazy = true,
  },
})
