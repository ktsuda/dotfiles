#!/bin/sh
# Commit message generator for worktrunk: reads the prompt on stdin and prints
# a message that follows the 50/72 convention. The LLM does not reliably count
# characters, so both limits are enforced here rather than trusted to the prompt.
set -eu

max_subject=50
max_retries=2

llm() {
    CLAUDECODE= MAX_THINKING_TOKENS=0 claude -p --no-session-persistence \
        --model=haiku --tools='' --disable-slash-commands \
        --setting-sources='' --system-prompt=''
}

msg=$(llm)
subject=$(printf '%s\n' "$msg" | head -n 1)
body=$(printf '%s\n' "$msg" | tail -n +2)

# Truncating would cut words mid-phrase, so ask for a rewrite instead.
tries=0
while [ "$(printf '%s' "$subject" | wc -m)" -gt "$max_subject" ] && [ "$tries" -lt "$max_retries" ]; do
    subject=$(printf 'Shorten this git commit subject to at most %d characters. Keep its leading verb and meaning; drop or abbreviate secondary words instead. No trailing period. Output only the subject.\n\n%s\n' \
        "$max_subject" "$subject" | llm | head -n 1)
    tries=$((tries + 1))
done
if [ "$(printf '%s' "$subject" | wc -m)" -gt "$max_subject" ]; then
    echo "commit-msg.sh: subject still exceeds $max_subject chars" >&2
fi

printf '%s\n' "$subject"
printf '%s\n' "$body" | fold -s -w 72 | sed 's/[[:space:]]*$//'
