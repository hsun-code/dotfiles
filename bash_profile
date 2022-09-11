#!/bin/bash

# Load .bashrc, which loads: ~/.{aliases,functions,exports}
if [[ -r "${HOME}/.bashrc" ]]; then
	# shellcheck source=/dev/null
	source "${HOME}/.bashrc"
fi

