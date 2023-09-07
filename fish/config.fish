if status is-interactive
    # Commands to run in interactive sessions can go here
    # global vars
    set -x EDITOR nvim
    export COLORS_NAME=$(cat ~/.config/.COLORS_NAME.txt)
    echo -ne "\033]50;SetProfile=$COLORS_NAME\a"
    set fish_greeting

    # Path
    set PATH /usr/local/bin $PATH
    set PATH $HOME/.local/bin $PATH
    set PATH /Users/tj/.local/share/bob/nvim-bin/ $PATH
    set PATH $HOME/.cargo/bin $PATH
    set PATH /opt/homebrew/bin/ $PATH
    set PATH /opt/homebrew/anaconda3/bin/ $PATH
    set PATH /Qt/5.15.2/clang_64/bin/ $PATH
    set PATH $HOME/go/bin/ $PATH
    set PATH $HOME/packages/potion/bin $PATH

    # Init
    # Starship
    function starship_transient_prompt_func
        echo -e "$(starship module directory)$(starship module character)"
    end
    starship init fish | source
    enable_transience
    zoxide init fish | source

    bind -M insert \ce forward-word
    bind -M normal \ce forward-word

    # Kitty
    set kittypath (which kitty)
    [ -n "$kittypath" ] && set -gx TERM xterm-kitty && kitty +kitten themes --reload-in=all $COLORS_NAME

    # Aliases
    alias nv      "/Users/tj/.dotfiles/bash/nv.bash"
    alias nvu     "/Users/tj/.dotfiles/bash/nvu.bash"
    alias src     "source ~/.config/fish/config.fish"
    alias lg      "lazygit"
    alias gs      "git status"
    alias md      "glow" # https://github.com/charmbracelet/glow
    alias snip    "nap" # https://github.com/maaslalani/nap
    alias rm      "trash"

    alias pond    "pond -db"
    alias arttime "arttime -a skull3 --nolearn -t 'Death is nothing at all' --ac 4"
    alias wtf     "wtfutil" # https://wtfutil.com/
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

