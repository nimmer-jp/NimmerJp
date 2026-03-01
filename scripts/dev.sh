#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TAILWIND_PID=""

cleanup() {
  if [[ -n "${TAILWIND_PID}" ]] && kill -0 "${TAILWIND_PID}" >/dev/null 2>&1; then
    kill "${TAILWIND_PID}" >/dev/null 2>&1 || true
  fi
}

trap cleanup EXIT INT TERM

if [[ -x "${ROOT_DIR}/.nimble/bin/ducere" ]]; then
  DUCERE_CMD="${ROOT_DIR}/.nimble/bin/ducere"
elif command -v ducere >/dev/null 2>&1; then
  DUCERE_CMD="$(command -v ducere)"
else
  echo "ducere not found. Run ./scripts/setup.sh first." >&2
  exit 1
fi

(
  cd "${ROOT_DIR}"
  ./scripts/tailwind.sh watch
) &
TAILWIND_PID=$!

cd "${ROOT_DIR}"
HOST="${HOST:-0.0.0.0}" PORT="${PORT:-8080}" "${DUCERE_CMD}" serve -p="${PORT:-8080}"
