#!/usr/bin/env bash
# Basolato の asynchttpserver コールバックは {.gcsafe.} 必須だが、
# Nim 2.2 系では createResponse が gcsafe と見なされずビルドが失敗する。
# createResponse 呼び出しを {.cast(gcsafe).} で包む（フレームワーク側の既知ギャップの回避）。
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MARKER="NimmerJp: cast(gcsafe) wrapper for createResponse (Nim 2.2+)"
NEEDLE='response = createResponse(req, routeMatch.route, req.httpMethod, routeMatch.pathParams).await'

patch_file() {
  local f="$1"
  if grep -qF "$MARKER" "$f" 2>/dev/null; then
    return 0
  fi
  if ! grep -qF "$NEEDLE" "$f"; then
    return 0
  fi

  local tmp
  tmp="$(mktemp)"
  local replaced=0
  while IFS= read -r line || [[ -n "${line}" ]]; do
    if [[ "$replaced" -eq 0 ]] && [[ "$line" == *"$NEEDLE"* ]]; then
      printf '%s\n' \
        '          var routeFuture: Future[Response]' \
        "          # $MARKER" \
        '          {.cast(gcsafe).}:' \
        '            routeFuture = createResponse(req, routeMatch.route, req.httpMethod, routeMatch.pathParams)' \
        '          response = routeFuture.await'
      replaced=1
    else
      printf '%s\n' "$line"
    fi
  done <"$f" >"$tmp"
  if [[ "$replaced" -eq 1 ]]; then
    mv "$tmp" "$f"
    echo "Patched: $f"
  else
    rm -f "$tmp"
  fi
}

shopt -s nullglob
for base in "${NIMBLE_DIR:-$ROOT_DIR/.nimble}" "$HOME/.nimble"; do
  [[ -d "$base/pkgs2" ]] || continue
  for f in "$base"/pkgs2/basolato-*/basolato/core/libservers/std/server.nim; do
    patch_file "$f"
  done
done
