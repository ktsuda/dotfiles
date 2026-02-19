#!/usr/bin/env bash

dir=$(tmux run-shell 'echo "#{pane_current_path}"')
cd $dir
url=$(git remote get-url origin)

if [[ $url == *github.com* ]] || [[ $url == *gitlab.com* ]] || [[ $url == *gitlab.eurecom.fr* ]]; then
  if [[ $url == git@* ]]; then
    url="${url#git@}"
    url="${url/:/\/}"
    url="https://$url"
  fi
  case ${OSTYPE} in
    darwin*)
      open "$url" > /dev/null 2>&1|| exit
      ;;
    linux*)
      xdg-open "$url" > /dev/null 2>&1|| exit
      ;;
    *)
      echo "${OSTYPE} is not supported."
  esac
else
  echo "This repo is not hosted on GitHub."
fi
