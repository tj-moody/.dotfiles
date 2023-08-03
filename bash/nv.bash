#!/opt/homebrew/bin/bash

while true; do
    /Users/tj/.local/share/bob/nvim-bin/nvim "$@"  # change path to real nvim binary as necessary
    if [ $? -ne 1 ]; then
        break
    fi
done
