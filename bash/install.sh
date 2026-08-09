#!/bin/bash

set -euo pipefail

DIR=$(cd "$(dirname "$0")"; pwd -P)

if [[ ! -f "$HOME/.bash_profile" ]]; then
  echo "creating ~/.bash_profile that sources ~/.profile"
  {
    echo "[[ -f $HOME/.profile ]] && source $HOME/.profile"
  } > "$HOME/.bash_profile"
else
  echo ".bash_profile already exists"
fi

if [[ ! -f "$HOME/.profile" ]]; then
  echo "creating ~/.profile that sources ~/.bashrc"
  {
    echo "[[ -f $DIR/profile.bash ]] && source $DIR/profile.bash"
    echo "[[ -f $HOME/.bashrc ]] && source $HOME/.bashrc"
  } > "$HOME/.profile"
else
  if ! grep -q "profile.bash" "$HOME/.profile"; then
    echo "adding profile.bash to ~/.profile"
    echo "[[ -f $DIR/profile.bash ]] && source $DIR/profile.bash" >> "$HOME/.profile"
  else
    echo "profile.bash already sourced in ~/.profile"
  fi
  if ! grep -q "\.bashrc" "$HOME/.profile"; then
    echo "adding ~/.bashrc to ~/.profile"
    echo "[[ -f $HOME/.bashrc ]] && source $HOME/.bashrc" >> "$HOME/.profile"
  else
    echo "~/.bashrc already sourced in ~/.profile"
  fi
fi

if [[ ! -f "$HOME/.bashrc" ]]; then
  echo "creating ~/.bashrc that sources bashrc.bash"
  {
    echo '[[ $- != *i* ]] && return'
    echo "[[ -f $DIR/bashrc.bash ]] && source $DIR/bashrc.bash"
  } > "$HOME/.bashrc"
elif ! grep -q "bashrc.bash" "$HOME/.bashrc"; then
  echo "adding bashrc.bash to ~/.bashrc"
  echo "[[ -f $DIR/bashrc.bash ]] && source $DIR/bashrc.bash" >> "$HOME/.bashrc"
else
  echo "bashrc.bash already sourced in ~/.bashrc"
fi

ln -svf "$DIR/inputrc.bash" "$HOME/.inputrc"

