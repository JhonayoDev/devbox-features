#!/usr/bin/env bash
# devbox-features/flutter/install.sh
#
# Instala Flutter SDK
#
# Variables esperadas:
#   FLUTTER_VERSION → version ej: "3.19.0" o "latest"

set -euo pipefail

FLUTTER_VERSION="${FLUTTER_VERSION:-latest}"

echo "[feature/flutter] Instalando Flutter ($FLUTTER_VERSION)..."

sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    clang cmake ninja-build pkg-config \
    libgtk-3-dev liblzma-dev \
    && sudo rm -rf /var/lib/apt/lists/*

if [ "$FLUTTER_VERSION" = "latest" ]; then
    FLUTTER_VERSION=$(curl -s https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json \
        | python3 -c "import sys,json; data=json.load(sys.stdin); print(data['releases'][0]['version'])")
fi

echo "[feature/flutter] Version: $FLUTTER_VERSION"

curl -Lo /tmp/flutter.tar.xz \
    "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

tar -xf /tmp/flutter.tar.xz -C "$HOME"
rm /tmp/flutter.tar.xz

echo '' >> "$HOME/.zshrc"
echo '# Flutter' >> "$HOME/.zshrc"
echo 'export PATH="$PATH:$HOME/flutter/bin"' >> "$HOME/.zshrc"

export PATH="$PATH:$HOME/flutter/bin"
flutter precache

echo "[feature/flutter] instalado: $(flutter --version | head -n1)"
