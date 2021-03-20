#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
  cat pkg-list.mac | xargs -p -I{} brew install {}
else
  echo "Your platform ($(uname -a)) is not supported.  Exiting..."
  exit 1
fi
