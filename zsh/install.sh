#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

ln -svf "$DIR/zshrc.zsh" "$HOME/.zshrc"
ln -svf "$DIR/zshenv.zsh" "$HOME/.zshenv"
