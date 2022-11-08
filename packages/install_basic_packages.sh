#!/usr/bin/env bash

# returns 1 if the package was already installed and 0 otherwise.
# The first argument is the package name to be checked (and installed if not already).
# other arguments are passed to apt-get
try_install() {
    dpkg -l "$1" | grep -q ^ii && msg "$1: Installed already" && return 1
    sudo apt-get -y install "$@"
    return 0
}

# returns 1 if the package was already installed and 0 otherwise.
is_installed() {
    dpkg -l "$1" | grep -q ^ii && msg "Installed already" && return 1
    return 0
}

#######################################

banner "Try to install package tmux"
try_install tmux

banner "Try to install package safe-rm"
try_install safe-rm

banner "Try to install package numactl"
try_install numactl

# JDK dependencies
banner "Try to install OpenJDK dependencies"
try_install libasound2-dev
try_install libcups2-dev
try_install libfontconfig1-dev
try_install libx11-dev
try_install libxext-dev
try_install libxrender-dev
try_install libxrandr-dev
try_install libxtst-dev
try_install libxt-dev

# Neovim
banner "Try to install package neovim"
is_installed neovim
if [[ $? -eq 0 ]];  then
  # https://github.com/neovim/neovim/wiki/Installing-Neovim
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get install -y neovim
fi

banner "Try to install Neovim dependencies"

msg "Try to install package Packer"
packer_dir="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim/"
if [[ -d "$packer_dir" ]]; then
  msg "Installed already"
else
  git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_dir
  msg "Done"
fi

msg "Try to install package nodejs 14"
is_installed nodejs
if [[ $? -eq 0 ]];  then
  curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
  sudo apt-get update
  sudo apt-get install -y nodejs
fi

# try_install npm

