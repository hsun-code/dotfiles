#!/usr/bin/env bash

source $HOME/hsun-code.code/dotfiles/packages/helper.sh

#
# Install common packages
#

if is_macos; then
  hsun_echo "macos: try to install common packages"
  hsun_macos_try_install vim wget curl git tree grep make bash
  hsun_macos_try_install autoconf bash-completion watch less
  hsun_macos_try_install openssh perl graphviz coreutils
  hsun_macos_try_install unzip gzip findutils openldap docker-completion
  # TODO gnu
# brew install gnutls gnu-sed gnu-tar gnu-indent gnu-getopt gawk binutils diffutils gnu-which gpatch
else
  # common ones
  hsun_echo "ubuntu: try to install common packages"
  hsun_ubuntu_try_install tmux numactl tree
  # JDK related
  hsun_echo "ubuntu: try to install JDK related packages"
  hsun_ubuntu_try_install libasound2-dev libcups2-dev libfontconfig1-dev
  hsun_ubuntu_try_install libx11-dev libxext-dev libxrender-dev libxrandr-dev
  hsun_ubuntu_try_install libxtst-dev libxt-dev
fi

#
# install neovim only on ubuntu
#

if ! is_macos; then
  hsun_echo "ubuntu: try to install neovim"
  bash $HSUN_DOTS/packages/install_neovim.sh
fi

