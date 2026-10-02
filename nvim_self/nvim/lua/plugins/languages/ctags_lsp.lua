local M = {}

--- ctags-lsp: go-to-definition / completion / document+workspace symbols,
--- backed by universal-ctags. It indexes the workspace on startup and keeps
--- the index in memory (it never writes tagfiles).
---
--- Used here for languages without a dedicated server, which in this config is
--- SystemVerilog/Verilog (the veridian config exists but the binary is not
--- installed). Works in both NORMAL and RD, since the binaries live in app/bin.
---
--- To extend it to more languages, add the filetype below *and* the matching
--- ctags language to --languages (the filter keeps indexing fast and stops
--- unrelated files, e.g. a project's generated HTML docs, from showing up in
--- definition results).
---
--- Binaries (app/bin/ctags-lsp, app/bin/ctags) come from app/update_tools.sh.
function M.set_ctags_lsp(capabilities)
  local nvim_self = vim.env.NVIM_SELF or vim.fs.normalize(vim.fn.stdpath("config") .. "/..")
  local server = nvim_self .. "/app/bin/ctags-lsp"
  if vim.fn.executable(server) == 0 then
    vim.notify("ctags-lsp not found: " .. server .. " (run app/update_tools.sh)", vim.log.levels.WARN)
    return
  end

  -- prefer the maintained universal-ctags from app/bin (6.2.0), fall back to
  -- whatever "ctags" is in $PATH
  local ctags = nvim_self .. "/app/bin/ctags"
  if vim.fn.executable(ctags) == 0 then
    ctags = "ctags"
  end

  vim.lsp.config("ctags_lsp", {
    cmd = { server, "--ctags-bin", ctags, "--languages=SystemVerilog,Verilog" },
    filetypes = { "systemverilog", "verilog" },
    capabilities = capabilities,
    -- ctags-lsp indexes the whole workspace on startup; without a root it
    -- indexes nothing and cross-file definitions do not resolve. The default
    -- markers ({ "tags", ".tags", ".git" }) miss plain RTL source drops, so
    -- project files are used as well, falling back to the working directory.
    root_dir = vim.fs.root(0, { ".git", "tags", ".tags", "Makefile", "makefile", "filelist.f" })
      or vim.fn.getcwd(),
  })
  vim.lsp.enable("ctags_lsp")
end

return M
