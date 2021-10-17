#!/bin/bash

declare -a common=(
  ".gitconfig"
  ".gitignore"
  ".screenrc"
  ".tigrc"
  ".vimrc"
  ".zshrc"
  ".tmux.conf"
  ".config/nvim/init.lua"
)

for file in "${common[@]}"
do
  echo "[$file]"
  diff skel/$file ~/$file
  if [ $? -eq 0 ]; then
    echo "Not updated."
  fi
  echo
done

declare -a linux=(
  ".config/i3/config"
)

if [ "$(uname)" == 'Linux' ]; then
  for file in "${linux[@]}"
  do
    echo "[$file]"
    diff skel/$file ~/$file
    if [ $? -eq 0 ]; then
      echo "Not updated."
    fi
    echo
  done
fi
