#!/opt/homebrew/bin/bash

first="true"
while true; do
    if [[ "$first" == "true" ]]; then
        first="false"
        /Users/tj/.local/share/bob/nvim-bin/nvim "$@"
    else
        /Users/tj/.local/share/bob/nvim-bin/nvim --cmd "let g:tj_reloaded = 'true'" "$@"
    fi
    if [ $? -ne 1 ]; then
        break
    fi
done
