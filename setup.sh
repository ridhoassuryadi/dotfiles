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

    # Install FiraCode font
    echo "Installing FiraCode font..."
    if ! brew list --cask | grep -q "font-fira-code"; then
        brew tap homebrew/cask-fonts
        brew install --cask font-fira-code
        echo "FiraCode font installed."
    else
        echo "FiraCode font already installed."
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

    # Install FiraCode font
    echo "Installing FiraCode font..."
    if ! brew list --cask | grep -q "font-fira-code"; then
        brew tap homebrew/cask-fonts
        brew install --cask font-fira-code
        echo "FiraCode font installed."
    else
        echo "FiraCode font already installed."
    fi
fi

# Install Nix (single-user mode)
echo "Installing Nix..."
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Source Nix profile for current shell
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
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

    # Install FiraCode font
    echo "Installing FiraCode font..."
    if ! brew list --cask | grep -q "font-fira-code"; then
        brew tap homebrew/cask-fonts
        brew install --cask font-fira-code
        echo "FiraCode font installed."
    else
        echo "FiraCode font already installed."
    fi
fi

# Add Home Manager channel
echo "Adding Home Manager channel..."
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update

# Install Home Manager
echo "Installing Home Manager..."
nix-shell '<home-manager>' -A install

echo "Nix and Home Manager installation complete!

echo "Do you want to install Flatpak? [y/N]"
read -r install_flatpak
if [[ "$install_flatpak" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "Installing Flatpak using Homebrew..."
        brew install flatpak
    elif [[ -f /etc/debian_version ]]; then
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

    # Install FiraCode font
    echo "Installing FiraCode font..."
    if ! brew list --cask | grep -q "font-fira-code"; then
        brew tap homebrew/cask-fonts
        brew install --cask font-fira-code
        echo "FiraCode font installed."
    else
        echo "FiraCode font already installed."
    fi
fi
else
    echo "Skipping Flatpak installation."
fi