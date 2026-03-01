#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

export NIMBLE_DIR="${ROOT_DIR}/.nimble"

nimble install -y https://github.com/itsumura-h/nim-basolato
./scripts/tailwind.sh build

echo "Setup complete. Run: NIMBLE_DIR=.nimble nimble dev"
