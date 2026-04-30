#!/usr/bin/env bash
set -euo pipefail

# Bootstrap a fresh machine with this dotfiles repo.
# Idempotent — safe to re-run.

REPO_URL="https://github.com/apyshkin/os-setup"
LOCAL_BIN="$HOME/.local/bin"
NVIM_BIN="$LOCAL_BIN/nvim"
APPIMAGE_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage"

echo "=== os-setup bootstrap ==="

mkdir -p "$LOCAL_BIN"

# Ensure ~/.local/bin on PATH for current shell and future bash sessions
if ! echo "$PATH" | tr ':' '\n' | grep -qx "$LOCAL_BIN"; then
    export PATH="$LOCAL_BIN:$PATH"
    if [ -f "$HOME/.bashrc" ] && ! grep -q "\.local/bin" "$HOME/.bashrc"; then
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$HOME/.bashrc"
    fi
fi

# Install ripgrep (snacks.nvim live grep)
if ! command -v rg >/dev/null 2>&1; then
    if command -v apt-get >/dev/null 2>&1; then
        echo "Installing ripgrep (sudo)..."
        sudo apt-get install -y ripgrep
    elif command -v brew >/dev/null 2>&1; then
        echo "Installing ripgrep (brew)..."
        brew install ripgrep
    else
        echo "WARN: install ripgrep manually for snacks live grep"
    fi
fi

# Install Neovim AppImage (Linux only)
if [ "$(uname -s)" = "Linux" ] && [ ! -x "$NVIM_BIN" ]; then
    echo "Downloading Neovim AppImage..."
    curl -fLo "$NVIM_BIN" "$APPIMAGE_URL"
    chmod u+x "$NVIM_BIN"
elif [ "$(uname -s)" = "Darwin" ] && ! command -v nvim >/dev/null 2>&1; then
    if command -v brew >/dev/null 2>&1; then
        brew install neovim
    else
        echo "WARN: install nvim manually (brew install neovim)"
    fi
fi

# Install chezmoi
if [ ! -x "$LOCAL_BIN/chezmoi" ]; then
    echo "Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$LOCAL_BIN"
fi

# Apply dotfiles
echo "Initializing chezmoi from $REPO_URL..."
"$LOCAL_BIN/chezmoi" init --apply "$REPO_URL"

echo ""
echo "Done."
echo "  - dotfiles applied via chezmoi"
echo "  - 'chezmoi cd' to edit, 'chezmoi apply' to materialize"
echo "  - 'chezmoi git -- pull --rebase' to sync from remote"
