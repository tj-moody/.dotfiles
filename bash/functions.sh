#!/bin/bash

l() { exa -al --icons; }
lds() { exa -alD --icons; }
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
