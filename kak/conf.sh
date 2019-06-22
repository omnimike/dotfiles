#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

mkdir -p "$HOME/.config/kak"
mkdir -p "$HOME/.config/kak/plugins"
ln -svf kakrc "$HOME/.config/kak/kakrc"
git clone https://github.com/andreyorst/plug.kak.git "$HOME/.config/kak/plugins/plug.kak"
