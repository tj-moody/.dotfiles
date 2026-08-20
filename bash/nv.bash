#!/usr/bin/env bash

while true; do
    /Users/tj/.local/share/bob/nvim-bin//nvim "$@"

    status="$?"
    set --
    if [ "$status" == "3" ]; then
        ~/.dotfiles/scripts/theme
    elif [ "$status" != "5" ]; then
        break
    fi
done
exit 0
