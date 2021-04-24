#!/bin/bash

declare -a arr=(
  ".gitconfig"
  ".gitignore"
  ".screenrc"
  ".tigrc"
  ".vimrc"
  ".zshrc"
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
