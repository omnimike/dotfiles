#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

if [[ ! -f "$HOME/.bashrc" ]]; then
  echo "creating dummy .bashrc that sources bashrc.bash"
  echo "[[ -f $DIR/bashrc.bash ]] && source $DIR/bashrc.bash" > "$HOME/.bashrc"
elif ! grep -q "bashrc.bash" "$HOME/.bashrc"; then
  echo "adding bashrc.bash to .bashrc"
  echo "[[ -f $DIR/bashrc.bash ]] && source $DIR/bashrc.bash" >> "$HOME/.bashrc"
else
  echo "bashrc.bash already sourced in .bashrc"
fi

if [[ ! -f "$HOME/.profile" ]]; then
  echo "creating dummy .profile that sources profile.bash"
  echo "[[ -f $DIR/profile.bash ]] && source $DIR/profile.bash" > "$HOME/.profile"
elif ! grep -q "profile.bash" "$HOME/.profile"; then
  echo "adding profile.bash to .profile"
  echo "[[ -f $DIR/profile.bash ]] && source $DIR/profile.bash" >> "$HOME/.profile"
else
  echo "profile.bash already sourced in .profile"
fi

ln -svf "$DIR/inputrc.bash" "$HOME/.inputrc"
