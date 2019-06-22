#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

rm -f "$HOME/.hammerspoon/init.lua"
ln -svf "$DIR/init.lua" "$HOME/.hammerspoon/init.lua"
