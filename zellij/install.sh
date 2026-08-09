#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.config/zellij"
ln -svf "$DIR/config.kdl" "$HOME/.config/zellij/config.kdl"

rm -rf "$HOME/.config/zellij/layouts"
ln -svf "$DIR/layouts" "$HOME/.config/zellij/layouts"
