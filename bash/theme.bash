#!/opt/homebrew/bin/bash

if [[ $# -ne 1 ]]; then
    exit
fi

tput civis
printf '\e[?1049h'

declare -a themestrings=(
"\e[0;34m noclownfiesta  \e[0m"
"\e[1;36m kanagawa       \e[0m"
"\e[1;34m kanagawa_dark  \e[0m"
"\e[0;33m gruvbox        \e[0m"
"\e[1;31m marsbox        \e[0m"
"\e[0;34m tokyonight     \e[0m"
"\e[0;32m oxocarbon      \e[0m"
"\e[0;35m catppuccin     \e[0m"
"\e[0;33m everforest     \e[0m"
"\e[0;33m ayu            \e[0m"
"\e[0;36m midnightclub   \e[0m"
)

declare -a themeslist=(
"noclownfiesta"
"kanagawa"
"kanagawa_dark"
"gruvbox"
"marsbox"
"tokyonight"
"oxocarbon"
"catppuccin"
"everforest"
"ayu"
"midnightclub"
)

MAX_INDEX=$( expr ${#themestrings[@]} - 1 )
THEME=$1

for i in "${!themeslist[@]}"; do
    index=4 # marsbox
    if [[ "$THEME" == "${themeslist[$i]}" ]]; then
        index=$i
    fi
done

cleard() {
    clear
    for (( i=0; i<$LINES; i++)); do
        # echo -ne "\n"
        printf "\n"
    done
}
cleard

index_to_theme() {
    echo "${themeslist[$1]}";
}

print_themes() {
    index=$1
    for i in "${!themestrings[@]}"; do
        if [[ $i -eq $index ]]; then
            echo -n "> "
        else
            echo -n "  "
        fi
        echo -e "${themestrings[$i]}"
    done
    echo -e "\033]50;SetProfile=$(index_to_theme $1)\a"
}

exit_loop() {
    echo -e "\033]50;SetProfile=$THEME\a"
    if [[ "$TERM" == "xterm-kitty" ]]; then
        kitty +kitten themes --reload-in=all $THEME
    fi

    tput cnorm
    printf '\e[?1049l'
}

while : ; do
    print_themes $index
    echo -ne "\e[${MAX_INDEX}A"
    echo -ne "\e[2A"
    read -s -p "" -n 1 key
    case $key in
        'j')
            if [[ $index -lt $MAX_INDEX ]]; then
                index=$((index+1))
            else
                index=0
            fi
            ;;
        'k')
            if [[ $index -gt 0 ]]; then
                index=$((index-1))
            else
                index=$MAX_INDEX
            fi
            ;;
        '')
            THEME=$(index_to_theme $index)
            echo $THEME > ~/.config/.COLORS_NAME.txt

            exit_loop
            break
            ;;
        'q')
            exit_loop
            break
            ;;
        *)
            :
            ;;
    esac
done
