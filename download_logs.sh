#!/usr/bin/env bash
set -euo pipefail
if ! command -v gh &> /dev/null; then
  echo "Install GitHub CLI: brew install gh" >&2; exit 1
fi
if ! gh auth status &> /dev/null; then
  echo "Authenticate: gh auth login" >&2; exit 1
fi
usage(){ echo "Usage: $0 -r RUN_ID [-o DIR]"; exit 1; }
RUN_ID=""; OUTPUT_DIR="$(pwd)"
while getopts ":r:o:" opt; do
  case $opt in r) RUN_ID="$OPTARG";;
           o) OUTPUT_DIR="$OPTARG";;
           *) usage;; esac
done
[[ -z $RUN_ID ]] && usage
mkdir -p "$OUTPUT_DIR"
REPO="Butterdime/MILLER-MAP"
gh run view "$RUN_ID" --repo "$REPO" --log > "$OUTPUT_DIR/run-${RUN_ID}.log"
echo "Logs saved in $OUTPUT_DIR"
