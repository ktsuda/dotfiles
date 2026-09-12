#!/bin/bash

MEMORY=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $NF}')
sketchybar --set "$NAME" label="$MEMORY"
