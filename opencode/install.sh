#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/opencode"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$CONFIG_DIR"

ln -sf "$SCRIPT_DIR/opencode.jsonc" "$CONFIG_DIR/opencode.jsonc"
ln -sf "$SCRIPT_DIR/tui.json" "$CONFIG_DIR/tui.json"