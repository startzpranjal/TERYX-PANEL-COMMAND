#!/bin/bash

# Exit on error
set -e

# ASCII Art
ascii_startz="
  ███████╗████████╗ █████╗ ██████╗ ████████╗███████╗
  ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝╚══███╔╝
  ███████╗   ██║   ███████║██████╔╝   ██║     ███╔╝ 
  ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ███╔╝  
  ███████║   ██║   ██║  ██║██║  ██║   ██║   ███████╗
  ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝
"

ascii_panel="
  ████████╗███████╗██████╗ ██╗   ██╗██╗  ██╗██████╗  █████╗ ███╗   ██╗███████╗██╗     
  ╚══██╔══╝██╔════╝██╔══██╗╚██╗ ██╔╝╚██╗██╔╝██╔══██╗██╔══██╗████╗  ██║██╔════╝██║     
     ██║   █████╗  ██████╔╝ ╚████╔╝  ╚███╔╝ ██████╔╝███████║██╔██╗ ██║█████╗  ██║     
     ██║   ██╔══╝  ██╔══██╗  ╚██╔╝   ██╔██╗ ██╔═══╝ ██╔══██║██║╚██╗██║██╔══╝  ██║     
     ██║   ███████╗██║  ██║   ██║   ██╔╝ ██╗██║     ██║  ██║██║ ╚████║███████╗███████╗
     ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝
"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo_message() {
  echo -e "${GREEN}$1${NC}"
}

clear

# Root check
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script as root.${NC}"
  exit 1
fi

# Fix dpkg cross-device issue
echo_message "Fixing dpkg issues..."
mkdir -p /root/tmp
export TMPDIR=/root/tmp
apt-get clean

# Show banners
echo -e "${CYAN}$ascii_startz${NC}"
echo -e "${CYAN}$ascii_panel${NC}"

echo_message "Updating system..."
apt update -y && apt upgrade -y

echo_message "Installing dependencies..."
apt-get install -y curl git zip unzip software-properties-common

# Install Node.js LTS (v20)
echo_message "Installing Node.js (LTS)..."
curl -sL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# Verify installs
node -v
npm -v

echo_message "Cloning repository..."
rm -rf v4panel
git clone https://github.com/teryxlabs/v4panel
cd v4panel

# Install and run panel
echo_message "Installing npm packages..."
npm install

echo_message "Seeding database..."
npm run seed

echo_message "Creating user..."
npm run createUser

echo_message "Starting panel..."
node .

echo_message "Panel started successfully!"
