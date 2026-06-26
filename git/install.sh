#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)
ln -svf "$DIR/gitconfig" "$HOME/.gitconfig"
