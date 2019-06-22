#!/bin/bash

set -euo pipefail
cd "$(dirname "$0")"

defaults write -g ApplePressAndHoldEnabled -bool false
