#!/opt/homebrew/bin/bash

while true; do
    /Users/tj/.local/share/bob/nvim-bin/nvim --cmd "let g:tj_reloaded = 'true'" "$@"
    if [ $? -ne 1 ]; then
        break
    fi
done
