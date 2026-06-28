#!/usr/bin/env bash

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INSTALL_DIR="$HOME/.local/share/install-web-apps"
BIN_DIR="$HOME/.local/bin"
USER_SHELL="$(basename "$SHELL")"

check_dependencies() {
    local missing=()

    for dep in gum jq curl; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            missing+=("$dep")
        fi
    done

    [ ${#missing[@]} -eq 0 ] && return

    echo
    echo "The following dependencies are missing:"
    printf "  • %s\n" "${missing[@]}"
    echo

    if command -v pacman >/dev/null 2>&1; then
        echo "Arch-based system detected."
        echo "Installing missing dependencies..."
        echo
        sudo pacman -S --needed "${missing[@]}"

    elif command -v apt >/dev/null 2>&1; then
        echo "Debian/Ubuntu detected."
        echo
        echo "Please run:"
        echo
        echo "    sudo apt update"
        echo "    sudo apt install ${missing[*]}"
        echo
        echo "Then run ./install.sh again."
        exit 1

    elif command -v dnf >/dev/null 2>&1; then
        echo "Fedora detected."
        echo
        echo "Please run:"
        echo
        echo "    sudo dnf install ${missing[*]}"
        echo
        echo "Then run ./install.sh again."
        exit 1

    elif command -v zypper >/dev/null 2>&1; then
        echo "openSUSE detected."
        echo
        echo "Please run:"
        echo
        echo "    sudo zypper install ${missing[*]}"
        echo
        echo "Then run ./install.sh again."
        exit 1

    else
        echo "Unsupported distribution."
        echo
        echo "Please install the following packages manually:"
        printf "  • %s\n" "${missing[@]}"
        echo
        echo "Then run ./install.sh again."
        exit 1
    fi
}

check_dependencies

echo "Installing Install Web Apps..."
echo

mkdir -p "$INSTALL_DIR"
mkdir -p "$BIN_DIR"

echo "Copying project..."

cp -r \
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

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "⚠ ~/.local/bin is not in your PATH."
    echo

    case "$USER_SHELL" in
        bash)
            read -rp "Would you like to add ~/.local/bin to your PATH permanently? [Y/n] " reply

            if [[ ! "$reply" =~ ^[Nn]$ ]]; then
                echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
                export PATH="$HOME/.local/bin:$PATH"

                echo
                echo "✓ ~/.local/bin has been added to ~/.bashrc."
                echo "✓ Commands are available immediately."
            else
                echo
                echo "To use the commands immediately, run:"
                echo
                echo '    export PATH="$HOME/.local/bin:$PATH"'
                echo
                echo "To make this permanent later, run:"
                echo
                echo '    echo '\''export PATH="$HOME/.local/bin:$PATH"'\'' >> ~/.bashrc'
            fi
            ;;

        fish)
            read -rp "Would you like to add ~/.local/bin to your Fish PATH permanently? [Y/n] " reply

            if [[ ! "$reply" =~ ^[Nn]$ ]]; then
                fish_add_path ~/.local/bin

                echo
                echo "✓ ~/.local/bin has been added to your Fish PATH."
                echo "✓ Commands are available immediately."
            else
                echo
                echo "Run the following command whenever you're ready:"
                echo
                echo "    fish_add_path ~/.local/bin"
            fi
            ;;

        *)
            echo "Please add ~/.local/bin to your PATH manually."
            ;;
    esac

    echo
fi

echo "✓ Installation Complete"
echo

if command -v web-apps >/dev/null 2>&1; then
    echo "✓ Installation verified."
else
    echo "⚠ Installation completed, but 'web-apps' is not yet available."
fi

echo
echo "Available commands:"
echo "  web-apps"
echo "  install-web-apps"
echo "  uninstall-web-apps"
