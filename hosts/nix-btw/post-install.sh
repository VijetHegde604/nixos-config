#!/usr/bin/env bash

set -euo pipefail

TARGET_USER="${TARGET_USER:-vijeth}"
SOURCE_DIR="${SOURCE_DIR:-/etc/nixos/nixos-config}"
HOME_DIR="${HOME_DIR:-$(getent passwd "$TARGET_USER" | cut -d: -f6 || true)}"
REPO_NAME="${REPO_NAME:-nixos-config}"
REPO_DIR="${REPO_DIR:-${HOME_DIR:+$HOME_DIR/$REPO_NAME}}"
DMS_CONFIG="${DMS_CONFIG:-${HOME_DIR:+$HOME_DIR/.config/DankMaterialShell}}"
NIRI_USER_DIR="${NIRI_USER_DIR:-${HOME_DIR:+$HOME_DIR/.config/niri/dms/user}}"

log() {
  printf '[post-install] %s\n' "$*"
}

fail() {
  printf '[post-install] Error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || fail "required command not found: $1"
}

copy_if_different() {
  local src="$1"
  local dest="$2"

  [ -f "$src" ] || fail "source file not found: $src"
  mkdir -p "$(dirname "$dest")"

  if [ -f "$dest" ] && cmp -s "$src" "$dest"; then
    log "Unchanged: $dest"
    return
  fi

  install -m 0644 "$src" "$dest"
  log "Updated: $dest"
}

require_command getent
require_command install
require_command cmp

[ -n "$HOME_DIR" ] || fail "could not resolve home directory for user '$TARGET_USER'"
[ -d "$HOME_DIR" ] || fail "home directory does not exist: $HOME_DIR"
[ "$EUID" -eq 0 ] || fail "run this script as root (for example: sudo ./hosts/nix-btw/post-install.sh)"

log "Starting post-install configuration for $TARGET_USER"

if [ -d "$SOURCE_DIR" ] && [ "$SOURCE_DIR" != "$REPO_DIR" ]; then
  if [ -e "$REPO_DIR" ]; then
    log "Repository already exists at $REPO_DIR; leaving $SOURCE_DIR in place"
  else
    log "Moving $SOURCE_DIR to $REPO_DIR"
    mv "$SOURCE_DIR" "$REPO_DIR"
  fi
elif [ -d "$REPO_DIR" ]; then
  log "Repository already available at $REPO_DIR"
else
  fail "neither $SOURCE_DIR nor $REPO_DIR exists"
fi

[ -d "$REPO_DIR" ] || fail "repository directory not found after setup: $REPO_DIR"

log "Ensuring repository ownership for $TARGET_USER"
chown -R "$TARGET_USER:users" "$REPO_DIR"

mkdir -p "$DMS_CONFIG" "$NIRI_USER_DIR"

log "Syncing Dank Material Shell settings"
copy_if_different "$REPO_DIR/DMS/settings.json" "$DMS_CONFIG/settings.json"
copy_if_different "$REPO_DIR/DMS/clsettings.json" "$DMS_CONFIG/clsettings.json"

log "Syncing Niri overrides"
copy_if_different "$REPO_DIR/DMS/overrides.kdl" "$NIRI_USER_DIR/overrides.kdl"
copy_if_different "$REPO_DIR/DMS/windowrules.kdl" "$NIRI_USER_DIR/windowrules.kdl"

log "Ensuring user ownership under $HOME_DIR/.config"
chown -R "$TARGET_USER:users" "$HOME_DIR/.config"

log "Done. Re-running this script is safe; unchanged files will be left alone."
