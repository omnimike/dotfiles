#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

if [[ $OSTYPE == "darwin"* ]]; then
  ln -svf "$DIR/Default (OSX).sublime-keymap" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Default (OSX).sublime-keymap"
  ln -svf "$DIR/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
else
  echo "Don't know how to link sublime config on this operating system"
fi
