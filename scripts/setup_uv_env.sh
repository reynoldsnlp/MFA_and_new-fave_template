#!/usr/bin/env sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
VENV_DIR="$PROJECT_ROOT/.venv"

if ! command -v uv >/dev/null 2>&1; then
  if curl -LsSf https://astral.sh/uv/install.sh -o /tmp/uv-install.sh && sh /tmp/uv-install.sh; then
    :
  else
    python3 -m pip install --user uv
  fi
  export PATH="$HOME/.local/bin:$PATH"
fi

uv venv "$VENV_DIR"
uv pip install --python "$VENV_DIR/bin/python" montreal-forced-aligner new-fave pgvector
"$VENV_DIR/bin/python" "$PROJECT_ROOT/scripts/toy_import_check.py"
