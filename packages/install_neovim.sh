#!/usr/bin/env bash

banner "Try to install package neovim v0.8.0"

nvim_bin="/usr/local/bin/nvim"
need_install=false

if [[ -f $nvim_bin ]]; then 
  $nvim_bin -v | grep "v0.8.0"
  if [[ $? == 1 ]]; then
    msg "Has neovim, but not v0.8.0"
    need_install=true
  else
    msg "Installed already"
  fi
else
  msg "No neovim"
  need_install=true
fi

if [[ "$need_install" = true ]]; then
  banner "Build prerequisites"
  sudo apt-get install ninja-build gettext libtool libtool-bin autoconf \
       automake cmake g++ pkg-config unzip curl doxygen

  nvim_src=/tmp/nvim-0.8
  banner "Download the source code into $nvim_src"
  git clone --branch release-0.8 --depth 1 \
    https://github.com/neovim/neovim.git $nvim_src

  banner "Install neovim"
  cd $nvim_src; make CMAKE_BUILD_TYPE=Release
  sudo make install
  cd -
  rm -rf $nvim_src 
  $nvim_bin -v
  msg "Success"
fi

banner "Try to install NvChad's prerequisites"
# Required for grep searching with Telescope plugin
hsun_try_install ripgrep

