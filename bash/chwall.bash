#!/opt/homebrew/bin/bash

if [[ $# -ne 0 ]]; then
    exit
fi

tput civis

declare -a wallstrings=(
    "\e[1;36mmountains1   \e[0m"
    "\e[1;33mplains1      \e[0m"
    "\e[1;36mredsunset    \e[0m"
    "\e[0;34msucculents   \e[0m"
    "\e[1;36mpurpleclouds \e[0m"
)

MAX_INDEX=4

INDEX=$(sed '2q;d' ~/.config/.WallPath.txt)
index=$INDEX

print_walls() {
    index=$1
    for i in "${!wallstrings[@]}"; do
        if [[ $i -eq $index ]]; then
            echo -n "> "
        else
            echo -n "  "
        fi
        echo -e "${wallstrings[$i]}"
    done
}

PHOTOS_PATH="$HOME/Documents/tjwallpapers/used/"
change_wallpaper() {
    case $1 in
        0)
            echo -e "${PHOTOS_PATH}mountains1.jpg\n$1" \
                > ~/.config/.WallPath.txt
            ;;
        1)
            echo -e "${PHOTOS_PATH}plains1.jpg\n$1" \
                > ~/.config/.WallPath.txt
            ;;
        2)
            echo -e "${PHOTOS_PATH}redcloudysunset.jpg\n$1" \
                > ~/.config/.WallPath.txt
            ;;
        3)
            echo -e "${PHOTOS_PATH}succulents.jpg\n$1" \
                > ~/.config/.WallPath.txt
            ;;
        4)
            echo -e "${PHOTOS_PATH}purpleclouds.jpg\n$1" \
                > ~/.config/.WallPath.txt
            ;;
    esac
    m wallpaper "$(sed '1q;d' ~/.config/.WallPath.txt)"
}

while : ; do
    print_walls "$index"
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
            change_wallpaper "$index"
            ;;
        'q')
            echo -e "${wallstrings[$index]}"
            break
            ;;
        *)
            :
            ;;
    esac
done

tput cnorm
