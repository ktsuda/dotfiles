#!/usr/bin/env bash
set -euo pipefail

case ${OSTYPE} in
    darwin*) printf '%s' "$1" | pbcopy ;;
    linux*) printf '%s' "$1" | xclip -selection c ;;
    *) echo "unsupported OSTYPE: ${OSTYPE}" >&2; exit 1 ;;
esac
