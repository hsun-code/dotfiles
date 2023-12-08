#!/usr/bin/env bash

# Reference: https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source

# Note-1: we assume that if there exists one neovim installed already,
# it should be installed in the same way. Otherwise, we may not find the
# expected binary and I'm afraid the uninstall process doesn't work either.

source $HOME/hsun-code.code/dotfiles/packages/helper.sh

hsun_echo "Try to install package neovim"

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
    echo "Has neovim, but not v${nvim_version}"
    need_install=true
    need_uninstall=true
  else
    echo "Installed already"
  fi
else
  echo "No neovim"
  need_install=true
fi

#
# Uninstall the existing neovim, which is not our target version
#
if [[ "$need_uninstall" = true ]]; then
  # Reference https://github.com/neovim/neovim/wiki/Installing-Neovim#uninstall
  echo "Uninstall old neovim"
  sudo rm $nvim_bin
  sudo rm -r "/usr/local/share/nvim/"
  echo "Uninstall finish"
# TODO: remove more temp data?
# rm -rf ~/.config/nvim
# rm -rf ~/.local/share/nvim
fi

#
# Install the neovim we want to install
#
if [[ "$need_install" = true ]]; then
  echo "Build prerequisites"
  if is_fedora; then
    # TODO: not sure if the names are correct...
    hsun_fedora_try_install ninja-build gettext libtool libtool-bin autoconf
    hsun_fedora_try_install automake cmake g++ pkg-config unzip curl doxygen
  else
    hsun_ubuntu_try_install autoconf automake cmake curl doxygen g++ gettext
    hsun_ubuntu_try_install libtool libtool-bin ninja-build pkg-config unzip
  fi

  nvim_src="/tmp/nvim_${RANDOM}"
  echo "Download the source code into $nvim_src"
  git clone --branch $nvim_branch --depth 1 $nvim_git_url $nvim_src

  echo "Install neovim"
  cd $nvim_src; make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd -
  rm -rf $nvim_src 
  $nvim_bin -v
  echo "Install finish"
fi

#
# Install NvChad's prerequisites
#
hsun_echo "Try to install NvChad's prerequisites"
echo "install ripgrep: Required for grep searching with Telescope plugin"
echo "install ccls"
if is_fedora; then
  hsun_fedora_try_install ripgrep
else
  hsun_ubuntu_try_install ccls
  hsun_ubuntu_try_install nodejs
  hsun_ubuntu_try_install npm
  hsun_ubuntu_try_install python3-venv
  hsun_ubuntu_try_install ripgrep
fi

