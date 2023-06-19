#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.vim-temp/backup"
mkdir -p "$HOME/.vim-temp/swapfiles"
mkdir -p "$HOME/.vim-temp/undo"

mkdir -p "$HOME/.config/nvim"
ln -svf "$DIR/init.lua" "$HOME/.config/nvim"
ln -svf "$DIR/pack" "$HOME/.config/nvim/"
