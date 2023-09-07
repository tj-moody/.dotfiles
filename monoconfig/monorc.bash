#!/bin/bash
#  _             _
# | |_ ___  ___ (_)
# | __/ _ \/ _ \| |
# | ||  __/  __/| |
#  \__\___|\___|/ |
#             |__/
# Minimal bash config with no
# dependencies by TJ Moody
#
# Meant to be used alongside
# my monorc.vim
# https://github.com/tj-moody

export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR="vim"

# Path
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Users/tj/.local/share/bob/nvim-bin/:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/bin/:$PATH"
export PATH="$HOME/go/bin/:$PATH"

# Prompt
export PS1="\[\033[0;90m\]δ \[\033[0;35m\]\W\[\033[0m\] \[\033[0;90m\]::\[\033[0m\] "

# Aliases
alias src="source ~/.bashrc"
alias gs="git status"
alias l="ls -la --color=always"
