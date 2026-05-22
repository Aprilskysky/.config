return {
  -- install without yarn or npm
  -- "iamcco/markdown-preview.nvim",
  -- cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  -- ft = { "markdown" },
  -- build = function() vim.fn["mkdp#util#install"]() end,

  -- install with yarn or npm
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreview<cr>",       desc = "MarkdownPreview" },
    { "<leader>mP", "<cmd>MarkdownPreviewStop<cr>",   desc = "MarkdownPreviewStop" },
    { "<leader>mT", "<cmd>MarkdownPreviewToggle<cr>", desc = "MarkdownPreviewToggle" },
  },
}
