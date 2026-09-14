#!/usr/bin/env bash
# Minimal checks: the HTML has matching html/head/body tags and every linked stylesheet exists.
set -euo pipefail
cd "$(dirname "$0")"
for tag in html head body; do
  grep -q "<$tag" index.html && grep -q "</$tag>" index.html || { echo "missing <$tag> in index.html"; exit 1; }
done
for css in $(grep -oE 'href="[^"]+\.css"' index.html | cut -d'"' -f2); do
  [ -f "$css" ] || { echo "missing stylesheet $css"; exit 1; }
done
echo "ok"
