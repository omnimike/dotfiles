#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.config/nvim"
ln -svf "$DIR/init.lua" "$HOME/.config/nvim"
ln -svf "$DIR/pack" "$HOME/.config/nvim/"
