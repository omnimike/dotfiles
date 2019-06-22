#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

ln -svf init.el "$HOME/.emacs.d/init.el"
