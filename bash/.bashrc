#!/bin/bash
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR='nvim'
export TERM='xterm-kitty'

# PATH
eval "$(/opt/homebrew/bin/brew shellenv)"
source ~/.cargo/env
export PATH="/Users/tj/.local/share/bob/nvim-bin:$PATH"
	
# PROMPT
export PS1="\e[33m\u \e[0;35m\W\e[0m "

# ALIASES
alias nv="nvim"
alias l="exa -al --icons"
eval "$(zoxide init bash)"
alias src="source /Users/tj/.bashrc"
alias lg="lazygit"

# FUNCTIONS
cleard() {
	clear
	for (( i=0; i<$LINES; i++)); do
		# echo -ne "\n"
        printf "\n"
	done
}
speedtest() {
    speedtest-rs | grep "Upload\|Download" &
}

dev() { cd ~/Documents/dev/$1; }
dot() { cd ~/.dotfiles/$1; }
config() { cd ~/.config/$1; }
