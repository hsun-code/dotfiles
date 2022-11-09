#!/usr/bin/env bash

# returns 1 if the package was already installed and 0 otherwise.
# The first argument is the package name to be checked (and installed if not already).
# other arguments are passed to apt-get
hsun_try_install() {
    dpkg -l "$1" | grep -q ^ii && msg "$1: Installed already" && return 1
    sudo apt-get -y install "$@"
    return 0
}

# returns 1 if the package was already installed and 0 otherwise.
hsun_is_installed() {
    dpkg -l "$1" | grep -q ^ii && msg "Installed already" && return 1
    return 0
}

export -f hsun_try_install
export -f hsun_is_installed

