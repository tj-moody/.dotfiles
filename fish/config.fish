if status is-interactive
    # Commands to run in interactive sessions can go here
    # global vars
    set -x EDITOR nvim
    export COLORS_NAME=$(cat ~/.config/.COLORS_NAME.txt)
    echo -e "\033]50;SetProfile=$COLORS_NAME\a"
    set fish_greeting

    # Path
    set PATH /usr/local/bin $PATH
    set PATH /Users/tj/.local/share/bob/nvim-bin/ $PATH
    set PATH $HOME/.cargo/bin $PATH
    set PATH /opt/homebrew/bin/ $PATH
    set PATH /opt/homebrew/anaconda3/bin/ $PATH
    set PATH /Qt/5.15.2/clang_64/bin/ $PATH

    # Init
    # Starship
    function starship_transient_prompt_func
        starship module character
    end
    function starship_transient_rprompt_func
        echo -n ""
    end
    starship init fish | source
    enable_transience
    zoxide init fish | source

    # Kitty
    set kittypath (which kitty)
    [ ! -z "$kittypath" ] && set -gx TERM xterm-kitty && kitty +kitten themes --reload-in=all $COLORS_NAME

    # Prompt
    # set -gx PS1 "\e[33m\u \e[0;35m\W\e[0m "

    # Aliases
    alias nv "nvim"
    alias src "fish"
    alias lg "lazygit"
    alias gs "git status"
end

# Setting PATH for Python 3.11
# The original version is saved in /Users/tj/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/anaconda3/bin/conda
    eval /opt/homebrew/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

