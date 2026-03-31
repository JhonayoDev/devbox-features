#!/usr/bin/env bash
# devbox-features/java/install.sh

set -euo pipefail

JAVA_VERSIONS="${JAVA_VERSIONS:-21.0.8-tem}"
JAVA_DEFAULT="${JAVA_DEFAULT:-21.0.8-tem}"

echo "[feature/java] Instalando sdkman..."
export SDKMAN_DIR="$HOME/.sdkman"
curl -s "https://get.sdkman.io" | bash

# Cargar sdkman deshabilitando el check de variable no inicializada
set +u
source "$HOME/.sdkman/bin/sdkman-init.sh"
set -u

echo "[feature/java] Instalando versiones: $JAVA_VERSIONS"
for version in $JAVA_VERSIONS; do
    echo "[feature/java] Instalando Java $version..."
    sdk install java "$version" < /dev/null
done

echo "[feature/java] Default: $JAVA_DEFAULT"
sdk default java "$JAVA_DEFAULT"

echo "[feature/java] Instalando Maven y Gradle..."
sdk install maven < /dev/null
sdk install gradle < /dev/null

echo '' >> "$HOME/.zshrc"
echo '# sdkman' >> "$HOME/.zshrc"
echo 'export SDKMAN_DIR="$HOME/.sdkman"' >> "$HOME/.zshrc"
echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> "$HOME/.zshrc"

echo "[feature/java] instalado correctamente"
