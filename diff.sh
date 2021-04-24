#!/bin/bash

declare -a arr=(
  ".gitconfig"
  ".gitignore"
  ".screenrc"
  ".tigrc"
  ".vimrc"
  ".zshrc"
  ".config/i3/config"
)

for file in "${arr[@]}"
do
  echo "[$file]"
  diff skel/$file ~/$file
  if [ $? -eq 0 ]; then
    echo "Not updated."
  fi
  echo
done
