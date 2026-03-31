#!/usr/bin/env bash
# devbox-features/node/install.sh
#
# Instala Node.js LTS via NodeSource
#
# Variables esperadas:
#   NODE_VERSION → "lts" (default) o version especifica ej: "20"

set -euo pipefail

NODE_VERSION="${NODE_VERSION:-lts}"

echo "[feature/node] Instalando Node.js ($NODE_VERSION)..."

if [ "$NODE_VERSION" = "lts" ]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo bash -
else
    curl -fsSL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | sudo bash -
fi

sudo apt-get install -y nodejs
sudo rm -rf /var/lib/apt/lists/*

npm install -g neovim
pip3 install pynvim --break-system-packages

echo "[feature/node] instalado: $(node --version)"
