#!/opt/homebrew/bin/bash

while true; do
    /Users/tj/.local/share/bob/v0.11.1/bin/nvim --cmd "let g:tj_reloaded = 'true'" "$@"
    if [ $? -ne 1 ]; then
        break
    fi
done
