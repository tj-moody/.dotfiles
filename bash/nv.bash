#!/opt/homebrew/bin/bash

first="true"
while true; do
    nvim "$@"
    status="$?"
    if [ "$status" == "3" ]; then
        bash ~/.dotfiles/bash/theme.bash arg
    elif [ "$status" != "5" ]; then
        break
    fi
done
