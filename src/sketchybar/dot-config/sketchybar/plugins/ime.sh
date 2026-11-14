#!/bin/sh

# Kotoeri and Google Japanese Input both report hiragana/katakana modes as
# an "Input Mode" containing "Japanese"; their Roman mode and plain ABC do not.
if defaults read com.apple.HIToolbox AppleSelectedInputSources 2>/dev/null |
  grep '"Input Mode"' | grep -q 'Japanese'; then
  sketchybar --set "$NAME" label="あ" label.color=0xfff38ba8 # red
else
  sketchybar --set "$NAME" label="Ａ" label.color=0xff6c7086 # overlay0
fi
