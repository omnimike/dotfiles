#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

if [[ $(grep -q "bashrc.bash" "$HOME/.bashrc"; echo $?) -eq 1 ]]; then
  echo "adding bashrc.bash to .bashrc"
  echo "[[ -f $DIR/bashrc.bash ]] && source $DIR/bashrc.bash" >> "$HOME/.bashrc"
else
  echo "bashrc.bash already sourced in .bashrc"
fi

if [[ $(grep -q "profile.bash" "$HOME/.profile"; echo $?) -eq 1 ]]; then
  echo "adding profile.bash to .profile"
  echo "[[ -f $DIR/profile.bash ]] && source $DIR/profile.bash" >> "$HOME/.profile"
else
  echo "profile.bash already sourced in .profile"
fi
