#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

ln -svf alacritty.yml "$HOME/.config/alacritty/alacritty.yml"
