#!/opt/homebrew/bin/bash

first="true"
while true; do
    /Users/tj/.local/share/bob/v0.11.1/bin/nvim "$@"
    status="$?"
    if [ "$status" == "3" ]; then
        bash ~/.dotfiles/bash/theme.bash arg
    elif [ "$status" != "5" ]; then
        break
    fi
done
exit 0
