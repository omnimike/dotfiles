#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)
mkdir -p "$HOME/.vim"
ln -svf "$DIR/init.vim" "$HOME/.vimrc"
ln -svf "$DIR/settings.json" "$HOME/.vim/settings.json"
mkdir -p "$HOME/.vim/backup"
mkdir -p "$HOME/.vim/swapfiles"
mkdir -p "$HOME/.vim/undo"

curl -fsLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p "$HOME/.config"
ln -svf "$HOME/.vim" "$HOME/.config/nvim"
ln -svf "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"
