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
# helper functions
###################

# echo one message with delimeter
hsun_echo() {
  ECHO_LINE="######################################"
  echo "$ECHO_LINE"
  echo "$@"
  echo "$ECHO_LINE"
}

# check if the underlying OS is macos
hsun_is_macos() {
  if [[ "$(uname -s)" = Darwin* ]]; then
    return 0
  else
    return 1
  fi
}

# macos
# install one package via homebrew
hsun_macos_try_install() {
  if brew list -q "$1" > /dev/null; then
    echo "$1: Install already"
  else
    brew install "$1"
  fi
}

# ubuntu
# returns 1 if the package was already installed and 0 otherwise.
# The first argument is the package name to be checked (and installed if not already).
# other arguments are passed to apt-get
hsun_ubuntu_try_install() {
  for package in "$@";
  do
    if dpkg -l "$package" | grep -q ^ii; then
      echo "Installed already: $package "
    else
      echo "Try to install: $package"
      sudo apt-get -y install "$package"
    fi
  done
}

# returns 0 if the package was already installed and 1 otherwise.
hsun_ubuntu_is_installed() {
    dpkg -l "$1" | grep -q ^ii && echo "Installed already" && return 0
    return 1
}

export -f hsun_echo
export -f hsun_is_macos
export -f hsun_macos_try_install
export -f hsun_ubuntu_try_install
export -f hsun_ubuntu_is_installed

###################
# LD_LIBRARY_PATH
###################

# include HSUN_LIBS
MY_LIB_PATH="${HOME}/libs"
if [[ "$LD_LIBRARY_PATH" != *"$HSUN_LIBS:"* ]]; then
  export LD_LIBRARY_PATH="$HSUN_LIBS:$LD_LIBRARY_PATH"
fi
hsun_echo "LD_LIBRARY_PATH:$LD_LIBRARY_PATH"

