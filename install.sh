#!/bin/bash
# Install Neovim configuration from lchannng/nvim

# Check git
if ! command -v git &> /dev/null; then
    echo "Error: Please install git first"
    exit 1
fi

# Set directories
CONFIG_DIR="$HOME/.config"
NVIM_CONFIG_DIR="$CONFIG_DIR/nvim"

# Ensure config directory exists
if [ ! -d "$CONFIG_DIR" ]; then
    echo "Creating $CONFIG_DIR directory..."
    mkdir -p "$CONFIG_DIR"
fi

# Backup existing configuration
if [ -d "$NVIM_CONFIG_DIR" ]; then
    echo "Backing up existing configuration..."
    mv "$NVIM_CONFIG_DIR" "${NVIM_CONFIG_DIR}_backup_$(date +%Y%m%d)"
fi

# Clone repository
echo "Installing new configuration..."
git clone https://github.com/lchannng/nvim.git "$NVIM_CONFIG_DIR"

echo "Installation complete! Please restart Neovim."
