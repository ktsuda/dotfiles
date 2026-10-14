#!/usr/bin/env bash
# Move the focused tab one slot left or right: move-tab.sh left|right
set -euo pipefail

TAB_ID="${HERDR_ACTIVE_TAB_ID}"
WS_ID="${HERDR_ACTIVE_WORKSPACE_ID}"
SOCKET="${HERDR_SOCKET_PATH:-$HOME/.config/herdr/herdr.sock}"

# tab.move's insert_index is the gap in the current order, counted before the
# tab is removed, so one step left is i-1 and one step right is i+2.
INDEX=$(herdr tab list | jq -r --arg t "${TAB_ID}" --arg ws "${WS_ID}" --arg dir "$1" '
  [.result.tabs[] | select(.workspace_id == $ws) | .tab_id] as $tabs
  | ($tabs | index($t)) as $i
  | if $dir == "left" then (if $i > 0 then $i - 1 else empty end)
    else (if $i < ($tabs | length) - 1 then $i + 2 else empty end) end
')

[ -z "${INDEX}" ] && exit 0

# The CLI has no "tab move" subcommand, so call the socket API directly.
python3 -I - "${SOCKET}" "${TAB_ID}" "${INDEX}" <<'EOF'
import json, socket, sys
s = socket.socket(socket.AF_UNIX)
s.connect(sys.argv[1])
req = {"id": "move-tab", "method": "tab.move",
       "params": {"tab_id": sys.argv[2], "insert_index": int(sys.argv[3])}}
s.sendall((json.dumps(req) + "\n").encode())
s.makefile().readline()
EOF
