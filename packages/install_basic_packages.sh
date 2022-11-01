#!/usr/bin/env bash

# returns 1 if the package was already installed and 0 otherwise.
# The first argument is the package name to be checked (and installed if not already).
# other arguments are passed to apt-get
try_install() {
    dpkg -l "$1" | grep -q ^ii && msg "$1: Installed already" && return 1
    sudo apt-get -y install "$@"
    return 0
}

banner "Try to install package tmux"
try_install tmux

banner "Try to install package safe-rm"
try_install safe-rm

# JDK dependencies
banner "Try to install OpenJDK dependencies"
try_install libasound2-dev
try_install libcups2-dev
try_install libfontconfig1-dev
try_install libx11-dev
try_install libxext-dev
try_install libxrender-dev
try_install libxrandr-dev
try_install libxtst-dev
try_install libxt-dev

