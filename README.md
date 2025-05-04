# VpsShieldPro

A comprehensive management script for Ubuntu 22.04 VPS with features focused on proxies and tunneling services. This tool provides an all-in-one solution for setting up and managing various proxy and tunneling services with an interactive menu system.

Created by MasterMind [@bitcockiii](https://t.me/bitcockiii)

![VpsShieldPro](generated-icon.png)

## Quick Start

```bash
# One-line installation
wget -O install.sh https://raw.githubusercontent.com/ubuntu-vps-manager/vpsmanger/main/install.sh && sudo bash install.sh
```

## Features

- **V2Ray WebSocket**:
  - TLS mode (with domain and SSL)
  - Non-TLS mode
  - Easy configuration management
  - Multi-user support with user management
  - Port adjustment after installation

- **SSH WebSocket Tunneling**:
  - WebSocket-based SSH access
  - Bypasses restrictions on standard SSH ports
  - Compatible with various SSH clients
  - Port adjustment after installation

- **Python Proxy (with 101 Protocol)**:
  - HTTP/HTTPS proxy
  - WebSocket 101 protocol support
  - CONNECT tunneling
  - Port adjustment after installation

- **SSE (Server-Sent Events) Proxy**:
  - Real-time event streaming
  - Proxying capabilities
  - Client management
  - Port adjustment after installation

- **UDP Custom**:
  - UDP forwarding for gaming and VoIP
  - Reduced latency for UDP applications
  - Configurable ports and buffer sizes
  - Port adjustment after installation

- **SSH UDP Tunneling**:
  - SSH over UDP protocol
  - Bypasses TCP-focused restrictions
  - More stable connection in some networks
  - Port adjustment after installation

- **BadVPN Management**:
  - Install and configure BadVPN binary
  - Start/stop service with one click
  - Change port configurations
  - Monitor service status

- **Additional Management Tools**:
  - Domain management with update capability
  - SSL certificate automation
  - System monitoring
  - Backup and restore
  - Firewall configuration

## Requirements

- Ubuntu 22.04 LTS
- Root access
- Basic system dependencies (installed automatically)

## Installation

### Quick Installation (Recommended)

One-line command to install VpsShieldPro:

```bash
wget -O install.sh https://raw.githubusercontent.com/ubuntu-vps-manager/vpsmanger/main/install.sh && sudo bash install.sh
```

After installation, you can run the script from anywhere using:

```bash
sudo vpsshieldpro
```

### Manual Installation

If you prefer to install manually:

```bash
# Download the script
git clone https://github.com/ubuntu-vps-manager/vpsmanger.git

# Navigate to the directory
cd vpsmanger

# Extract the files if they're in the zip archive
unzip VpsShieldPro.zip

# Make the script executable
chmod +x vps-manager.sh

# Run the script
sudo ./vps-manager.sh
```

## Command-line Options

The script supports several command-line options:

```bash
# Show help information
sudo ./vps-manager.sh --help

# Show version information
sudo ./vps-manager.sh --version

# Run in test mode
sudo ./vps-manager.sh --test

# Run in quiet mode
sudo ./vps-manager.sh --quiet
```

## Test Mode

This script includes a test mode that allows you to demonstrate functionality in non-Ubuntu environments (like Replit):

```bash
# Run the script in test mode
sudo ./vps-manager.sh --test
```

Test mode simulates the installation and configuration processes without making actual system changes, which is useful for:
- Demonstrating the script's capabilities
- Testing the UI and workflow
- Training purposes
- Development and debugging

Note: Test mode doesn't install actual services or make system modifications.

## Usage

The script provides an interactive menu system:

1. **Domain Management**:
   - Configure domain
   - Update domain settings
   - Manage SSL certificates

2. **V2Ray Management**:
   - Install V2Ray WebSocket (TLS/non-TLS)
   - View configuration
   - Uninstall

3. **SSH WebSocket Management**:
   - Install SSH WebSocket
   - View configuration
   - Uninstall

4. **Python Proxy Management**:
   - Install Python Proxy with 101 Protocol
   - View configuration
   - Uninstall

5. **SSE Proxy Management**:
   - Install SSE Proxy
   - View configuration
   - Uninstall

6. **UDP Custom Management**:
   - Install UDP Custom
   - View configuration
   - Uninstall

7. **SSH UDP Management**:
   - Install SSH over UDP
   - View configuration
   - Uninstall

8. **BadVPN Management**:
   - Install BadVPN binary
   - Configure BadVPN service
   - Start/stop service
   - Change service port

9. **System Management**:
   - Backup/restore configurations
   - View system resources
   - Update system
   - Update script

10. **Firewall Management**

## Key Features

### Port Adjustment

All services in this script support port adjustment after installation:
- Change listening ports for any running service
- Update all related configurations automatically
- No need to reinstall services when changing ports
- Useful for avoiding port conflicts or blockages

### Multi-User Support

The V2Ray module supports multiple user accounts:
- Create, view, modify, and delete user accounts
- Each user gets unique identifiers and access credentials
- Manage bandwidth and connection limits per user
- Export individual user configurations

## Service Details

### V2Ray WebSocket

- Supports VMess protocol over WebSocket
- TLS version requires a domain and valid SSL certificate
- Non-TLS version works with direct IP access
- Configuration is exported for easy client setup
- Multi-user support with user management interface
- Port adjustment capabilities after installation
- Detailed connection statistics and monitoring

### SSH WebSocket

- Tunnels SSH traffic over WebSocket
- Useful in environments where standard SSH ports are blocked
- Provides connection details for client configuration
- Port adjustment capabilities after installation
- Enhanced service management and monitoring

### Python Proxy

- Multi-protocol proxy supporting HTTP, HTTPS, and WebSocket
- WebSocket 101 Protocol for WebSocket connections
- Works with common browsers and applications
- Port adjustment capabilities after installation
- Detailed connection status information

### SSE Proxy

- Server-Sent Events proxy for real-time data streaming
- Supports proxying to another SSE server
- Provides client connection management and statistics
- Port adjustment capabilities after installation
- Interactive endpoint management

### UDP Custom

- UDP forwarding service for optimizing gaming, VoIP, and other UDP-based applications
- Lower latency compared to TCP-based connections
- Configurable buffer sizes for performance optimization
- Compatible with various game clients and VoIP applications
- Port adjustment capabilities after installation
- Simple client configuration

### SSH UDP Tunneling

- SSH access over UDP protocol
- Bypasses restrictions on TCP connections
- More reliable in networks with high packet loss
- Provides simple client connection instructions
- Port adjustment capabilities after installation
- Compatible with standard SSH clients through a local proxy

### BadVPN Management

- Dedicated UDP gateway for improving UDP traffic
- Separate from the core UDP Custom service
- Optimized for use with SSH UDP tunneling
- User-friendly service management interface
- Port customization support
- Detailed connection information and usage instructions

## License

MIT License

## Disclaimer

This tool is provided for educational and legitimate use cases. Users are responsible for complying with all applicable laws and regulations when using this software.