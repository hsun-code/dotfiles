#!/usr/bin/env bash

source $HOME/hsun-code.code/dotfiles/packages/helper.sh

#
# Install common packages
#

if is_macos; then
  hsun_macos_try_install bash-completion
  # Install common utilities.
  # Install coreutils for shell 'realpath command not found' issue.
  brew install vim wget curl git tree procmail jq ed findutils gawk grep make bash
  brew install gnutls gnu-sed gnu-tar gnu-indent gnu-getopt coreutils openldap autoconf
  brew install binutils diffutils gnu-which gzip screen watch wdiff gpatch less
  brew install openssh perl rsync unzip file-formula bash-completion mysql-client@8.0
  # Install dot
  brew install graphviz
else
  # common ones
  hsun_ubuntu_try_install tmux numactl tree
  # JDK related
  hsun_ubuntu_try_install libasound2-dev libcups2-dev libfontconfig1-dev
  hsun_ubuntu_try_install libx11-dev libxext-dev libxrender-dev libxrandr-dev
  hsun_ubuntu_try_install libxtst-dev libxt-dev
fi

# install neovim only on ubuntu
if ! is_macos; then
  bash $HSUN_DOTS/packages/install_neovim.sh
fi

