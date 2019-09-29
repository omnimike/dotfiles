#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)
mkdir -p "$HOME/.vim"
ln -svf "$DIR/init.vim" "$HOME/.vimrc"
mkdir -p "$HOME/.vim-temp/backup"
mkdir -p "$HOME/.vim-temp/swapfiles"
mkdir -p "$HOME/.vim-temp/undo"

curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p "$HOME/.config"
if [[ ! -L "$HOME/.config/nvim" ]]; then
    ln -svf "$HOME/.vim" "$HOME/.config/nvim"
fi
ln -svf "$HOME/.vimrc" "$HOME/.config/nvim/init.vim"
