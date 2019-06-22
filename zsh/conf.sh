#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

ln -svf zshrc.zsh "$HOME/.zshrc"
ln -svf zshenv.zsh "$HOME/.zshenv"
