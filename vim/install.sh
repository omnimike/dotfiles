#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.vim"
ln -svf "$DIR/init.vim" "$HOME/.vimrc"
ln -svf "$DIR/pack" "$HOME/.vim/pack"

mkdir -p "$HOME/.vim-temp/backup"
mkdir -p "$HOME/.vim-temp/swapfiles"
mkdir -p "$HOME/.vim-temp/undo"
