#!/bin/bash

# VpsShieldPro Installer
# Created by MasterMind (@bitcockiii)

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logo
echo -e "╔════════════════════════════════════════════════════════════╗"
echo -e "║               ${GREEN}VpsShieldPro Auto Installer${NC}               ║"
echo -e "║         ${YELLOW}Created by MasterMind @bitcockiii${NC}            ║"
echo -e "╚════════════════════════════════════════════════════════════╝"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "[${RED}ERROR${NC}] This script must be run as root. Please use sudo."
  exit 1
fi

# Check if system is Ubuntu 22.04
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [ "$ID" = "ubuntu" ] && [[ "$VERSION_ID" == "22.04"* ]]; then
        echo -e "[${GREEN}INFO${NC}] Detected Ubuntu 22.04 - Proceeding with installation"
    else
        echo -e "[${YELLOW}WARNING${NC}] This script is designed for Ubuntu 22.04, but detected $PRETTY_NAME"
        read -p "Do you want to continue anyway? (y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "[${RED}ABORTED${NC}] Installation cancelled by user"
            exit 1
        fi
    fi
else
    echo -e "[${YELLOW}WARNING${NC}] Could not determine OS version"
    read -p "Do you want to continue anyway? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "[${RED}ABORTED${NC}] Installation cancelled by user"
        exit 1
    fi
fi

# Install dependencies
echo -e "[${GREEN}INFO${NC}] Installing dependencies..."
apt-get update -q
apt-get install -y -q wget unzip git curl

# Create installation directory
echo -e "[${GREEN}INFO${NC}] Creating installation directory..."
INSTALL_DIR="/opt/vpsshieldpro"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit 1

# Download the package
echo -e "[${GREEN}INFO${NC}] Downloading VpsShieldPro from GitHub..."
if command -v git &> /dev/null; then
    echo -e "[${GREEN}INFO${NC}] Using Git to clone the repository..."
    
    # Clean up any previous download attempts
    rm -rf VpsShieldPro.zip VpsShieldPro temp_dir
    
    # Clone the repository
    git clone https://github.com/ubuntu-vps-manager/vpsmanger.git temp_dir
    
    if [ $? -eq 0 ]; then
        echo -e "[${GREEN}SUCCESS${NC}] Repository cloned successfully"
        
        # Check if VpsShieldPro.zip exists in the cloned repo
        if [ -f "temp_dir/VpsShieldPro.zip" ]; then
            # Move the zip file to the installation directory
            mv temp_dir/VpsShieldPro.zip .
        else
            echo -e "[${RED}ERROR${NC}] VpsShieldPro.zip not found in the repository"
            exit 1
        fi
        
        # Clean up the temporary directory
        rm -rf temp_dir
    else
        echo -e "[${RED}ERROR${NC}] Failed to clone repository"
        
        # Fallback to direct download
        echo -e "[${YELLOW}WARNING${NC}] Falling back to direct download..."
        wget -q https://github.com/ubuntu-vps-manager/vpsmanger/raw/main/VpsShieldPro.zip -O VpsShieldPro.zip
        
        if [ $? -ne 0 ]; then
            echo -e "[${RED}ERROR${NC}] Failed to download VpsShieldPro.zip"
            exit 1
        fi
    fi
else
    echo -e "[${GREEN}INFO${NC}] Using wget to download the package..."
    wget -q https://github.com/ubuntu-vps-manager/vpsmanger/raw/main/VpsShieldPro.zip -O VpsShieldPro.zip
    
    if [ $? -ne 0 ]; then
        echo -e "[${RED}ERROR${NC}] Failed to download VpsShieldPro.zip"
        exit 1
    fi
fi

# Extract the package
echo -e "[${GREEN}INFO${NC}] Extracting VpsShieldPro.zip..."
unzip -q VpsShieldPro.zip

# Check if the extraction created a subdirectory
if [ -d "VpsShieldPro" ]; then
    echo -e "[${GREEN}INFO${NC}] Moving files from subdirectory..."
    # Move all files from the subdirectory to the installation directory
    mv VpsShieldPro/* .
    rm -rf VpsShieldPro
fi

# Set permissions
echo -e "[${GREEN}INFO${NC}] Setting proper permissions..."
chmod +x vps-manager.sh
find . -name "*.sh" -exec chmod +x {} \;

# Check if main script exists
if [ ! -f "vps-manager.sh" ]; then
    echo -e "[${RED}ERROR${NC}] Main script not found in the expected location"
    echo -e "[${YELLOW}INFO${NC}] Files in installation directory:"
    ls -la
    exit 1
fi

# Create global command
echo -e "[${GREEN}INFO${NC}] Creating global command..."
ln -sf "$INSTALL_DIR/vps-manager.sh" /usr/local/bin/vpsshieldpro
chmod +x /usr/local/bin/vpsshieldpro

# Clean up
echo -e "[${GREEN}INFO${NC}] Cleaning up installation files..."
rm -f VpsShieldPro.zip

# Success message
echo -e "╔════════════════════════════════════════════════════════════╗"
echo -e "║             ${GREEN}VpsShieldPro Installed Successfully${NC}          ║"
echo -e "║                                                            ║"
echo -e "║  ${YELLOW}Run the script with:${NC} ${GREEN}sudo vpsshieldpro${NC}                    ║"
echo -e "║                                                            ║"
echo -e "║  ${YELLOW}Installation Directory:${NC} ${GREEN}$INSTALL_DIR${NC}              ║"
echo -e "╚════════════════════════════════════════════════════════════╝"

# Ask to run now
read -p "Do you want to run VpsShieldPro now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    cd "$INSTALL_DIR" || exit 1
    ./vps-manager.sh
fi

exit 0