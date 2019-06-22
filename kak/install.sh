#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.config/kak"
mkdir -p "$HOME/.config/kak/plugins"
ln -svf "$DIR/kakrc" "$HOME/.config/kak/kakrc"
git clone https://github.com/andreyorst/plug.kak.git "$HOME/.config/kak/plugins/plug.kak"
