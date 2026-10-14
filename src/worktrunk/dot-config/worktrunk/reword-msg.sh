#!/bin/sh
# Regenerate <commit>'s message from its full diff via commit-msg.sh, e.g.
# after a fixup was squashed into it and the old message no longer fits.
# usage: reword-msg.sh [--fixup] <commit>
#   --fixup: first fold the staged changes into <commit> (git history fixup)
set -eu
dir=$(dirname "$0")

if [ "$1" = --fixup ]; then
    shift
    # The fixup rewrites <commit>'s hash; its distance from HEAD stays the same.
    n=$(git rev-list --count "$1"..HEAD)
    git history fixup "$1"
    set -- "HEAD~$n"
fi
c=$(git rev-parse "$1")

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT
{
    printf '%s\n' "Rewrite the commit message so it matches the full diff below." \
        "The current message may describe only part of it." \
        "Subject at most 50 characters, imperative mood, no trailing period." \
        "For material changes, add a blank line and a short body wrapped at 72." \
        "Output only the commit message, no quotes or code blocks, in English." \
        "" "<current_message>"
    git log -1 --format=%B "$c"
    printf '</current_message>\n\n<diffstat>\n'
    git show --stat --format= "$c"
    printf '</diffstat>\n\n<diff>\n'
    git show --format= "$c"
    printf '</diff>\n'
} | sh "$dir/commit-msg.sh" > "$tmp"

n=$(git rev-list --count "$c"..HEAD)
GIT_EDITOR="cp $tmp" git history reword "$c"
git log -1 --format='%h %s' "HEAD~$n"
