#!/opt/homebrew/bin/bash

if [[ $# -ne 1 ]]; then
    exit
fi

tput civis

declare -a themestrings=(
    "\e[0;34mnoclownfiesta  \e[0m"
    "\e[1;36mkanagawa       \e[0m"
    "\e[0;33mgruvbox        \e[0m"
    "\e[0;34mtokyonight     \e[0m"
    "\e[0;32moxocarbon      \e[0m"
    "\e[0;35mcatppuccin     \e[0m"
    "\e[0;32meverforest     \e[0m"
    "\e[0;33mayu            \e[0m"
    "\e[0;36mmidnightclub   \e[0m"
    "\e[0;00mbinary         \e[0m"
)

declare -a themeslist=(
    "noclownfiesta"
    "kanagawa"
    "gruvbox"
    "tokyonight"
    "oxocarbon"
    "catppuccin"
    "everforest"
    "ayu"
    "midnightclub"
    "binary"
)

MAX_INDEX=$(( ${#themestrings[@]} - 1 ))
THEME=$1
LIVE_UPDATE=false

index=2
for i in "${!themeslist[@]}"; do
    if [[ "$THEME" == "${themeslist[$i]}" ]]; then
        index=$i
    fi
done

index_to_theme() {
    echo "${themeslist[$1]}";
}

color_terminal() {
    theme=$1
    echo -ne "\033]50;SetProfile=${theme}\a"
    echo -ne "\033]1337;SetUserVar=COLORS_NAME=$(echo -n $theme | base64)\007"
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
    if [[ "$LIVE_UPDATE" == "true" ]]; then
        color_terminal "$(index_to_theme "$1")"
    fi
}

exit_loop() {
    color_terminal "$THEME"
    if [[ "$TERM" == "xterm-kitty" ]]; then
        kitty +kitten themes --reload-in=all "$THEME"
    fi

    for i in "${!themeslist[@]}"; do
        if [[ "$THEME" == "${themeslist[$i]}" ]]; then
            index=$i
        fi
    done
    echo -e "${themestrings[$index]}"
}

while : ; do
    print_themes "$index"
    echo -ne "\e[${MAX_INDEX}A"
    echo -ne "\e[1A"
    read -sr -p "" -n 1 key
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
            THEME=$(index_to_theme "$index")
            echo "$THEME" > ~/.dotfiles/.theme.txt

            exit_loop
            break
            ;;
        'u'|'p')
            if [[ "$LIVE_UPDATE" == "true" ]]; then
                LIVE_UPDATE=false
                color_terminal "$THEME"
            else
                LIVE_UPDATE=true
            fi
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

tput cnorm
