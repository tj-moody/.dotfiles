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
    speedtest-rs
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

ccompile() {
    gcc -o $1 $1.c
}

dev() { cd ~/Documents/dev/$1; }
dot() { cd ~/.dotfiles/$1; }
config() { cd ~/.config/$1; }

screensaver() {
    # window size
    W=($(tput cols) $(tput lines))

    # line position (\e[y;xH is 1-based)
    P=(1 1)

    # sweeping direction / increment (inc-x, inc-y)
    D=(1 1)
    # line symbols
    # dir symbol inc-x   -y       idx = (ix * iy + 1) / 2
    #  NE      \     1 * -1 = -1    0
    #  SW      \    -1 *  1 = -1    0
    #  NW      /    -1 * -1 =  1    1
    #  SE      /     1 *  1 =  1    1
    L='\/'


    clear
    while sleep 0.05; do
        ((i = (D[0] * D[1] + 1) / 2))
        echo -ne "\e[${P[1]};${P[0]}H${L:i:1}"
        for i in 0 1; do
            # sweeping by one step
            ((P[i] += D[i]))
            # if out of bound, flip the direction (by * -1), and use the new
            # direction value to compensate to get back into the boundary
            ((P[i] < 1 || P[i] > W[i])) && ((D[i] *= -1, P[i] += D[i]))
        done
    done
}
