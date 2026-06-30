#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.config/noctalia"

# Symlink settings.json
rm -f "$HOME/.config/noctalia/settings.json"
ln -svf "$DIR/settings.json" "$HOME/.config/noctalia/settings.json"

# Symlink colors.json
rm -f "$HOME/.config/noctalia/colors.json"
ln -svf "$DIR/colors.json" "$HOME/.config/noctalia/colors.json"

# Symlink colorschemes folder
rm -rf "$HOME/.config/noctalia/colorschemes"
ln -svf "$DIR/colorschemes" "$HOME/.config/noctalia/colorschemes"
