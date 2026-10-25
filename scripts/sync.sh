#!/bin/bash
# Commits and pushes anything new. Runs from cron on the Mac.
# Syncs the public repo (this folder) and, if set up, the private repo in private/.
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOG="$ROOT/scripts/sync.log"
sync_repo() {
  cd "$1" || return
  git add -A
  if ! git diff --cached --quiet; then
    git commit -q -m "Practice log: $(date +%Y-%m-%d)"
  fi
  git push -q origin HEAD 2>>"$LOG" || echo "$(date) push failed in $1" >> "$LOG"
}
sync_repo "$ROOT"
[ -d "$ROOT/private/.git" ] && sync_repo "$ROOT/private"
