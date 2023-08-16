#!/usr/bin/env bash

# Reference: https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source

# Note-1: we assume that if there exists one neovim installed already,
# it should be installed in the same way. Otherwise, we may not find the
# expected binary and I'm afraid the uninstall process doesn't work either.

banner "Try to install package neovim"

nvim_git_url="https://github.com/neovim/neovim.git"
nvim_version="0.9"
nvim_branch="release-${nvim_version}"
nvim_bin="/usr/local/bin/nvim"
need_install=false
need_uninstall=false

#
# Check if there exists the neovim we want to install
#
if [[ -f $nvim_bin ]]; then 
  $nvim_bin -v | grep "NVIM v${nvim_version}"
  if [[ $? == 1 ]]; then
    msg "Has neovim, but not v${nvim_version}"
    need_install=true
    need_uninstall=true
  else
    msg "Installed already"
  fi
else
  msg "No neovim"
  need_install=true
fi

#
# Uninstall the existing neovim, which is not our target version
#
if [[ "$need_uninstall" = true ]]; then
  # Reference https://github.com/neovim/neovim/wiki/Installing-Neovim#uninstall
  msg "Uninstall old neovim"
  sudo rm $nvim_bin
  sudo rm -r "/usr/local/share/nvim/"
  msg "Uninstall finish"
# TODO: remove more temp data?
# rm -rf ~/.config/nvim
# rm -rf ~/.local/share/nvim
fi

#
# Install the neovim we want to install
#
if [[ "$need_install" = true ]]; then
  msg "Build prerequisites"
  sudo apt-get install ninja-build gettext libtool libtool-bin autoconf \
       automake cmake g++ pkg-config unzip curl doxygen

  nvim_src="/tmp/nvim_${RANDOM}"
  msg "Download the source code into $nvim_src"
  git clone --branch $nvim_branch --depth 1 $nvim_git_url $nvim_src

  msg "Install neovim"
  cd $nvim_src; make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd -
  rm -rf $nvim_src 
  $nvim_bin -v
  msg "Install finish"
fi

#
# Install NvChad's prerequisites
#
banner "Try to install NvChad's prerequisites"
msg "install ripgrep: Required for grep searching with Telescope plugin"
hsun_ubuntu_try_install ripgrep

