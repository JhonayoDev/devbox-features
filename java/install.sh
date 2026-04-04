#!/usr/bin/env bash
set -e

echo "[feature/java] instalando sdkman..."
export SDKMAN_DIR="$HOME/.sdkman"
curl -s "https://get.sdkman.io" | bash

# Cargar sdkman
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Valores por defecto (si no vienen desde afuera)
JAVA_VERSIONS="${JAVA_VERSIONS:-21.0.8-tem}"
JAVA_DEFAULT="${JAVA_DEFAULT:-21.0.8-tem}"

echo "[feature/java] versiones: $JAVA_VERSIONS"

for version in $JAVA_VERSIONS; do
  echo "[feature/java] instalando java $version..."
  sdk install java "$version" </dev/null
done

echo "[feature/java] default: $JAVA_DEFAULT"
sdk default java "$JAVA_DEFAULT"

echo "[feature/java] instalando maven y gradle..."
sdk install maven </dev/null
sdk install gradle </dev/null

# asegurar sdkman en shells futuros
echo '' >>"$HOME/.zshrc"
echo '# sdkman' >>"$HOME/.zshrc"
echo 'export SDKMAN_DIR="$HOME/.sdkman"' >>"$HOME/.zshrc"
echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >>"$HOME/.zshrc"

echo "[feature/java] listo"
