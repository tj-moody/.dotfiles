#!/bin/bash
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR='nvim'
# export TERM='xterm-kitty'

kittypath="$(which kitty)"
[ ! -z "$kittypath" ] && export TERM='xterm-kitty'

# PATH
eval "$(/opt/homebrew/bin/brew shellenv)"
source ~/.cargo/env
export PATH="/Users/tj/.local/share/bob/nvim-bin:$PATH"
	
# PROMPT
export PS1="\e[33m\u \e[0;35m\W\e[0m "

# Zoxide Setup
[ -z "$IS_INIT_ZOXIDE" ] && eval "$(zoxide init bash)"
export IS_INIT_ZOXIDE='true'

# ALIASES
alias nv="nvim"
alias src="source /Users/tj/.bashrc"
alias lg="lazygit"

. ~/.dotfiles/bash/functions.sh
