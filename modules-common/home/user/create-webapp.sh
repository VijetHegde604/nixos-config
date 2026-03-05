#!/usr/bin/env bash

# --- Web App Creator (Refactored) ---
# Tested on: NixOS Wayland (niri / Hyprland)
set -euo pipefail

# Configuration
CHOSEN_BROWSER="helium"
DESKTOP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/applications"
ICON_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/icons/hicolor/256x256/apps"

# Colors for UX
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

log() { echo -e "${GREEN}[*]${NC} $1"; }
error() { echo -e "${RED}[!] ERROR:${NC} $1"; exit 1; }

# 1. Dependency Check
command -v curl >/dev/null || error "curl is required but not installed."

# 2. Collect & Validate User Input
read -r -p "Enter App Name (e.g., ChatGPT): " APP_NAME
[[ -z "$APP_NAME" ]] && error "App Name cannot be empty."

read -r -p "Enter URL (e.g., https://chatgpt.com): " APP_URL
[[ -z "$APP_URL" ]] && error "URL cannot be empty."

read -r -p "Enter Icon URL (Optional, PNG preferred): " ICON_URL

# 3. Generate Clean Slug
# Trims leading/trailing hyphens and converts to lowercase
APP_SLUG=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | sed -e 's/[^a-z0-9]/-/g' -e 's/^-//' -e 's/-$//' -e 's/-+/-/g')

DESKTOP_FILE="$DESKTOP_DIR/$APP_SLUG.desktop"
ICON_PATH="$ICON_DIR/$APP_SLUG.png"

# 4. Handle Icon Logic
download_icon() {
    local url=$1
    local dest=$2
    log "Attempting to download icon..."
    curl -fsL --connect-timeout 5 "$url" -o "$dest"
}

mkdir -p "$DESKTOP_DIR" "$ICON_DIR"

ICON_VALUE="web-browser" # Default fallback

if [ -n "$ICON_URL" ]; then
    if download_icon "$ICON_URL" "$ICON_PATH"; then
        ICON_VALUE="$APP_SLUG"
    else
        echo "Provided URL failed."
    fi
fi

# If no icon yet, try Google's Favicon API (better than standard /favicon.ico)
if [ "$ICON_VALUE" == "web-browser" ]; then
    DOMAIN=$(echo "$APP_URL" | awk -F[/:] '{print $4}')
    API_ICON="https://www.google.com/s2/favicons?sz=256&domain=$DOMAIN"

    log "Fetching high-res favicon via API..."
    if download_icon "$API_ICON" "$ICON_PATH"; then
        ICON_VALUE="$APP_SLUG"
    fi
fi

# 5. Prevent Overwrite
if [ -f "$DESKTOP_FILE" ]; then
    read -r -p "Warning: $APP_NAME already exists. Overwrite? (y/N): " confirm
    [[ "${confirm,,}" == "y" ]] || { log "Aborted."; exit 0; }
fi

# 6. Create Desktop Entry
cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Type=Application
Name=$APP_NAME
Comment=Web App for $APP_NAME
Exec=$CHOSEN_BROWSER --app="$APP_URL" --ozone-platform=wayland --disable-vulkan %U
Icon=$ICON_VALUE
Terminal=false
Categories=Office;Productivity;Network;WebBrowser;
StartupNotify=true
StartupWMClass=$APP_SLUG
EOF

chmod +x "$DESKTOP_FILE"

# 7. Refresh Environment
log "Refreshing desktop database..."
command -v update-desktop-database >/dev/null && update-desktop-database "$DESKTOP_DIR"

echo -e "\n----------------------------------------"
echo -e "${GREEN}SUCCESS:${NC} $APP_NAME web app created"
echo -e "Location: $DESKTOP_FILE"
echo "----------------------------------------"
