#!/usr/bin/env sh
set -eu

repo_root="$(git rev-parse --show-toplevel)"
hooks_dir="$repo_root/.git/hooks"

install_hook() {
  src="$repo_root/scripts/git-hooks/$1"
  dst="$hooks_dir/$1"

  if [ -f "$src" ]; then
    cp "$src" "$dst"
    chmod +x "$dst"
    echo "Hook instalado: $1"
  fi
}

install_hook pre-commit
install_hook commit-msg

echo "Instalación completada."