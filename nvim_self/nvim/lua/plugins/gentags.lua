return {
  {
    "skywind3000/gutentags_plus",
    -- event = "VeryLazy",
    dependencies = {
      { "ludovicchabant/vim-gutentags" },
    },
    init = function()
      vim.cmd([[
        let g:gutentags_plus_nomap = 1
        " let g:gutentags_define_advanced_commands = 1
        " enable gtags module
        " let g:gutentags_modules = ['ctags', 'gtags_cscope']
        let g:gutentags_modules = ['ctags']
        " config project root markers.
        let g:gutentags_add_default_project_roots = 0
        let g:gutentags_project_root = ['.root']
        " generate datebases in my cache directory, prevent gtags files polluting my project
        let g:gutentags_cache_dir = expand('~/.cache/tags')
        " change focus to quickfix window after search (optional).
        let g:gutentags_plus_switch = 1
      ]])
    end,
  },

  {
    "linrongbin16/gentags.nvim",
    event = "VeryLazy",
    opts = {
      Defaults = {
        -- tool = "ctags",
        workspace = {},
        ctags = {
          -- exclude logs
          "--exclude=*.log",
          -- exclude vcs
          "--exclude=*.git",
          "--exclude=*.svg",
          "--exclude=*.hg",
          -- exclude nodejs
          "--exclude=node_modules",
          -- exclude tags/cscope
          "--exclude=*tags*",
          "--exclude=*cscope.*",
          -- exclude python
          "--exclude=*.pyc",
          -- exclude jvm class
          "--exclude=*.class",
          -- exclude VS project generated
          "--exclude=*.pdb",
          "--exclude=*.sln",
          "--exclude=*.csproj",
          "--exclude=*.csproj.user",
          -- exclude blobs
          "--exclude=*.exe",
          "--exclude=*.dll",
          "--exclude=*.mp3",
          "--exclude=*.ogg",
          "--exclude=*.flac",
          "--exclude=*.swp",
          "--exclude=*.swo",
          "--exclude=*.bmp",
          "--exclude=*.gif",
          "--exclude=*.ico",
          "--exclude=*.jpg",
          "--exclude=*.png",
          "--exclude=*.rar",
          "--exclude=*.zip",
          "--exclude=*.tar",
          "--exclude=*.tar.gz",
          "--exclude=*.tar.xz",
          "--exclude=*.tar.bz2",
          "--exclude=*.pdf",
          "--exclude=*.doc",
          "--exclude=*.docx",
          "--exclude=*.ppt",
          "--exclude=*.pptx",
        },
      },
    },
    config = function(opts)
      require("gentags").setup(opts)
    end,
  },
}
