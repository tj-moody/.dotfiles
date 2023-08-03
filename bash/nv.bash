#!/opt/homebrew/bin/bash

/Users/tj/.local/share/bob/nvim-bin/nvim "$@"
while true; do
    /Users/tj/.local/share/bob/nvim-bin/nvim +SessionRestore "$@"  # change path to real nvim binary as necessary
    if [ $? -ne 1 ]; then
        break
    fi
done
