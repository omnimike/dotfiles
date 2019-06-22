#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

if [[ $OSTYPE == "darwin"* ]]; then
  ln -svf vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
else
  echo "Don't know how to link xcode config on this operating system"
fi
