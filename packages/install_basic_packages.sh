#!/usr/bin/env bash

banner "Try to install package tmux"
hsun_try_install tmux

banner "Try to install package safe-rm"
hsun_try_install safe-rm

banner "Try to install package numactl"
hsun_try_install numactl

banner "Try to install package tree"
hsun_try_install tree

# JDK dependencies
banner "Try to install OpenJDK dependencies"
hsun_try_install libasound2-dev
hsun_try_install libcups2-dev
hsun_try_install libfontconfig1-dev
hsun_try_install libx11-dev
hsun_try_install libxext-dev
hsun_try_install libxrender-dev
hsun_try_install libxrandr-dev
hsun_try_install libxtst-dev
hsun_try_install libxt-dev

