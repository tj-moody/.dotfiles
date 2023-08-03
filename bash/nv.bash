#!/opt/homebrew/bin/bash

first="true"
while true; do
    if [[ "$first" == "true" ]]; then
        first="false"
        /Users/tj/.local/share/bob/nvim-bin/nvim "$@"
    else
        /Users/tj/.local/share/bob/nvim-bin/nvim +SessionRestore "$@"
    fi
    if [ $? -ne 1 ]; then
        break
    fi
done
