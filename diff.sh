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
  diff files/$file ~/$file
done
