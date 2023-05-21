function l
    exa -al --icons --group-directories-first $argv
end

function lt
    exa -al --tree --icons --group-directories-first --ignore-glob="*.git*" $argv
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

function speedtest
    speedtest-rs
end

function theme
    if [ "0" != "$(count $argv)" ]
        echo $COLORS_NAME
        return
    end
    echo "  1) noclownfiesta"
    echo "  2) kanagawa"
    echo "  3) kanagawa_muted"
    echo "  4) gruvbox"
    echo "  5) marsbox"
    echo ""
    printf "> "
    read -l -P '> ' themename
    switch $themename
        case 1
            set name noclownfiesta
        case 2
            set name kanagawa
        case 3
            set name kanagawa_muted
        case 4
            set name gruvbox
        case 5
            set name marsbox
        case '*'
            echo $COLORS_NAME
            return
    end
    export COLORS_NAME=$name
    echo -e "\033]50;SetProfile=$name\a"
end

function ccompile
    gcc -o $1 $1.c
end

function dev
    cd ~/Documents/dev/"$argv"
end

function dot
    cd ~/.dotfiles/"$argv"
end

function config
    cd ~/.config/"$argv"
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

function chwall
    wal -qsti /Users/tj/Documents/tjwallpapers/used/
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
