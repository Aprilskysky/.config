#!/usr/bin/sh

NVIM_SELF=~/.config/nvim_self
export PATH=$NVIM_SELF/app/bin:$PATH
export PATH=$NVIM_SELF/app/bin/ctags/usr/local/bin:$PATH
export NVIM_APP_CONFIG_TYPE="RD"
alias nvim='XDG_DATA_HOME=$NVIM_SELF/share XDG_CONFIG_HOME=$NVIM_SELF $NVIM_SELF/app/nvim-linux-x86_64.appimage'
nvim "$@"
