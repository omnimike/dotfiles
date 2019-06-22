#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

ln -svf tmux.conf "$HOME/.tmux.conf"
