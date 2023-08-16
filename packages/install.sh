#!/usr/bin/env bash

source $HOME/hsun-code.code/dotfiles/packages/helper.sh

if is_macos; then
  hsun_macos_try_install bash-completion
else
  bash $HSUN_DOTS/packages/install_basic_packages.sh
fi

# install neovim only on ubuntu
if ! is_macos; then
  bash $HSUN_DOTS/packages/install_neovim.sh
fi

