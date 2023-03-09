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

theme() {
    echo "  1) noclownfiesta"
    echo "  2) kanagawa"
    echo ""
    printf "> "
    read themename
    case $themename in
        1)
            export COLORS_NAME=noclownfiesta
            ;;
        2)
            export COLORS_NAME=kanagawa
            ;;
        *)
            echo $COLORS_NAME
            ;;
    esac
}

dev() { cd ~/Documents/dev/$1; }
dot() { cd ~/.dotfiles/$1; }
config() { cd ~/.config/$1; }
