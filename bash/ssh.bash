#!/usr/bin/env bash

function ssh_cleanup {
    printf '\x1b]104'
    echo -ne "\033]50;SetProfile=$COLORS_NAME\a"
    echo -ne "\033]1337;SetUserVar=COLORS_NAME=$(echo -n "$COLORS_NAME" | base64)\007"
}

printf "\x1b]11;#0a0c21\x1b\\"
trap ssh_cleanup SIGINT SIGTERM EXIT
/usr/bin/ssh "$@"
