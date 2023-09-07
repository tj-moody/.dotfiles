#!/bin/bash

pushd .
cd || return
wget https://raw.githubusercontent.com/tj-moody/.dotfiles/main/monorc.vim
wget https://raw.githubusercontent.com/tj-moody/.dotfiles/main/monoconfig.bash

[ -r ~/.vimrc ] && cp ~/.vimrc ~/.vimrc.bak \
    && echo ".vimrc copied to .vimrc.bak" \
    && rm ~/.vimrc \
    || echo "Error handling previous .vimrc" && exit

[ -r ~/.bashrc ] && cp ~/.bashrc ~/.bashrc.bak \
    && echo ".bashrc copied to .bashrc.bak" \
    && rm ~/.bashrc \
    || echo "Error handling previous .bashrc" && exit

cat ~/monorc.vim > ~/.vimrc && remove ~/.monorc.vim
cat ~/monoconfig.bash > ~/.bashrc && remove ~/.monoconfig.bash
echo "[ -r ~/.bashrc ] && . \"$HOME/.bashrc\"" >> ~/.bash_profile

popd || return

return
# One-liner to execute this program:
wget https://raw.githubusercontent.com/tj-moody/.dotfiles/main/monobootstrap.bash && . ./monobootstrap.bash && rm ./monobootstrap.bash
