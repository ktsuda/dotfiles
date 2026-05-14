#!/usr/bin/env bash

dir=$(tmux run-shell 'echo "#{pane_current_path}"')
cd $dir
url=$(git remote get-url origin)

if [[ $url == *github* ]] || [[ $url == *gitlab* ]] || [[ $url == *gitlab.eurecom.fr* ]]; then
  if [[ $url == http* ]]; then
    :
  elif [[ $url == git@*.com:* ]]; then
    url="${url#git@}"
    url="${url/:/\/}"
    url="https://$url"
  elif [[ $url == *:* ]]; then
    url="${url/:/.com\/}"
    url="https://$url"
    url="${url/.git/}"
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
