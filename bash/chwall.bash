#!/opt/homebrew/bin/bash

if [[ $# -ne 0 ]]; then
    exit
fi

tput civis
printf '\e[?1049h'

MAX_INDEX=4

INDEX=$(sed '2q;d' ~/.config/.WallPath.txt)
index=$INDEX

cleard() {
    clear
    for (( i=0; i<$LINES; i++)); do
        # echo -ne "\n"
        printf "\n"
    done
}
cleard

print_walls() {
    case $1 in
        4)
            echo -e "> \e[1;36m mountains1   \e[0m"
            echo -e "  \e[1;33m plains1      \e[0m"
            echo -e "  \e[1;36m redsunset    \e[0m"
            echo -e "  \e[0;34m succulents   \e[0m"
            echo -e "  \e[1;36m purpleclouds \e[0m"
            ;;
        3)
            echo -e "  \e[1;36m mountains1   \e[0m"
            echo -e "> \e[1;33m plains1      \e[0m"
            echo -e "  \e[1;36m redsunset    \e[0m"
            echo -e "  \e[0;34m succulents   \e[0m"
            echo -e "  \e[1;36m purpleclouds \e[0m"
            ;;
        2)
            echo -e "  \e[1;36m mountains1   \e[0m"
            echo -e "  \e[1;33m plains1      \e[0m"
            echo -e "> \e[1;36m redsunset    \e[0m"
            echo -e "  \e[0;34m succulents   \e[0m"
            echo -e "  \e[1;36m purpleclouds \e[0m"
            ;;
        1)
            echo -e "  \e[1;36m mountains1   \e[0m"
            echo -e "  \e[1;33m plains1      \e[0m"
            echo -e "  \e[1;36m redsunset    \e[0m"
            echo -e "> \e[0;34m succulents   \e[0m"
            echo -e "  \e[1;36m purpleclouds \e[0m"
            ;;
        0)
            echo -e "  \e[1;36m mountains1   \e[0m"
            echo -e "  \e[1;33m plains1      \e[0m"
            echo -e "  \e[1;36m redsunset    \e[0m"
            echo -e "  \e[0;34m succulents   \e[0m"
            echo -e "> \e[1;36m purpleclouds \e[0m"
            ;;
    esac
}

PHOTOS_PATH="~/Documents/tjwallpapers/used/"
write_wall_path() {
    case $1 in
        4)
            echo -e "${PHOTOS_PATH}mountains1.jpg\n$1" > ~/.config/.WallPath.txt
            ;;
        3)
            echo -e "${PHOTOS_PATH}plains1.jpg\n$1" > ~/.config/.WallPath.txt
            ;;
        2)
            echo -e "${PHOTOS_PATH}redcloudysunset.jpg\n$1" > ~/.config/.WallPath.txt
            ;;
        1)
            echo -e "${PHOTOS_PATH}bigsurnightsucculents.heic\n$1" > ~/.config/.WallPath.txt
            ;;
        0)
            echo -e "${PHOTOS_PATH}purpleclouds.jpg\n$1" > ~/.config/.WallPath.txt
            ;;
    esac
}
print_walls $index

while : ; do
    cleard
    print_walls $index
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
            write_wall_path $index
            m wallpaper $(sed '1q;d' ~/.config/.WallPath.txt)
            ;;
        'q')
            tput cnorm
            printf '\e[?1049l'
            break
            ;;
        *)
            :
            ;;
    esac
done
