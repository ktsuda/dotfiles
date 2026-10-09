#!/usr/bin/env bash
set -euo pipefail

# xclip/xsel stay in the background to own the selection; detach their
# stdout/stderr so tig's + command does not wait on them forever.
case ${OSTYPE} in
    darwin*) printf '%s' "$1" | pbcopy ;;
    linux*)
        if command -v xclip >/dev/null; then
            printf '%s' "$1" | xclip -selection c >/dev/null 2>&1
        elif command -v xsel >/dev/null; then
            printf '%s' "$1" | xsel --clipboard --input >/dev/null 2>&1
        else
            echo "Install xclip or xsel" >&2
            exit 1
        fi
        ;;
    *) echo "unsupported OSTYPE: ${OSTYPE}" >&2; exit 1 ;;
esac

echo "Copied $1"
