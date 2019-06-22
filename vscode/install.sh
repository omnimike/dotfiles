#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

if [[ $OSTYPE == "darwin"* ]]; then
  ln -svf "$DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
else
  echo "Don't know how to link xcode config on this operating system"
fi
