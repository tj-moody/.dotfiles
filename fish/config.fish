if status is-interactive
    # Commands to run in interactive sessions can go here
    # global vars
    set -x EDITOR nvim
    # set -x COLORS_NAME noclownfiesta
    export COLORS_NAME=noclownfiesta
    set fish_greeting

    # Path
    set PATH /usr/local/bin $PATH
    set PATH /Users/tj/.local/share/bob/nvim-bin/ $PATH
    set PATH $HOME/.cargo/bin $PATH
    set PATH /opt/homebrew/bin/ $PATH

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
    [ ! -z "$kittypath" ] && set -gx TERM xterm-kitty

    # Prompt
    # set -gx PS1 "\e[33m\u \e[0;35m\W\e[0m "

    # Aliases
    alias nv "nvim"
    alias src "fish"
    alias lzg "lazygit"
    alias gs "git status"
end
