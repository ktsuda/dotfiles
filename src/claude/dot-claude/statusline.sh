#!/usr/bin/env bash
# Order: model, branch (or dir name), context used %, caveman badge.
input=$(cat)
dir=$(jq -r '.workspace.current_dir // .cwd' <<<"$input")
model=$(jq -r '.model.display_name' <<<"$input")
branch=$(git -C "$dir" branch --show-current 2>/dev/null)
# Glob instead of hardcoding the plugin cache hash, which changes on plugin update.
cave=$(ls $HOME/.claude/plugins/cache/caveman/caveman/*/hooks/caveman-statusline.sh 2>/dev/null | tail -1)
badge=$([ -n "$cave" ] && bash "$cave")
loc="${branch:-$(basename "$dir")}"
used=$(jq -r '.context_window.used_percentage // empty' <<<"$input")
[ -n "$used" ] && used=$(printf '%.0f%%' "$used") || used="--%"
printf '[%s] \ue0a0 %s (%s context) %s' "$model" "$loc" "$used" "$badge"
