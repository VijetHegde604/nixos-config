#!/usr/bin/env bash

TARGET_USER="vijeth"
SOURCE_DIR="/etc/nixos/nixos-config"
HOME_DIR="/home/$TARGET_USER"
REPO_DIR="$HOME_DIR/nixos-config"
DMS_CONFIG="$HOME_DIR/.config/DankMaterialShell"
NIRI_USER_DIR="$HOME_DIR/.config/niri/dms/user"

echo "Starting post-install configuration..."

# 1. Move the config directory to home
if [ -d "$SOURCE_DIR" ]; then
    echo "Moving $SOURCE_DIR to $HOME_DIR..."
    sudo mv "$SOURCE_DIR" "$HOME_DIR/"
else
    echo "Error: $SOURCE_DIR not found!"
fi

# 2. Fix permissions
echo "Setting ownership to $TARGET_USER..."
sudo chown -R $TARGET_USER:users "$REPO_DIR"

# Ensure config directories exist
mkdir -p "$DMS_CONFIG"
mkdir -p "$NIRI_USER_DIR"

# 3. & 4. Copy DMS settings
echo "Configuring Dank Material Shell settings..."
cp "$REPO_DIR/DMS/settings.json" "$DMS_CONFIG/"
cp "$REPO_DIR/DMS/clsettings.json" "$DMS_CONFIG/"

# 6. Copy Niri overrides
echo "Applying Niri configs..."
cp "$REPO_DIR/DMS/overrides.kdl" "$NIRI_USER_DIR/"
cp "$REPO_DIR/DMS/windowrules.kdl" "$NIRI_USER_DIR/windowrules.kdl"

# Final permissions check for the newly created .config files
chown -R $TARGET_USER:users "$HOME_DIR/.config"

echo "Done! Your NixOS and DMS configs are staged."
