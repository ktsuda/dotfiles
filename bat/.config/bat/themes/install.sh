#!/usr/bin/env bash

BAT_THEMES_DIR="$(command bat --config-dir)/themes"
BAT_THEME_CACHE="$(command bat --cache-dir)/themes.bin"

if [ -n "$(find "$BAT_THEMES_DIR" -name '*.tmTheme' -newer "$BAT_THEME_CACHE")" ]; then
    command bat cache --build
fi
