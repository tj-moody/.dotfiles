#!/opt/homebrew/bin/bash

if [[ $# -ne 1 ]]; then
    exit
fi

tput civis
printf '\e[?1049h'

declare -a themeslist=(
"\e[0;34m noclownfiesta  \e[0m"
"\e[1;36m kanagawa       \e[0m"
"\e[0;36m kanagawa_dark  \e[0m"
"\e[0;33m gruvbox        \e[0m"
"\e[0;31m marsbox        \e[0m"
"\e[0;34m tokyonight     \e[0m"
"\e[0;32m oxocarbon      \e[0m"
"\e[0;35m catppuccin     \e[0m"
"\e[0;33m everforest     \e[0m"
"\e[0;33m ayu            \e[0m"
)

# MAX_INDEX=8
MAX_INDEX=$( expr ${#themeslist[@]} - 1 )
index=$MAX_INDEX
THEME=$1
theme=$THEME

case $theme in
    "noclownfiesta")
        index=9
        ;;
    "kanagawa")
        index=8
        ;;
    "kanagawa_dark")
        index=7
        ;;
    "gruvbox")
        index=6
        ;;
    "marsbox")
        index=5
        ;;
    "tokyonight")
        index=4
        ;;
    "oxocarbon")
        index=3
        ;;
    "catppuccin")
        index=2
        ;;
    "everforest")
        index=1
        ;;
    "ayu")
        index=0
        ;;
    *)
        index=5
        ;;
esac

cleard() {
    clear
    for (( i=0; i<$LINES; i++)); do
        # echo -ne "\n"
        printf "\n"
    done
}
cleard

# declare
index_to_theme() {
    case $1 in
        9)
            echo "noclownfiesta"
            ;;
        8)
            echo "kanagawa"
            ;;
        7)
            echo "kanagawa_dark"
            ;;
        6)
            echo "gruvbox"
            ;;
        5)
            echo "marsbox"
            ;;
        4)
            echo "tokyonight"
            ;;
        3)
            echo "oxocarbon"
            ;;
        2)
            echo "catppuccin"
            ;;
        1)
            echo "everforest"
            ;;
        0)
            echo "ayu"
            ;;
    esac
}

print_themes() {
    # exa -al --icons; echo ""
    listindex=$( expr $MAX_INDEX - $1 )
    for i in "${!themeslist[@]}"; do
        # echo "$index -> ${arr[$index]}"
        if [[ $i -eq $listindex ]]; then
            echo -n "> "
        else
            echo -n "  "
        fi
        echo -e "${themeslist[$i]}"
    done
    echo -e "\033]50;SetProfile=$(index_to_theme $1)\a"
}

while : ; do
    # cleard
    print_themes $index
    echo -ne "\e[${MAX_INDEX}A"
    echo -ne "\e[2A"
    read -s -p "" -n 1 key
    case $key in
        'j')
            if [[ $index -gt 0 ]]; then
                index=$((index-1))
            else
                index=$MAX_INDEX
            fi
            ;;
        'k')
            if [[ $index -lt $MAX_INDEX ]]; then
                index=$((index+1))
            else
                index=0
            fi
            ;;
        '')
            theme=$(index_to_theme $index)
            # export COLORS_NAME=$theme
            echo $theme > ~/.config/.COLORS_NAME.txt
            echo -e "\033]50;SetProfile=$theme\a"
            if [[ "$TERM" == "xterm-kitty" ]]; then
                kitty +kitten themes --reload-in=all $theme
            fi
            tput cnorm
            printf '\e[?1049l'
            break
            ;;
        'q')
            tput cnorm
            printf '\e[?1049l'
            echo -e "\033]50;SetProfile=$THEME\a"
            if [[ "$TERM" == "xterm-kitty" ]]; then
                kitty +kitten themes --reload-in=all $theme
            fi
            break
            ;;
        *)
            :
            ;;
    esac
done
