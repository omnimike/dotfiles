#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

if [[ ! -f "$HOME/.bashrc" ]]; then
  touch "$HOME/.bashrc"
fi

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

ln -svf "$DIR/inputrc.bash" "$HOME/.inputrc"

if [[ ! -f "$HOME/.bash_profile" ]]; then
  echo "linking bash_profile.bash to .bash_profile"
  ln -svf "$DIR/bash_profile.bash" "$HOME/.bash_profile"
else
  echo ".bash_profile already exists"
fi

