#!/usr/bin/env bash
set -euo pipefail

NVIM_CONFIG_REPO="https://github.com/apyshkin/linux-setup"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_BIN_DIR="$HOME/.local/bin"
NVIM_BIN="$NVIM_BIN_DIR/nvim"
APPIMAGE_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"

echo "=== Neovim Setup ==="

# Install Neovim AppImage
mkdir -p "$NVIM_BIN_DIR"
if [ -f "$NVIM_BIN" ]; then
    echo "Existing nvim found at $NVIM_BIN, backing up to nvim.bak"
    mv "$NVIM_BIN" "$NVIM_BIN.bak"
fi

echo "Downloading Neovim AppImage..."
curl -fLo "$NVIM_BIN" "$APPIMAGE_URL"
chmod u+x "$NVIM_BIN"
echo "Installed nvim to $NVIM_BIN"

# Ensure ~/.local/bin is on PATH
if ! echo "$PATH" | grep -q "$NVIM_BIN_DIR"; then
    echo "export PATH=\"$NVIM_BIN_DIR:\$PATH\"" >> "$HOME/.bashrc"
    echo "Added $NVIM_BIN_DIR to PATH in ~/.bashrc"
fi

# Clone config
if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo "Config already exists at $NVIM_CONFIG_DIR, skipping clone"
else
    echo "Cloning nvim config..."
    git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG_DIR"
fi

echo ""
echo "Done! Run 'nvim' to start (plugins will install on first launch)."
