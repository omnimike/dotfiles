#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

rm -f "$HOME/.hammerspoon/init.lua"
ln -svf init.lua "$HOME/.hammerspoon/init.lua"
