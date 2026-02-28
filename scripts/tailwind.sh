#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${ROOT_DIR}/tools/bin"
BIN_PATH="${BIN_DIR}/tailwindcss"
TAILWIND_VERSION="${TAILWIND_VERSION:-v3.4.17}"

command="${1:-build}"
if [[ "$command" != "build" && "$command" != "watch" ]]; then
  echo "Usage: $0 [build|watch]" >&2
  exit 1
fi

os="$(uname -s)"
arch="$(uname -m)"

case "${os}-${arch}" in
  Darwin-arm64)
    asset="tailwindcss-macos-arm64"
    ;;
  Darwin-x86_64)
    asset="tailwindcss-macos-x64"
    ;;
  Linux-x86_64)
    asset="tailwindcss-linux-x64"
    ;;
  Linux-aarch64)
    asset="tailwindcss-linux-arm64"
    ;;
  *)
    echo "Unsupported platform: ${os}-${arch}" >&2
    exit 1
    ;;
esac

mkdir -p "${BIN_DIR}" "${ROOT_DIR}/public/css"

if [[ ! -x "${BIN_PATH}" ]]; then
  url="https://github.com/tailwindlabs/tailwindcss/releases/download/${TAILWIND_VERSION}/${asset}"
  echo "Downloading Tailwind CSS ${TAILWIND_VERSION} (${asset})..."
  curl -fsSL "${url}" -o "${BIN_PATH}"
  chmod +x "${BIN_PATH}"
fi

args=(
  -c "${ROOT_DIR}/tailwind.config.js"
  -i "${ROOT_DIR}/src/styles/tailwind.css"
  -o "${ROOT_DIR}/public/css/tailwind.css"
)

if [[ "$command" == "build" ]]; then
  exec "${BIN_PATH}" "${args[@]}" --minify
fi

exec "${BIN_PATH}" "${args[@]}" --watch
