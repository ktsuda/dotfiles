#!/usr/bin/env bash
set -euo pipefail

case ${OSTYPE} in
    darwin*) printf '%s' "$1" | pbcopy ;;
    linux*)
        if command -v xclip >/dev/null; then
            printf '%s' "$1" | xclip -selection c
        elif command -v xsel >/dev/null; then
            printf '%s' "$1" | xsel --clipboard --input
        else
            echo "Install xclip or xsel" >&2
            exit 1
        fi
        ;;
    *) echo "unsupported OSTYPE: ${OSTYPE}" >&2; exit 1 ;;
esac
