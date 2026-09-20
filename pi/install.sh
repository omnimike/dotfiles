#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

mkdir -p "$HOME/.pi/agent"

ln -svf "$DIR/models.json" "$HOME/.pi/agent/models.json"
ln -svf "$DIR/settings.json" "$HOME/.pi/agent/settings.json"
