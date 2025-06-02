#!/usr/bin/sh

NVIM_SELF=~/.config/nvim_self
export PATH=$NVIM_SELF/app/bin:$PATH
export PATH=$NVIM_SELF/app/bin/ctags:$PATH
export PATH=$NVIM_SELF/app/bin/lua_ls/bin/:$PATH
export PATH=$NVIM_SELF/app/bin/perlnavigator-linux-x86_64/:$PATH
alias nvim='XDG_DATA_HOME=$NVIM_SELF/share XDG_CONFIG_HOME=$NVIM_SELF $NVIM_SELF/app/nvim11.appimage'
nvim "$@"
