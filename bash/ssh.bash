#!/usr/bin/env bash

function ssh_cleanup {
    if [[ -z "$TMUX" ]]; then
        printf '\033]104'
    else
        tmux set -p @ssh_host ""
    fi
}

if [[ -z "$TMUX" ]]; then
    printf "\x1b]11;#0a0c21\x1b\\"
else
    tmux set -p @ssh_host "$1"
fi

trap ssh_cleanup SIGINT SIGTERM EXIT
/usr/bin/ssh "$@"
