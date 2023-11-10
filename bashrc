#!/bin/bash

################
# history      #
################

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

################
# !history    #
################

# PS1 color
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# ls command color
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# env setup for dotfiles
source "${HOME}/hsun-code.code/dotfiles/packages/helper.sh"

# We do this before the following so that all the paths work.
for file in ${HOME}/.{aliases,functions}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# bash completion
if [[ -f /usr/share/bash-completion/bash_completion ]]; then
  # ubuntu: completion for utilities e.g., git docker
  . /usr/share/bash-completion/bash_completion
elif [[ -f /etc/bash_completion ]]; then
  . /etc/bash_completion
elif [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
  # macos: bash completion
  . /opt/homebrew/etc/profile.d/bash_completion.sh
elif [[ -r "/opt/homebrew/etc/bash_completion.d/git-completion.bash" ]]; then
  # macos: git completion
  . /opt/homebrew/etc/bash_completion.d/git-completion.bash
elif [[ -r "/opt/homebrew/etc/bash_completion.d/docker" ]]; then
  # macos: docker completion
  . /opt/homebrew/etc/bash_completion.d/docker
fi

# macos homebrew
if hsun_is_macos; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# export JT_HOME
export JT_HOME=${HSUN_LIBS}/jtreg

#
# Workspace
#

# Always get the latest code for ci-scripts repo and set up the env
cd ${HOME}/ci-scripts && git pull local master && cd -
. ${HOME}/ci-scripts/helper/envsetup.sh

# todo: remove nvim swap files

