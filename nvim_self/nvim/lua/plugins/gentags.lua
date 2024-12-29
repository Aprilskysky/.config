return {
  {
    "skywind3000/gutentags_plus",
    event = "VeryLazy",
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
        " let g:gutentags_cache_dir = expand('~/.cache/tags')
        let g:gutentags_cache_dir = stdpath('cache').'/tags'
        " change focus to quickfix window after search (optional)
        let g:gutentags_plus_switch = 1
        let g:gutentags_ctags_extra_args = ["--exclude=*.log"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.git"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.svg"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.hg"]
        let g:gutentags_ctags_extra_args += ["--exclude=node_modules"]
        let g:gutentags_ctags_extra_args += ["--exclude=*tags*"]
        let g:gutentags_ctags_extra_args += ["--exclude=*cscope.*"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.pyc"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.class"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.pdb"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.sln"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.csproj"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.csproj.user"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.exe"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.dll"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.mp3"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.ogg"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.flac"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.swp"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.swo"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.bmp"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.gif"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.ico"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.jpg"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.png"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.rar"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.zip"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.tar"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.tar.gz"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.tar.xz"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.tar.bz2"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.pdf"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.doc"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.docx"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.ppt"]
        let g:gutentags_ctags_extra_args += ["--exclude=*.pptx"]
        augroup set_ctags_extra_args_for_sv
          au!
          autocmd FileType systemverilog let g:gutentags_ctags_extra_args += ["-R /mtklib/soft/verif/Methodology/UVM/uvm/latest/src"]
        augroup END
      ]])
    end,
  },
}
