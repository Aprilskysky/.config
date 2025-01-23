local M = {}

function M.set_perlnavigator(lspconfig, capabilities)
  lspconfig["perlnavigator"].setup({
    cmd = { "perlnavigator" },
    capabilities = capabilities,
    settings = {
      perlnavigator = {
        perlPath = "perl",
        enableWarnings = true,
        perltidyProfile = "",
        perlcriticProfile = "",
        perlcriticEnabled = true,
      },
    },
  })
end

return M
