#!/bin/bash

# VpsShieldPro Auto Installer
# Created by MasterMind (@bitcockiii)

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display colored text
echo_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

echo_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

echo_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

echo_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [ "$(id -u)" != "0" ]; then
    echo_error "This installer must be run as root"
    echo "Please run: sudo bash $0"
    exit 1
fi

# Check if running on Ubuntu 22.04
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "$ID" != "ubuntu" ] || [ "$VERSION_ID" != "22.04" ]; then
        echo_warning "This script is designed for Ubuntu 22.04"
        echo_warning "Current system: $PRETTY_NAME"
        echo "Do you want to continue anyway? (y/n)"
        read -r choice
        if [[ ! $choice =~ ^[Yy]$ ]]; then
            echo_info "Installation cancelled"
            exit 0
        fi
    else
        echo_info "Detected Ubuntu 22.04 - Proceeding with installation"
    fi
else
    echo_warning "Cannot determine OS - proceeding anyway"
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║               ${GREEN}VpsShieldPro Auto Installer${BLUE}               ║${NC}"
echo -e "${BLUE}║         ${CYAN}Created by MasterMind ${YELLOW}@bitcockiii${BLUE}            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"

# Install dependencies
echo_info "Installing dependencies..."
apt update -y
apt install -y git curl wget zip unzip tar >/dev/null 2>&1

# Set installation directory
INSTALL_DIR="/opt/vpsshieldpro"

# Create installation directory
echo_info "Creating installation directory..."
mkdir -p "$INSTALL_DIR"

# Download the latest version
echo_info "Downloading VpsShieldPro from GitHub..."

# Check if git is installed
if command -v git &>/dev/null; then
    # Clone the repository
    echo_info "Using Git to clone the repository..."
    if git clone https://github.com/ubuntu-vps-manager/vpsmanger.git "$INSTALL_DIR/temp" 2>/dev/null; then
        echo_success "Repository cloned successfully"
        
        # Check if zip file exists in the repo
        if [ -f "$INSTALL_DIR/temp/VpsShieldPro.zip" ]; then
            echo_info "Extracting VpsShieldPro.zip..."
            unzip -q "$INSTALL_DIR/temp/VpsShieldPro.zip" -d "$INSTALL_DIR"
            rm -rf "$INSTALL_DIR/temp"
        else
            echo_info "Moving files to installation directory..."
            mv "$INSTALL_DIR/temp"/* "$INSTALL_DIR/"
            mv "$INSTALL_DIR/temp"/.[!.]* "$INSTALL_DIR/" 2>/dev/null || true
            rm -rf "$INSTALL_DIR/temp"
        fi
    else
        # Fallback to direct download method
        echo_warning "Git clone failed, trying direct download..."
        direct_download=true
    fi
else
    echo_warning "Git not available, using direct download method..."
    direct_download=true
fi

# Direct download method (as a fallback)
if [ "$direct_download" = true ]; then
    # Create temporary directory
    TMP_DIR=$(mktemp -d)
    
    # Download the zip file
    echo_info "Downloading zip file..."
    if ! wget -q -O "$TMP_DIR/VpsShieldPro.zip" "https://github.com/ubuntu-vps-manager/vpsmanger/raw/main/VpsShieldPro.zip"; then
        echo_error "Failed to download zip file"
        echo_info "Trying alternative URL..."
        
        if ! curl -s -L -o "$TMP_DIR/VpsShieldPro.zip" "https://github.com/ubuntu-vps-manager/vpsmanger/raw/main/VpsShieldPro.zip"; then
            echo_error "Download failed. Please check your internet connection"
            echo_info "Try manual installation:"
            echo "1. Download VpsShieldPro.zip from https://github.com/ubuntu-vps-manager/vpsmanger"
            echo "2. Extract it and run: sudo ./vps-manager.sh"
            rm -rf "$TMP_DIR"
            exit 1
        fi
    fi
    
    # Extract the zip file
    echo_info "Extracting files..."
    unzip -q "$TMP_DIR/VpsShieldPro.zip" -d "$INSTALL_DIR"
    
    # Clean up temporary directory
    rm -rf "$TMP_DIR"
fi

# Make the script executable
echo_info "Setting proper permissions..."
if [ -f "$INSTALL_DIR/vps-manager.sh" ]; then
    chmod +x "$INSTALL_DIR/vps-manager.sh"
else
    echo_error "Main script not found in the expected location"
    echo_info "Files in installation directory:"
    ls -la "$INSTALL_DIR"
    exit 1
fi

# Create symlink for easy access
echo_info "Creating system-wide command..."
ln -sf "$INSTALL_DIR/vps-manager.sh" /usr/local/bin/vpsshieldpro

# Create installation verification file
echo "installed=true" > "$INSTALL_DIR/.initialized"
echo "install_date=$(date +%Y-%m-%d)" >> "$INSTALL_DIR/.initialized"
echo "version=1.0.0" >> "$INSTALL_DIR/.initialized"

# Final success message
echo_success "VpsShieldPro has been successfully installed!"
echo -e "${CYAN}You can now run it using:${NC}"
echo -e "  ${GREEN}sudo vpsshieldpro${NC}"
echo -e "  ${GREEN}sudo $INSTALL_DIR/vps-manager.sh${NC}"

# Ask if user wants to run the script now
echo
echo -e "${CYAN}Do you want to run VpsShieldPro now? (y/n)${NC}"
read -r choice
if [[ $choice =~ ^[Yy]$ ]]; then
    echo_info "Starting VpsShieldPro..."
    sudo vpsshieldpro
fi

exit 0