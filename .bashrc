#!/bin/bash
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR='nvim'

kittypath="$(which kitty)"
[ -n "$kittypath" ] && export TERM='xterm-kitty'

# PATH
eval "$(/opt/homebrew/bin/brew shellenv)"
source "$HOME/.cargo/env"
export PATH="/Users/tj/.local/share/bob/nvim-bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/Users/tj/.dotfiles/bash/*.bash:$PATH"

# PROMPT
export PS1="\[\033[33m\]\u \[\033[0;35m\]\W\[\033[0m\] "

# Zoxide Setup
[ -z "$IS_INIT_ZOXIDE" ] && eval "$(zoxide init bash)"
export IS_INIT_ZOXIDE='true'
eval "$(starship init bash)"

# ALIASES
alias nv="nvim"
alias src="source /Users/tj/.bashrc"
alias lg="lazygit"
alias gs="git status"
alias l="exa -al --icons --group-directories-first"
