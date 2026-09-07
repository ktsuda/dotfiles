#!/bin/bash

# Fetch weather condition and temperature using wttr.in format strings
# %c = condition icon, %t = temperature
WEATHER_DATA=$(curl -s "wttr.in/?format=%c+%t")

# If the request fails, show an offline status
if [ -z "${WEATHER_DATA}" ]; then
    sketchybar --set "${NAME}" label="Weather Unavailable"
    exit 0
fi

# Split the fetched data into icon and temperature
ICON=$(echo "${WEATHER_DATA}" | awk '{print $1}')
TEMP=$(echo "${WEATHER_DATA}" | awk '{print $2}')

# Update SketchyBar
sketchybar --set "${NAME}" icon="${ICON}" label="${TEMP}"
