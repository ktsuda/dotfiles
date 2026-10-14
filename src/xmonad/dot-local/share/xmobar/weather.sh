#!/usr/bin/env bash

WEATHER_DATA=$(curl -s "wttr.in/Tokyo?format=%c+%t+%l")

if [ -z "${WEATHER_DATA}" ]; then
  echo 'echo "Weatther Unavailable"'
  exit 0
fi

echo "${WEATHER_DATA}" | awk '{
  icon = $1
  temp = $2
  city = $3
  print icon,temp,city
}'
