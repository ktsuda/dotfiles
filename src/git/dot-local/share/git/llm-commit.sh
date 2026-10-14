#!/bin/sh
# Write commit messages with an LLM (via commit-msg.sh).
# usage: llm-commit.sh                    commit the staged changes
#        llm-commit.sh <commit>           regenerate <commit>'s message from
#                                         its full diff, e.g. after a fixup
#                                         was squashed in
#        llm-commit.sh --fixup <commit>   fold the staged changes into <commit>
#                                         (git history fixup), then regenerate
set -eu
dir=$(dirname "$0")

rules='<format>
- Subject line: at most 50 characters, no trailing period
- For material changes, add a blank line, then a body wrapped at 72 characters per line
- Body explains what changed and why, not how; keep it to a few short lines
- Output only the commit message, no quotes or code blocks
- Write in English, even if the diff content is in another language
</format>

<style>
- Imperative mood: "Add feature" not "Added feature"
- Match recent commit style (conventional commits if used), except where it conflicts with the format above
- Describe the change, not the intent or benefit
</style>'

tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

# ponytail: whole diff goes to the LLM; truncate here if huge diffs hit limits
if [ $# -eq 0 ]; then
    if git diff --cached --quiet; then
        echo "llm-commit.sh: nothing staged" >&2
        exit 1
    fi
    {
        printf '%s\n\n%s\n\n<diffstat>\n' "Write a commit message for the staged changes below." "$rules"
        git diff --cached --stat
        printf '</diffstat>\n\n<diff>\n'
        git diff --cached
        printf '</diff>\n\n<context>\nBranch: %s\n<recent_commits>\n' "$(git branch --show-current)"
        git log -10 --format='- %s' 2>/dev/null || true
        printf '</recent_commits>\n</context>\n'
    } | sh "$dir/commit-msg.sh" > "$tmp"
    git commit -q -F "$tmp"
    git log -1 --format='%h %s'
    exit
fi

if [ "$1" = --fixup ]; then
    shift
    # The fixup rewrites <commit>'s hash; its distance from HEAD stays the same.
    n=$(git rev-list --count "$1"..HEAD)
    git history fixup "$1"
    set -- "HEAD~$n"
fi
c=$(git rev-parse "$1")

{
    printf '%s\n%s\n\n%s\n\n<current_message>\n' \
        "Rewrite the commit message so it matches the full diff below." \
        "The current message may describe only part of it." "$rules"
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
