#!/bin/bash

set -eo pipefail

defaults write -g ApplePressAndHoldEnabled -bool false

if command -v brew; then
  brew install \
    vim \
    neovim \
    tmux \
    git \
    ripgrep \
    fd \
    fzf \
    jq \
    ranger \
    bash \
    zsh \
    shellcheck
else
  echo "Install homebrew to install other dependencies"
fi
