#!/usr/bin/env bash

function run {
  if ! pgrep $1 ; then
    $@&
  fi
}

run compton -cCGfF -o 0.38 -O 200 -I 200 -t 0 -l 0 -r 3 -D2 -m 0.88
run nitrogen --restore
