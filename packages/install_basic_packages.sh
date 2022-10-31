#!/usr/bin/env bash

# returns 1 if the package was already installed and 0 otherwise.
# The first argument is the package name to be checked (and installed if not already).
# other arguments are passed to apt-get
try_install() {
    dpkg -l "$1" | grep -q ^ii && msg "Installed already" && return 1
    sudo apt-get -y install "$@"
    return 0
}

banner "Try to install package tmux"
try_install tmux

banner "Try to install package safe-rm"
try_install safe-rm

