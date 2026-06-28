#!/usr/bin/env bash

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INSTALL_DIR="$HOME/.local/share/install-web-apps"
BIN_DIR="$HOME/.local/bin"

echo "Installing Install Web Apps..."
echo

mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

echo "Copying project..."

cp -r \
    "$PROJECT_DIR/assets" \
    "$PROJECT_DIR/lib" \
    "$PROJECT_DIR/install-web-apps" \
    "$PROJECT_DIR/uninstall-web-apps" \
    "$PROJECT_DIR/web-apps" \
    "$INSTALL_DIR"

echo "Creating launcher commands..."

ln -sf "$INSTALL_DIR/install-web-apps" "$BIN_DIR/install-web-apps"
ln -sf "$INSTALL_DIR/uninstall-web-apps" "$BIN_DIR/uninstall-web-apps"
ln -sf "$INSTALL_DIR/web-apps" "$BIN_DIR/web-apps"

echo

echo "✓ Installation Complete"

echo
echo "Available commands:"
echo "  web-apps"
echo "  install-web-apps"
echo "  uninstall-web-apps"
