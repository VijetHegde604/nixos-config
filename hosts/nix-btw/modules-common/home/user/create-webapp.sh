#!/usr/bin/env bash
set -euo pipefail

echo "--- Web App Creator ---"

# -------------------------------
# Detect default browser (clean way)
# -------------------------------
get_default_browser() {
  local desktop

  desktop="$(xdg-mime query default x-scheme-handler/http 2>/dev/null || true)"

  if [ -z "$desktop" ]; then
    echo "xdg-open"
    return
  fi

  echo "$desktop"
}

DESKTOP_ENTRY="$(get_default_browser)"
echo "Detected browser entry: $DESKTOP_ENTRY"

# Extract command safely
get_browser_cmd() {
  local desktop="$1"
  local exec

  exec="$(gtk-launch "$desktop" 2>/dev/null || true)"

  # fallback if gtk-launch fails
  if [ -z "$exec" ]; then
    exec="xdg-open"
  fi

  echo "$exec"
}

# We still prefer direct binary for --app support
get_browser_binary() {
  local desktop="$1"
  local file exec

  file="$(grep -rl "$desktop" \
    ~/.nix-profile/share/applications \
    /etc/profiles/per-user/$USER/share/applications \
    /run/current-system/sw/share/applications \
    2>/dev/null | head -n1)"

  if [ -z "$file" ]; then
    echo "xdg-open"
    return
  fi

  exec="$(grep '^Exec=' "$file" | head -n1 | cut -d= -f2)"

  exec="${exec//%u/}"
  exec="${exec//%U/}"
  exec="${exec//%f/}"
  exec="${exec//%F/}"

  exec="$(echo "$exec" | awk '{print $1}')"

  if echo "$exec" | grep -q "^/nix/store"; then
    exec="$(basename "$exec")"
  fi

  echo "$exec"
}

CHOSEN_BROWSER="$(get_browser_binary "$DESKTOP_ENTRY")"
echo "Using browser: $CHOSEN_BROWSER"

# -------------------------------
# User Input
# -------------------------------
read -rp "Enter App Name: " APP_NAME
read -rp "Enter URL: " APP_URL
read -rp "Enter Icon URL (optional): " ICON_URL

[ -n "$APP_NAME" ] || exit 1
[ -n "$APP_URL" ] || exit 1

APP_SLUG="$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9')"

ICON_DIR="$HOME/.local/share/icons"
APP_DIR="$HOME/.local/share/applications"

mkdir -p "$ICON_DIR" "$APP_DIR"

ICON_PATH="$ICON_DIR/$APP_SLUG.png"
DESKTOP_FILE="$APP_DIR/$APP_SLUG.desktop"

# -------------------------------
# Icon
# -------------------------------
if [ -n "$ICON_URL" ]; then
  curl -L --fail --silent "$ICON_URL" -o "$ICON_PATH" \
    && ICON_VALUE="$ICON_PATH" \
    || ICON_VALUE="web-browser"
else
  ICON_VALUE="web-browser"
fi

# -------------------------------
# Browser flags (safe)
# -------------------------------
if "$CHOSEN_BROWSER" --help 2>&1 | grep -q -- '--app'; then
  EXEC_CMD="$CHOSEN_BROWSER --app=$APP_URL"
else
  EXEC_CMD="$CHOSEN_BROWSER $APP_URL"
fi

# -------------------------------
# Desktop Entry
# -------------------------------
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Exec=$EXEC_CMD
Icon=$ICON_VALUE
Terminal=false
Categories=Network;WebBrowser;
EOF

chmod +x "$DESKTOP_FILE"

echo "----------------------------------------"
echo "SUCCESS: $APP_NAME created!"
echo "Exec: $EXEC_CMD"
echo "----------------------------------------"