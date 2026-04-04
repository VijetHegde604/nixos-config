#!/usr/bin/env bash

set -euo pipefail

TARGET_USER="${TARGET_USER:-vijeth}"
SOURCE_DIR="${SOURCE_DIR:-/etc/nixos/nixos-config}"
HOME_DIR="${HOME_DIR:-$(getent passwd "$TARGET_USER" | cut -d: -f6 || true)}"
REPO_NAME="${REPO_NAME:-nixos-config}"
REPO_DIR="${REPO_DIR:-${HOME_DIR:+$HOME_DIR/$REPO_NAME}}"
DMS_CONFIG="${DMS_CONFIG:-${HOME_DIR:+$HOME_DIR/.config/DankMaterialShell}}"
NIRI_CONFIG_DIR="${NIRI_CONFIG_DIR:-${HOME_DIR:+$HOME_DIR/.config/niri}}"

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

# New function to handle symlinking
link_config() {
  local src="$1"
  local dest="$2"

  [ -e "$src" ] || fail "source file/dir not found: $src"
  
  # Ensure the parent directory of the destination exists
  mkdir -p "$(dirname "$dest")"

  # If it's already a symlink to the right place, skip
  if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
    log "Already linked: $dest"
    return
  fi

  # Remove existing file/symlink if it exists to avoid 'File exists' errors
  rm -rf "$dest"
  
  ln -s "$src" "$dest"
  log "Symlinked: $dest -> $src"
}

require_command getent
require_command ln

[ -n "$HOME_DIR" ] || fail "could not resolve home directory for user '$TARGET_USER'"
[ -d "$HOME_DIR" ] || fail "home directory does not exist: $HOME_DIR"
[ "$EUID" -eq 0 ] || fail "run this script as root (activation scripts run as root)"

log "Starting post-install symlinking for $TARGET_USER"

# Handle the migration from /etc/nixos to the user home repo if necessary
if [ -d "$SOURCE_DIR" ] && [ "$SOURCE_DIR" != "$REPO_DIR" ]; then
  if [ -e "$REPO_DIR" ]; then
    log "Repository already exists at $REPO_DIR; leaving $SOURCE_DIR"
  else
    log "Moving $SOURCE_DIR to $REPO_DIR"
    mv "$SOURCE_DIR" "$REPO_DIR"
  fi
elif [ ! -d "$REPO_DIR" ]; then
  fail "neither $SOURCE_DIR nor $REPO_DIR exists"
fi

log "Ensuring repository ownership"
chown -R "$TARGET_USER:users" "$REPO_DIR"

# Symlink Dank Material Shell settings
link_config "$REPO_DIR/DMS/settings.json" "$DMS_CONFIG/settings.json"
link_config "$REPO_DIR/DMS/clsettings.json" "$DMS_CONFIG/clsettings.json"

# Symlink Niri overrides
link_config "$REPO_DIR/DMS/overrides.kdl" "$NIRI_CONFIG_DIR/dms/user/overrides.kdl"
link_config "$REPO_DIR/DMS/windowrules.kdl" "$NIRI_CONFIG_DIR/dms/windowrules.kdl"

log "Fixing ownership for .config entries"
chown -h "$TARGET_USER:users" "$DMS_CONFIG/settings.json" "$DMS_CONFIG/clsettings.json"
chown -h "$TARGET_USER:users" "$NIRI_CONFIG_DIR/dms/user/overrides.kdl"
chown -h "$TARGET_USER:users" "$NIRI_CONFIG_DIR/dms/windowrules.kdl"

log "Done. Symlinks are active."