#!/usr/bin/env bash
set -euo pipefail

# Worktree placement:
#   bare repo at <repo>/.git    -> <repo>/<branch>
#   normal clone (<repo>/.git)  -> ~/.config/herdr/worktrees/<repo>/<branch>
#   bare repo at <repo>(.git)   -> ~/.config/herdr/worktrees/<repo>/<branch>
COMMON=$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null) || {
    read -rsn1 -p "Not in a git repository. Press any key..."
    exit 1
}
if [ "$(basename "${COMMON}")" = ".git" ]; then
    REPO_ROOT=$(dirname "${COMMON}")
else
    REPO_ROOT="${COMMON}"
fi

if [ "$(basename "${COMMON}")" = ".git" ] &&
    [ "$(git --git-dir="${COMMON}" rev-parse --is-bare-repository)" = "true" ]; then
    WORKTREE_ROOT="${REPO_ROOT}"
else
    REPO_NAME=$(basename "${REPO_ROOT}")
    WORKTREE_ROOT="${HOME}/.config/herdr/worktrees/${REPO_NAME%.git}"
fi

confirm() {
    local ans
    read -rp "$1 [y/N] " ans
    [ "${ans}" = "y" ]
}

# Remove the branch's worktree (branch is kept) and close its herdr workspace
remove_worktree() {
    local info path ws
    info=$(herdr worktree list --cwd "${REPO_ROOT}" |
        jq -c --arg b "$1" '.result.worktrees[] | select(.branch == $b)')
    if [ -z "${info}" ]; then
        read -rsn1 -p "No worktree for '$1'. Press any key..."
        exit 1
    fi
    path=$(jq -r '.path' <<<"${info}")
    ws=$(jq -r '.open_workspace_id // empty' <<<"${info}")

    confirm "Remove worktree '$1' at ${path}?" || exit 0
    if ! git worktree remove "${path}"; then
        confirm "Force remove (discards local changes)?" || exit 1
        git worktree remove --force "${path}"
    fi
    # Delete the branch before closing the workspace, which may kill this popup
    if [ -n "${DELETE_BRANCH:-}" ]; then
        git branch -D "$1"
        git config --remove-section "branch.$1" 2>/dev/null || true
    fi
    # Focus before closing (closing the focused workspace moves focus to its
    # neighbor); detached so the popup dying on focus change can't skip the close
    if [ -n "${FOCUS_WS:-}" ]; then
        setsid -f sh -c 'herdr workspace focus "$1"; [ -z "$2" ] || herdr workspace close "$2"' \
            _ "${FOCUS_WS}" "${ws}" >/dev/null 2>&1
    elif [ -n "${ws}" ]; then
        herdr workspace close "${ws}" >/dev/null
    fi
}

# Squash-merge the branch into its recorded base, then remove worktree and branch
squash_merge() {
    local base base_wt base_ws
    base=$(git config "branch.$1.herdrBase" || echo main)
    base_wt=$(git worktree list --porcelain |
        awk -v ref="branch refs/heads/${base}" '/^worktree /{p=substr($0,10)} $0==ref{print p}')
    if [ -z "${base_wt}" ]; then
        read -rsn1 -p "'${base}' is not checked out in any worktree. Press any key..."
        exit 1
    fi
    confirm "Squash-merge '$1' into '${base}'?" || exit 0
    git -C "${base_wt}" merge --squash "$1"
    git -C "${base_wt}" commit
    # The popup may be running inside the worktree about to be removed
    cd "${base_wt}"
    base_ws=$(herdr worktree list --cwd "${REPO_ROOT}" |
        jq -r --arg p "${base_wt}" '.result.worktrees[] | select(.path == $p) | .open_workspace_id // empty')
    DELETE_BRANCH=1 FOCUS_WS="${base_ws}" remove_worktree "$1"
}

# Pick an existing branch, or type a new name.
# fzf exits 1 on no match, 130 on cancel; ctrl-d exits 42 with the selected branch.
RC=0
SELECTED=$(git for-each-ref --format='%(refname:short)' refs/heads |
    fzf --print-query --prompt 'branch> ' \
        --header 'enter: select / alt-enter: use typed name / ctrl-d: remove worktree / ctrl-s: squash-merge & remove' \
        --bind 'alt-enter:print-query' \
        --bind 'ctrl-d:become(echo {}; exit 42)' \
        --bind 'ctrl-s:become(echo {}; exit 43)') || RC=$?
BRANCH_NAME=$(tail -n 1 <<<"${SELECTED}")
[ -n "${BRANCH_NAME}" ] || exit 0
case "${RC}" in
0 | 1) ;;
42)
    remove_worktree "${BRANCH_NAME}"
    exit 0
    ;;
43)
    squash_merge "${BRANCH_NAME}"
    exit 0
    ;;
*) exit 0 ;;
esac

# Branch already has a worktree: open it (focuses if already open)
if git worktree list --porcelain | grep -qxF "branch refs/heads/${BRANCH_NAME}"; then
    exec herdr worktree open --cwd "${REPO_ROOT}" --branch "${BRANCH_NAME}" --focus
fi

# Branch off the caller's checkout, not the bare repo's HEAD (--cwd points there)
BASE=$(git symbolic-ref -q --short HEAD || git rev-parse HEAD)
TARGET_PATH="${WORKTREE_ROOT}/${BRANCH_NAME//\//-}"
git config "branch.${BRANCH_NAME}.herdrBase" "${BASE}"

herdr worktree create \
    --cwd "${REPO_ROOT}" \
    --branch "${BRANCH_NAME}" \
    --base "${BASE}" \
    --path "${TARGET_PATH}" \
    --focus
