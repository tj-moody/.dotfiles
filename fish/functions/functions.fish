function l
    eza -al --icons --group-directories-first $argv
end

function lt
    eza -al --tree --icons --group-directories-first \
    --ignore-glob="node_modules|.git|.vscode|.idea" $argv
    # --ignore-glob="**/.git*|**/node_modules/*|**/.vscode/*|**/.idea/*" $argv
end

function lds
    eza -alD --icons
end

function cleard
    clear
    for line in (seq $LINES)
        # echo -ne "\n"
        printf "\n"
    end
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

function chwall
    # if [ "0" != "$(count $argv)" ]
    #     return
    # end
    bash ~/.dotfiles/bash/chwall.bash
    m wallpaper $(sed '1q;d' ~/.config/.WallPath.txt)
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

function mich
    cd ~/school/michigan/"$argv"
end

function colortest
    bash /Users/tj/.dotfiles/bash/colortest.bash
end

function colortest2
    bash /Users/tj/.dotfiles/bash/colortest2.bash
end

function nvimspeedtest
    hyperfine "nvim --headless +qa" --warmup 10
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

function ipglobal
    curl https://ipinfo.io/ip
end
function iplocal
    ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2
end

function lavat
    ~/packages/lavat/lavat -c magenta -R 5 -F "@%#&I!:."
end

function projinit
    if not test -e projfile.lua
        echo > projfile.lua 'return {
    ["version"] = "0.1.1",
    ["tasks"] = {
        ["build"] = { [[]] },
        ["test"] = { [[]] },
    },
}'
    else
        echo "`projtasks` file already exists."
    end
end

function vimtip
    curl https://vtip.43z.one
end
