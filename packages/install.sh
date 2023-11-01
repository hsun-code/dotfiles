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
elif is_fedora; then
  # common ones
  hsun_echo "fedora: try to install common packages"
  hsun_fedora_try_install bash-completion gdb numactl tmux tree
  # JDK related
  hsun_echo "fedora: try to install JDK related packages"
  hsun_fedora_try_install alsa-lib-devel cups-devel fontconfig-devel
  hsun_fedora_try_install libX11-devel libXext-devel libXrender-devel
  hsun_fedora_try_install libXrandr-devel libXtst-devel libXt-devel
else
  # common ones
  hsun_echo "ubuntu: try to install common packages"
  hsun_ubuntu_try_install numactl tmux tree
  # JDK related
  hsun_echo "ubuntu: try to install JDK related packages"
  hsun_ubuntu_try_install libasound2-dev libcups2-dev libfontconfig1-dev
  hsun_ubuntu_try_install libx11-dev libxext-dev libxrender-dev libxrandr-dev
  hsun_ubuntu_try_install libxtst-dev libxt-dev
fi

#
# install neovim only on linux
#

if ! is_macos; then
  hsun_echo "ubuntu: try to install neovim"
  bash $HSUN_DOTS/packages/install_neovim.sh
fi

