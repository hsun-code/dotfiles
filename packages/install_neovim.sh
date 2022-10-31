#!/usr/bin/env bash

# returns 1 if the package was already installed and 0 otherwise.
is_installed() {
    dpkg -l "$1" | grep -q ^ii && msg "Installed already" && return 1
    return 0
}

banner "Try to install package neovim"
is_installed neovim
if [[ $? -eq 0 ]];  then
  # https://github.com/neovim/neovim/wiki/Installing-Neovim
  sudo add-apt-repository ppa:neovim-ppa/stable
  sudo apt-get update
  sudo apt-get install -y neovim
fi

banner "Try to install package Packer"
packer_dir="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim/"
if [[ -d "$packer_dir" ]]; then
  msg "Installed already"
else
  git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_dir
  msg "Done"
fi

