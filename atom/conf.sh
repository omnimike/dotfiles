#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

ln -svf styles.less "$HOME/.atom/styles.less"
ln -svf init.coffee "$HOME/.atom/init.coffee"
ln -svf keymap.cson "$HOME/.atom/keymap.cson"
ln -svf config.cson "$HOME/.atom/config.cson"
