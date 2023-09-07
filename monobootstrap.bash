#!/bin/bash

pushd .
cd || return

if ! [ -x "$(command -v wget)" ]; then
  echo 'Error: wget is not installed.' >&2
  popd
  return
fi

wget https://raw.githubusercontent.com/tj-moody/.dotfiles/main/monorc.vim
wget https://raw.githubusercontent.com/tj-moody/.dotfiles/main/monoconfig.bash

[ -r ~/.vimrc ] && cp ~/.vimrc ~/.vimrc.bak \
    && echo ".vimrc copied to .vimrc.bak" \
    && rm ~/.vimrc

[ -r ~/.bashrc ] && cp ~/.bashrc ~/.bashrc.bak \
    && echo ".bashrc copied to .bashrc.bak" \
    && rm ~/.bashrc

cat ~/monorc.vim > ~/.vimrc && rm ~/monorc.vim
cat ~/monoconfig.bash > ~/.bashrc && rm ~/monoconfig.bash
echo "[ -r ~/.bashrc ] && . \"$HOME/.bashrc\"" >> ~/.bash_profile

echo "Installation successful"

popd || return

source ~/.bashrc

return
# One-liner to execute this program:
wget https://raw.githubusercontent.com/tj-moody/.dotfiles/main/monobootstrap.bash && . ./monobootstrap.bash && rm ./monobootstrap.bash
