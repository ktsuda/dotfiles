---
name: commit
description: >
  Write a git commit message for the staged changes, and commit when the user asked to commit.
  Use whenever a commit message is needed: "commit", "commit this", "write a commit message",
  "/commit", or before running `git commit`. Prefer this over caveman:caveman-commit.
model: claude-opus-5-5
effort: low
---

Write the commit message for the staged diff (`git diff --cached`; if nothing is staged, ask what to stage).

## Rules

- Match the repository convention: read `git log --oneline -10` first and follow its style (prefix, capitalisation, tense).
- Subject: imperative mood, ≤50 chars when possible, hard cap 72, no trailing period.
- Body only for a non-obvious *why*, breaking changes, migrations, or linked issues. Wrap at 72.
- Never describe what the diff already shows ("This commit...", file lists).
- No emoji.
- Append trailers (e.g. attribution) only when system or user instructions require them.
- Always include a body for breaking changes, security fixes, data migrations, and reverts.

## Boundaries

- If the user asked to commit, run `git commit` with the message; otherwise output the message as a code block.
- Never stage unrelated files, amend, or push unless asked.
