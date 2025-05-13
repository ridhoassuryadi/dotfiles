#!/usr/bin/env bash
set -e

# Check and install Homebrew if on macOS
if [[ "$(uname)" == "Darwin" ]]; then
    if ! command -v brew >/dev/null 2>&1; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed."
    fi
fi


# Install Nix (single-user mode) jika belum terinstal
if ! command -v nix >/dev/null 2>&1; then
    echo "Nix is not installed. Installing Nix..."
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
else
    echo "Nix is already installed."
fi

# Source Nix profile for current shell
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Install Home Manager jika belum terinstal
if ! command -v home-manager >/dev/null 2>&1; then
    echo "Home Manager is not installed. Installing Home Manager..."
    nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
else
    echo "Home Manager is already installed."
fi

echo "Nix and Home Manager installation complete!"

# Only offer Flatpak for non-macOS (Linux)
if [[ "$(uname)" != "Darwin" ]]; then
    echo "Do you want to install Flatpak? [y/N]"
    read -r install_flatpak
    if [[ "$install_flatpak" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        if [[ -f /etc/debian_version ]]; then
            echo "Installing Flatpak using apt..."
            sudo apt update && sudo apt install -y flatpak
        elif [[ -f /etc/redhat-release ]]; then
            echo "Installing Flatpak using yum..."
            sudo yum install -y flatpak
        elif [[ -f /etc/arch-release ]]; then
            echo "Installing Flatpak using pacman..."
            sudo pacman -S --noconfirm flatpak
        else
            echo "Please install Flatpak manually for your distribution."
        fi
    fi
fi

# Install Monaco font
if [[ "$(uname)" == "Darwin" ]]; then
    echo "Installing Monaco font..."
    MONACO_URL="https://github.com/todylu/monaco.ttf/raw/master/monaco.ttf"
    MONACO_FONT="$HOME/Library/Fonts/Monaco.ttf"
    if [ ! -f "$MONACO_FONT" ]; then
        curl -fLo "$MONACO_FONT" --create-dirs "$MONACO_URL"
        echo "Monaco font installed."
    else
        echo "Monaco font already exists."
    fi

    # Install FiraCode font (tanpa Homebrew/cask-fonts)
    echo "Installing FiraCode font..."
    FIRACODE_URL="https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip"
    FIRACODE_ZIP="/tmp/FiraCode.zip"
    FIRACODE_DIR="/tmp/FiraCode"
    mkdir -p "$FIRACODE_DIR"
    curl -fLo "$FIRACODE_ZIP" "$FIRACODE_URL"
    unzip -o "$FIRACODE_ZIP" -d "$FIRACODE_DIR"
    cp -v "$FIRACODE_DIR"/ttf/*.ttf "$HOME/Library/Fonts/"
    rm -rf "$FIRACODE_ZIP" "$FIRACODE_DIR"
    echo "FiraCode font installed."

fi
