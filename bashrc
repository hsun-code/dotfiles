#!/bin/bash

PS1='\[\033[4;31;40m\]\u\[\033[00m\]@\h:\[\033[37;40m\]\w\[\033[32;40m\]\$ \[\033[34;40m\]'

# We do this before the following so that all the paths work.
for file in ~/.{aliases,functions,exports}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		# shellcheck source=/dev/null
		source "$file"
	fi
done
unset file

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Workspace
cd ~/ci-scripts; git pull local master; cd ~
source ~/ci-scripts/helper/envsetup.sh

