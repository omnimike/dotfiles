#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.config/hypr"

rm -f "$HOME/.config/hypr/hyprland.lua"
ln -svf "$DIR/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"

rm -f "$HOME/.config/hypr/xdph.conf"
ln -svf "$DIR/xdph.conf" "$HOME/.config/hypr/xdph.conf"

rm -rf "$HOME/.config/hypr/config"
ln -svf "$DIR/config" "$HOME/.config/hypr/config"

# Copy local configs if they don't exist
if [ -d "$DIR/local_config" ]; then
    mkdir -p "$HOME/.config/hypr/local_config"
    for f in "$DIR/local_config"/*; do
        if [ -f "$f" ]; then
            name=$(basename "$f")
            if [ ! -f "$HOME/.config/hypr/local_config/$name" ]; then
                echo "Copying $name to $HOME/.config/hypr/local_config/"
                cp "$f" "$HOME/.config/hypr/local_config/$name"
            else
                echo "local_config/$name already exists in $HOME/.config/hypr/, skipping."
            fi
        fi
    done
fi
