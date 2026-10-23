#!/bin/bash

# Fetch weather condition and temperature using wttr.in format strings
# %c = condition icon, %t = temperature
WEATHER_DATA=$(curl -s -m 3 "wttr.in/Tokyo?format=%c+%t+%l")

# If the request fails, show an offline status
if [ -z "${WEATHER_DATA}" ]; then
    sketchybar --set "${NAME}" label="Weather Unavailable"
    exit 0
fi

# Split the fetched data into icon and temperature
read -r ICON TEMP CITY <<< "${WEATHER_DATA}"

# Update SketchyBar
sketchybar --set "${NAME}" icon="${ICON}" label="${TEMP} ${CITY}"
