function l
    exa -al --icons --group-directories-first $argv
end

function lt
    exa -al --tree --icons --group-directories-first \
    --ignore-glob="*.git*" $argv
end

function lds
    exa -alD --icons
end

function cleard
    clear
    for line in (seq $LINES)
        # echo -ne "\n"
        printf "\n"
    end
end

function cl
    cleard;l;echo
end

function wallpaper
    echo $argv[1]
    if not count $argv > /dev/null
        exit 1
    end
    if not test -e $argv[1]
       exit 1
    end
    m wallpaper $argv[1]
end

function theme --argument-names 'themename'
    set themeslist "noclownfiesta"
    set -a themeslist "kanagawa"
    set -a themeslist "kanagawa_dark"
    set -a themeslist "gruvbox"
    set -a themeslist "marsbox"
    set -a themeslist "tokyonight"
    set -a themeslist "oxocarbon"
    set -a themeslist "catppuccin"
    set -a themeslist "everforest"
    set -a themeslist "ayu"
    set -a themeslist "midnightclub"

    if [ "0" != "$(count $argv)" ]
        if contains $themename $themeslist
            set COLORS_NAME $themename
            echo -e "\033]50;SetProfile=$themename\a"
            if [ "$TERM" = "xterm-kitty" ]
                kitty +kitten themes --reload-in=all $themename
            end
        else
            echo $COLORS_NAME
        end

        return
    end

    bash /Users/tj/.dotfiles/bash/theme.bash $COLORS_NAME

    set COLORS_NAME (cat ~/.config/.COLORS_NAME.txt)
end

function chwall
    # if [ "0" != "$(count $argv)" ]
    #     return
    # end
    bash ~/.dotfiles/bash/chwall.bash
    m wallpaper $(sed '1q;d' ~/.config/.WallPath.txt)
end

function ccompile
    gcc -o $argv[1] $argv[1].c
end

function cppcompile
    g++ -o $argv[1] $argv[1].cpp
end

function dev
    cd ~/dev/"$argv"
end

function dot
    cd ~/.dotfiles/"$argv"
end

function config
    cd ~/.config/"$argv"
end

function proj
    cd ~/projects/"$argv"
end

function pack
    cd ~/packages/"$argv"
end

function colortest
    bash /Users/tj/.dotfiles/bash/colortest.bash
end

function nvimspeedtest
    hyperfine "nvim --headless +qa"
end

function splash
    set length $(math $(pfetch | wc -l) + $(exa -al --icons | wc -l) - 4)
    set length $(math $LINES-$length)
    for line in (seq $length)
        printf "\n"
    end
    pfetch
    exa -al --icons
    printf "\n"
end

function git-status-chsh
    set red_text '\e[0;31m'
    set clear_text '\e[0m'
    echo -e "$clear_text  conflict$red_text ="
    echo -e "$clear_text     ahead$red_text ⇡"
    echo -e "$clear_text    behind$red_text ⇣"
    echo -e "$clear_text  diverged$red_text ⇕"
    echo -e "$clear_text untracked$red_text ?"
    echo -e "$clear_text   stashed$red_text \$"
    echo -e "$clear_text  modified$red_text !"
    echo -e "$clear_text    staged$red_text +"
    echo -e "$clear_text   renamed$red_text »"
    echo -e "$clear_text   deleted$red_text ✘"
    echo -e "$clear_text"
end

function fish_mode_prompt
    switch $fish_bind_mode
        case default
        set_color --bold red
        echo 'N'
        case insert
        set_color --bold green
        echo 'I'
        case replace_one
        set_color --bold green
        echo 'R'
        case visual
        set_color --bold brmagenta
        echo 'V'
        case '*'
        set_color --bold red
        echo '?'
    end
    set_color normal
end

function ipglobal
    curl https://ipinfo.io/ip
end
function iplocal
    ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2
end

function conda_auto_env --on-event fish_prompt
    if test -e environment.yml
        set ENV (head -n 1 environment.yml | cut -f2 -d ' ')
        # Check if you are already in the correct environment
        if test $ENV = $CONDA_DEFAULT_ENV
            :
        else
            conda activate $ENV
        end
    else
        if test $CONDA_DEFAULT_ENV = "base"
            :
        else
            conda deactivate
        end
    end
end

function lavat
    ~/packages/lavat/lavat -c magenta -R 5 -F @%#&I!:.
end

function projinit
    if not test -e environment.yml
        echo > projfile.lua 'return {
    ["version"] = "0.1.0",
    ["tasks"] = {
        ["run"] = [[]],
        ["test"] = [[]],
    },
}'
    else
        echo "`projtasks` file already exists."
    end
end

function silent_push
    git push 2> /dev/null > /dev/null &
end

function ssh
    # #191a1c
    # #181a29
    # #371929
    printf '\x1b]11;#0a0c1a\x1b\\'
    /usr/bin/ssh "$argv"
    printf '\x1b]11;#0e0f17\x1b\\'
end
