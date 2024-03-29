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
HSUN_LIBS="$HOME/libs"
HSUN_CODE="$HOME/hsun-code.code"
HSUN_DOTS="$HSUN_CODE/dotfiles"
HSUN_NVIM="$HSUN_CODE/NvChad"

export HSUN_LIBS
export HSUN_CODE
export HSUN_DOTS
export HSUN_NVIM

###################
# helper functions
###################

# echo one message with delimeter
hsun_echo() {
  ECHO_LINE="######################################"
  echo ""
  echo "$ECHO_LINE"
  echo "$@"
  echo "$ECHO_LINE"
  echo ""
}

hsun_error() {
  ECHO_LINE="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  echo "$ECHO_LINE"
  echo "$@"
  exit 1
}

# check the underlying OS
hsun_is_macos() {
  if [[ "$(uname -s)" = Darwin* ]]; then
    return 0
  else
    return 1
  fi
}

hsun_is_fedora() {
  grep "ID=fedora" /etc/os-release
  return $?
}

# return the number of logical cpus
hsun_ncpu() {
  if hsun_is_macos; then
    sysctl -n hw.logicalcpu
  else
    nproc
  fi
}

# macos
# try to install one list of packages via homebrew
hsun_macos_try_install() {
  for package in "$@";
  do
    if brew list -q "$package" > /dev/null; then
      echo "Installed already: $package "
    else
      echo "Try to install: $package"
      brew install "$package"
    fi
  done
}

# fedora
# try to install one list of packages via dnf
hsun_fedora_try_install() {
  for package in "$@";
  do
    if dnf list installed | grep -q "$package" ; then
      echo "Installed already: $package "
    else
      echo "Try to install: $package"
      sudo dnf -y install "$package"
    fi
  done
}

# ubuntu
# try to install one list of packages via apt-get
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
export -f hsun_is_fedora
export -f hsun_macos_try_install
export -f hsun_fedora_try_install
export -f hsun_ubuntu_try_install
export -f hsun_ubuntu_is_installed

###################
# LD_LIBRARY_PATH
###################

# include HSUN_LIBS
if [[ "$LD_LIBRARY_PATH" != *"$HSUN_LIBS:"* ]]; then
  export LD_LIBRARY_PATH="$HSUN_LIBS:$LD_LIBRARY_PATH"
fi
hsun_echo "LD_LIBRARY_PATH:$LD_LIBRARY_PATH"

