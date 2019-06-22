#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

ln -svf "$DIR/init.vim" "$HOME/.vimrc"
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p "$HOME/.vim/backup"
mkdir -p "$HOME/.vim/swapfiles"
mkdir -p "$HOME/.vim/undo"
ln -svf "$DIR/settings.json" "$HOME/.vim/settings.json"
ln -s "$HOME/.vim" "$HOME/.config/nvim"
ln -s "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"
