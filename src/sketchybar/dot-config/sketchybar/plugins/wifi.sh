#!/bin/sh

# Check if Wi-Fi interface is active and connected
SSID=$(ipconfig getsummary en0 2>/dev/null | grep "^  SSID" | awk -F ' : ' '{print $2}')

if [ -z "$SSID" ]; then
  ICON="󰖪"
  sketchybar --set $NAME icon="$ICON" label="Disconnected"
else
  ICON="󰖩"
  sketchybar --set $NAME icon="$ICON" label="$SSID"
fi
