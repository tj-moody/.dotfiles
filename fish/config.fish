if status is-interactive
    # Commands to run in interactive sessions can go here
    # global vars
    set -x EDITOR nvim
    export COLORS_NAME=$(cat ~/.dotfiles/.theme.txt)
    set fish_greeting

    fish_vi_key_bindings
    bind -M insert -M default -M visual ctrl-f edit_command_buffer

    # Path
    fish_add_path /opt/zerobrew/bin
    fish_add_path /usr/local/bin
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.local/share/bob/nvim-bin/
    fish_add_path $HOME/.cargo/bin
    fish_add_path /Qt/5.15.2/clang_64/bin/
    fish_add_path $HOME/go/bin/
    fish_add_path $HOME/packages/potion/bin
    fish_add_path $HOME/.modular/pkg/packages.modular.com_mojo/bin
    fish_add_path $HOME/.dotfiles/scripts
    fish_add_path $HOME/.config/emacs/bin
    fish_add_path /usr/local/opt/texinfo/bin
    fish_add_path /opt/zerobrew/prefix/Cellar/gcc/13.2.0/bin
    fish_add_path /opt/zerobrew/prefix/opt/libpq/bin

    fish_add_path /opt/zerobrew/prefix/opt/openjdk/bin
    export JAVA_HOME="/opt/zerobrew/prefix/opt/openjdk/bin"

    # export GIT_EXEC_PATH="/opt/zerobrew/prefix/opt/git/libexec/git-core/"

    # export CPATH="/opt/zerobrew/prefix/include"
    # export LIBRARY_PATH="/opt/zerobrew/prefix/lib"

    export FZF_DEFAULT_OPTS="--border=none --no-scrollbar --preview 'bat --style=numbers --color=always --line-range :500 {}' --layout reverse --height=40% --padding=1 --info=inline --color='bg+:-1,prompt:2,pointer:1,border:8'"
    export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git/'"

    export PRETTIERD_DEFAULT_CONFIG="../.prettierrc"

    . ~/.dotfiles/.env

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
    set -gx TERM wezterm

    # Aliases
    alias nv       "$HOME/.local/share/bob/nvim-bin/nvim"
    alias nvupdate "$HOME/.dotfiles/bash/nvu.bash"
    alias src      "source ~/.config/fish/config.fish"
    alias lg       "lazygit"
    alias gs       "git status"
    alias md       "glow" # https://github.com/charmbracelet/glow
    alias snip     "nap" # https://github.com/maaslalani/nap
    alias ssh      "$HOME/.dotfiles/bash/ssh.bash"
    alias sshr     "/usr/bin/ssh"
    alias oc       "sudo -u agent zsh -c 'cd $(pwd) && opencode'"

    alias pond     "pond -db"
    alias arttime  "arttime -a skull3 --nolearn -t 'Death is nothing at all' --ac 4"
    alias wtf      "wtfutil" # https://wtfutil.com/
    alias ckan     "pushd .; cd '/Applications/CKAN.app/Contents/MacOS'; '/Library/Frameworks/Mono.framework/Versions/Current/Commands/mono' 'ckan.exe' prompt; popd"

    alias clang-tidy /opt/zerobrew/prefix/opt/llvm/bin/clang-tidy
end

# Setting PATH for Python 3.11
# The original version is saved in $HOME/.config/fish/config.fish.pysave
# fish_add_path (brew --prefix python@3.14)/libexec/bin
set -l py_path (brew --prefix python@3.14)/libexec/bin
# fish_add_path $py_path


# bun
set --export BUN_INSTALL "$HOME/.bun"
# fish_add_path $BUN_INSTALL/bin
