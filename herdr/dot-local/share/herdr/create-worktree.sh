#!/usr/bin/env bash
set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1 && ! git rev-parse --is-bare-repository >/dev/null 2>&1; then
    echo "Error: Not in a git repository."
    return 1
fi

if [ -z "$1" ]; then
    echo "Usage: hwt <branch-name>"
    return 1
fi

local BRANCH_NAME="$1"

# 3. Get the root project path or the bare repository directory
local REPO_ROOT
if git rev-parse --is-bare-repository >/dev/null 2>&1; then
    REPO_ROOT=$(pwd)
else
    REPO_ROOT=$(git rev-parse --show-toplevel)
fi

# 4. Construct the custom local path inside or next to the repo
# This places worktrees under: <your-project>/.herdr-worktrees/<branch-name>
local TARGET_PATH="${REPO_ROOT}/.herdr-worktrees/${BRANCH_NAME}"

echo "🌱 Creating herdr worktree for branch '${BRANCH_NAME}'..."
echo "📂 Target path: ${TARGET_PATH}"

# 5. Execute herdr worktree create bypassing the global directory path
herdr worktree create \
    --cwd "${REPO_ROOT}" \
    --branch "${BRANCH_NAME}" \
    --path "${TARGET_PATH}"
