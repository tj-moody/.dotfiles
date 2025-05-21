#!/opt/homebrew/bin/bash

first="true"
while true; do
    if [[ "$first" == "true" ]]; then
        first="false"
        /Users/tj/.local/share/bob/v0.11.1/bin/nvim "$@"
    else
        /Users/tj/.local/share/bob/v0.11.1/bin/nvim "$@"
    fi
    status="$?"
    if [ "$status" == "3" ]; then
        bash ~/.dotfiles/bash/theme.bash arg
    elif [ "$status" != "5" ]; then
        break
    fi
done
