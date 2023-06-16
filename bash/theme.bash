#!/opt/homebrew/bin/bash

if [[ $# -ne 1 ]]; then
    exit
fi

tput civis
printf '\e[?1049h'
MAX_INDEX=6
index=$MAX_INDEX
THEME=$1
theme=$THEME

case $theme in
    "noclownfiesta")
        index=6
        ;;
    "kanagawa")
        index=5
        ;;
    "kanagawa_muted")
        index=4
        ;;
    "gruvbox")
        index=3
        ;;
    "marsbox")
        index=2
        ;;
    "tokyonight")
        index=1
        ;;
    "oxocarbon")
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

index_to_theme() {
    case $1 in
        6)
            echo "noclownfiesta"
            ;;
        5)
            echo "kanagawa"
            ;;
        4)
            echo "kanagawa_muted"
            ;;
        3)
            echo "gruvbox"
            ;;
        2)
            echo "marsbox"
            ;;
        1)
            echo "tokyonight"
            ;;
        0)
            echo "oxocarbon"
            ;;
    esac
}


print_themes() {
    exa -al --icons; echo ""
    case $1 in
        6)
            echo -e "> \e[0;34m noclownfiesta  \e[0m"
            echo -e "  \e[1;36m kanagawa       \e[0m"
            echo -e "  \e[0;36m kanagawa_muted \e[0m"
            echo -e "  \e[0;33m gruvbox        \e[0m"
            echo -e "  \e[0;31m marsbox        \e[0m"
            echo -e "  \e[0;34m tokyonight     \e[0m"
            echo -e "  \e[0;32m oxocarbon      \e[0m"
            ;;
        5)
            echo -e "  \e[0;34m noclownfiesta  \e[0m"
            echo -e "> \e[1;36m kanagawa       \e[0m"
            echo -e "  \e[0;36m kanagawa_muted \e[0m"
            echo -e "  \e[0;33m gruvbox        \e[0m"
            echo -e "  \e[0;31m marsbox        \e[0m"
            echo -e "  \e[0;34m tokyonight     \e[0m"
            echo -e "  \e[0;32m oxocarbon      \e[0m"
            ;;
        4)
            echo -e "  \e[0;34m noclownfiesta  \e[0m"
            echo -e "  \e[1;36m kanagawa       \e[0m"
            echo -e "> \e[0;36m kanagawa_muted \e[0m"
            echo -e "  \e[0;33m gruvbox        \e[0m"
            echo -e "  \e[0;31m marsbox        \e[0m"
            echo -e "  \e[0;34m tokyonight     \e[0m"
            echo -e "  \e[0;32m oxocarbon      \e[0m"
            ;;
        3)
            echo -e "  \e[0;34m noclownfiesta  \e[0m"
            echo -e "  \e[1;36m kanagawa       \e[0m"
            echo -e "  \e[0;36m kanagawa_muted \e[0m"
            echo -e "> \e[0;33m gruvbox        \e[0m"
            echo -e "  \e[0;31m marsbox        \e[0m"
            echo -e "  \e[0;34m tokyonight     \e[0m"
            echo -e "  \e[0;32m oxocarbon      \e[0m"
            ;;
        2)
            echo -e "  \e[0;34m noclownfiesta  \e[0m"
            echo -e "  \e[1;36m kanagawa       \e[0m"
            echo -e "  \e[0;36m kanagawa_muted \e[0m"
            echo -e "  \e[0;33m gruvbox        \e[0m"
            echo -e "> \e[0;31m marsbox        \e[0m"
            echo -e "  \e[0;34m tokyonight     \e[0m"
            echo -e "  \e[0;32m oxocarbon      \e[0m"
            ;;
        1)
            echo -e "  \e[0;34m noclownfiesta  \e[0m"
            echo -e "  \e[1;36m kanagawa       \e[0m"
            echo -e "  \e[0;36m kanagawa_muted \e[0m"
            echo -e "  \e[0;33m gruvbox        \e[0m"
            echo -e "  \e[0;31m marsbox        \e[0m"
            echo -e "> \e[0;34m tokyonight     \e[0m"
            echo -e "  \e[0;32m oxocarbon      \e[0m"
            ;;
        0)
            echo -e "  \e[0;34m noclownfiesta  \e[0m"
            echo -e "  \e[1;36m kanagawa       \e[0m"
            echo -e "  \e[0;36m kanagawa_muted \e[0m"
            echo -e "  \e[0;33m gruvbox        \e[0m"
            echo -e "  \e[0;31m marsbox        \e[0m"
            echo -e "  \e[0;34m tokyonight     \e[0m"
            echo -e "> \e[0;32m oxocarbon      \e[0m"
            ;;
        *)
            return
            ;;
    esac
    echo -e "\033]50;SetProfile=$(index_to_theme $1)\a"
}

while : ; do
    cleard
    print_themes $index
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
