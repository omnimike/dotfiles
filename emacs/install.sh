#!/bin/bash

set -euo pipefail
DIR=$(cd "$(dirname "$0")"; pwd -P)

ln -svf "$DIR/init.el" "$HOME/.emacs.d/init.el"
