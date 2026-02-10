#!/bin/bash

# Requirements: curl
# Usage: ./create-webapp.sh
# Tested on: NixOS Wayland (niri / Hyprland)

set -e

echo "--- Web App Creator (Wayland-safe) ---"

CHOSEN_BROWSER="helium"

# 1. Collect User Input
read -r -p "Enter App Name (e.g., ChatGPT): " APP_NAME
read -r -p "Enter URL (e.g., https://chatgpt.com): " APP_URL
read -r -p "Enter Icon URL (Optional, PNG preferred): " ICON_URL

# 2. Paths
APP_SLUG=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9')
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
DESKTOP_FILE="$DESKTOP_DIR/$APP_SLUG.desktop"
ICON_NAME="$APP_SLUG"
ICON_PATH="$ICON_DIR/$ICON_NAME.png"

mkdir -p "$DESKTOP_DIR" "$ICON_DIR"

# 3. Handle Icon
if [ -z "$ICON_URL" ]; then
  echo "No icon provided, using system default."
  ICON_VALUE="web-browser"
else
  echo "Downloading icon..."
  curl -L "$ICON_URL" -o "$ICON_PATH"
  ICON_VALUE="$ICON_NAME"
fi

# 4. Create the .desktop file (Wayland-correct)
cat <<EOF >"$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Comment=Web App
Exec=$CHOSEN_BROWSER --app=$APP_URL --ozone-platform=wayland --disable-vulkan %U
Icon=$ICON_VALUE
Terminal=false
Categories=Office;Productivity;
StartupNotify=true
EOF

chmod +x "$DESKTOP_FILE"

echo "----------------------------------------"
echo "SUCCESS: $APP_NAME web app created"
echo "Desktop file: $DESKTOP_FILE"
echo "----------------------------------------"

# Refresh desktop database (safe on NixOS)
command -v update-desktop-database >/dev/null && update-desktop-database "$DESKTOP_DIR" || true
