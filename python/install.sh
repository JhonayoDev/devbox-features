#!/usr/bin/env bash
# devbox-features/python/install.sh
#
# Configura herramientas de desarrollo Python.
# El interprete ya viene en la imagen base.
#
# Variables esperadas:
#   PYTHON_PACKAGES → paquetes extra separados por espacio
#                     ej: "fastapi uvicorn sqlalchemy"

set -euo pipefail

PYTHON_PACKAGES="${PYTHON_PACKAGES:-}"

echo "[feature/python] Configurando Python..."

sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    pipx \
    && sudo rm -rf /var/lib/apt/lists/*

pipx ensurepath
pipx install poetry
pipx install ruff

if [ -n "$PYTHON_PACKAGES" ]; then
    echo "[feature/python] Instalando paquetes: $PYTHON_PACKAGES"
    pip install --user $PYTHON_PACKAGES
fi

echo "[feature/python] configurado: $(python3 --version)"
