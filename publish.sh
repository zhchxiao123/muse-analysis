#!/usr/bin/env bash
# Publish this directory to GitHub Pages. Usage:
#   GH_TOKEN=ghp_xxx ./publish.sh [owner/repo]      (token needs: repo, workflow? no; "repo" scope is enough)
# or after `gh auth login`:   ./publish.sh [owner/repo]
set -euo pipefail
cd "$(dirname "$0")"
REPO="${1:-zhchxiao123/muse-analysis}"
OWNER="${REPO%%/*}"; NAME="${REPO##*/}"
gh auth status >/dev/null 2>&1 || { echo "gh is not authenticated: export GH_TOKEN=... or run gh auth login"; exit 1; }
if ! gh repo view "$REPO" >/dev/null 2>&1; then
  echo "creating public repo $REPO"
  gh repo create "$REPO" --public --description "Static reverse-engineering reports on Muse 10.0 (Meta Endo/Hatch)" >/dev/null
fi
git remote remove origin 2>/dev/null || true
git remote add origin "https://github.com/$REPO.git"
git -c credential.helper='!gh auth git-credential' push -u origin main
# enable Pages from main / root (idempotent)
if ! gh api "repos/$REPO/pages" >/dev/null 2>&1; then
  gh api -X POST "repos/$REPO/pages" -f build_type=legacy -f 'source[branch]=main' -f 'source[path]=/' >/dev/null
else
  gh api -X PUT "repos/$REPO/pages" -f build_type=legacy -f 'source[branch]=main' -f 'source[path]=/' >/dev/null || true
fi
echo "Pages URL: https://$OWNER.github.io/$NAME/"
echo "(first build usually takes 1-2 minutes; check: gh api repos/$REPO/pages --jq .status)"
