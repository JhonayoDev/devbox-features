#!/usr/bin/env bash
set -e

if [ -z "$DOTFILES_REPO" ]; then
  echo "[feature/dotfiles] no definido, saltando..."
  exit 0
fi

echo "[feature/dotfiles] clonando..."
git clone "$DOTFILES_REPO" "$HOME/dotfiles"

echo "[feature/dotfiles] instalando..."
bash "$HOME/dotfiles/install.sh" devbox

echo "[feature/dotfiles] listo"
