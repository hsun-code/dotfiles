#!/usr/bin/env bash

###################
# ENV variable
###################

# Prefer US English and use UTF-8
export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Do not clear the screen after quitting a manual page
export MANPAGER="less -X";

# Pre-defined directories
HSUN_HOME="$HOME/myhome"
HSUN_LIBS="$HOME/libs"
HSUN_DOTS="$HOME/hsun-code.code/dotfiles"
HSUN_NVIM="$HOME/hsun-code.code/NvChad"

export HSUN_HOME
export HSUN_LIBS
export HSUN_DOTS
export HSUN_NVIM

###################
# LD_LIBRARY_PATH
###################

# include HSUN_LIBS
MY_LIB_PATH="${HOME}/libs"
if [[ "$LD_LIBRARY_PATH" != *"$HSUN_LIBS:"* ]]; then
  export LD_LIBRARY_PATH="$HSUN_LIBS:$LD_LIBRARY_PATH"
fi
echo "######################################"
echo "LD_LIBRARY_PATH:$LD_LIBRARY_PATH"
echo "######################################"

###################
# helper functions
###################

# returns 1 if the package was already installed and 0 otherwise.
# The first argument is the package name to be checked (and installed if not already).
# other arguments are passed to apt-get
hsun_try_install() {
    dpkg -l "$1" | grep -q ^ii && msg "$1: Installed already" && return 1
    sudo apt-get -y install "$@"
    return 0
}

# returns 1 if the package was already installed and 0 otherwise.
hsun_is_installed() {
    dpkg -l "$1" | grep -q ^ii && msg "Installed already" && return 1
    return 0
}

export -f hsun_try_install
export -f hsun_is_installed

