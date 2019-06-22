#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

ln -svf "$DIR/styles.less" "$HOME/.atom/styles.less"
ln -svf "$DIR/init.coffee" "$HOME/.atom/init.coffee"
ln -svf "$DIR/keymap.cson" "$HOME/.atom/keymap.cson"
ln -svf "$DIR/config.cson" "$HOME/.atom/config.cson"
