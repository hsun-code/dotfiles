#!/usr/bin/env bash

MY_DOT=$HOME/hsun-code.code/dotfiles
source $MY_DOT/packages/helper.sh
bash $MY_DOT/packages/install_basic_packages.sh
bash $MY_DOT/packages/install_neovim.sh

