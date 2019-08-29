#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

rm -f "$HOME/.config/karabiner/karabiner.json"
ln -svf "$DIR/karabiner.json" "$HOME/.config/karabiner/karabiner.json"
