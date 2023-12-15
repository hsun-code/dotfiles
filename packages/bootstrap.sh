#!/usr/bin/env bash

source ./helper.sh

#
# download hsun-code repos
#

hsun_echo "Download hsun-code repos"

# check the exisitence of ssh-key
if [[ ! -f "$HOME/.ssh/id_ed25519.pub" ]] ; then
  hsun_error "Fail: no ssh key"
fi

# create the repo dir
mkdir -p "$HSUN_CODE"

# download the following repos
_repos=("dotfiles" "misc" "NvChad" "hsun-code.github.io" "toyc")
_prefix="git@github.com:hsun-code"

for _repo in ${_repos[@]} ;  do
  hsun_echo "Try to download repo: $_repo"
  if [[ -d "$HSUN_CODE/$_repo" ]] ; then
    echo "$_repo exists. pass"
  else
    git clone "$_prefix/$_repo.git" "$HSUN_CODE/$_repo"
  fi
done

#
# dotfiles: install packages
#

hsun_echo "Install packages and init dotfiles"
bash "$HSUN_DOTS/packages/install.sh"
bash "$HSUN_DOTS/install"

#
# source .bash_profile
#

hsun_echo "Finish: please run: source ~/.bash_profile"

