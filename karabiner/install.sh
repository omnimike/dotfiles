#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

rm -rf "$HOME/.config/karabiner"
ln -svf "$DIR" "$HOME/.config/karabiner"
# launchctl kickstart -k "gui/$(id -u)/org.pqrs.karabiner.karabiner_console_user_server"
