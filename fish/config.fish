if status is-interactive
    # Commands to run in interactive sessions can go here
    # global vars
    set -x EDITOR nvim
    export COLORS_NAME=$(cat ~/.config/.COLORS_NAME.txt)
    echo -ne "\033]50;SetProfile=$COLORS_NAME\a"
    set fish_greeting

    # Path
    set PATH /usr/local/bin $PATH
    set PATH ~/.local/bin $PATH
    set PATH /Users/tj/.local/share/bob/nvim-bin/ $PATH
    set PATH $HOME/.cargo/bin $PATH
    set PATH /opt/homebrew/bin/ $PATH
    set PATH /opt/homebrew/anaconda3/bin/ $PATH
    set PATH /Qt/5.15.2/clang_64/bin/ $PATH
    set PATH ~/go/bin/ $PATH

    # Init
    # Starship
    function starship_transient_prompt_func
        # echo -e "$(starship module directory)$(starship module character)"
        echo -e "$(starship module directory): "
    end
    # function starship_transient_rprompt_func
    #     echo -e "at \e[1;33m$(date +"%H:%M")\e[0m"
    # end
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
    alias src "source ~/.config/fish/config.fish"
    alias lg "lazygit"
    alias gs "git status"
    alias md "glow"

    alias pond "pond -db"
    alias arttime "arttime -a skull3 --nolearn -t 'Death is nothing at all' --ac 4"
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

