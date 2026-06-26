#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

if [[ $OSTYPE == "darwin"* ]]; then
  ln -svf "$DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
else
  echo "I don't know how to link the vscode config on this operating system"
fi
