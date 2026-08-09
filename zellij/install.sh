#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.config/zellij"
ln -svf "$DIR/config.kdl" "$HOME/.config/zellij/config.kdl"

mkdir -p "$HOME/.config/zellij/layouts"
for f in "$DIR/layouts"/*.kdl; do
    [ -f "$f" ] || continue
    ln -svf "$f" "$HOME/.config/zellij/layouts/"
done
