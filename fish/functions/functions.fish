function l
    exa -al --icons
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

function speedtest
    speedtest-rs
end

function theme
    echo "  1) noclownfiesta"
    echo "  2) kanagawa"
    echo ""
    printf "> "
    read -l -P '> ' themename
    switch $themename
        case 1
            export COLORS_NAME=noclownfiesta
        case 2
            export COLORS_NAME=kanagawa
        case '*'
            echo $COLORS_NAME
    end
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
