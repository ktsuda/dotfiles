#!/usr/bin/env bash

# Run herdr, then follow the session switch requested by custom_herdr_session
# (it writes the next session name here before stopping the current one).
next="${XDG_STATE_HOME:-$HOME/.local/state}/herdr/next-session"
session="${1:-default}"

while [[ -n "${session}" ]]; do
  herdr --session "${session}"
  session=$(cat "${next}" 2>/dev/null)
  rm -f "${next}"
done
