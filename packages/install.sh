#!/usr/bin/env bash

source ./helper.sh

if ! is_macos; then
  bash ./install_basic_packages.sh
fi

# install neovim only on ubuntu
if ! is_macos; then
  bash ./install_neovim.sh
fi

