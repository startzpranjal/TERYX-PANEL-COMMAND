#!/bin/bash

# ASCII Art (STARTZ)
ascii_startz="

  ███████╗████████╗ █████╗ ██████╗ ████████╗███████╗
  ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝╚══███╔╝
  ███████╗   ██║   ███████║██████╔╝   ██║     ███╔╝ 
  ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ███╔╝  
  ███████║   ██║   ██║  ██║██║  ██║   ██║   ███████╗
  ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝

"

# ASCII Art (TERYXPANEL)
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
YELLOW='\033[0;33m'
NC='\033[0m'

# Message function
echo_message() {
  echo -e "${GREEN}$1${NC}"
}

clear

# Root check
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script as root.${NC}"
  exit 1
fi

# Show banners
echo -e "${CYAN}$ascii_startz${NC}"
echo -e "${CYAN}$ascii_panel${NC}"

echo "* Installing Dependencies..."

apt update -y
apt install -y curl software-properties-common git zip unzip

# Install Node.js (v23)
curl -sL https://deb.nodesource.com/setup_23.x | bash -
apt install -y nodejs

echo_message "* Dependencies Installed"

echo "* Cloning Panel..."

git clone https://github.com/teryxlabs/v4panel
cd v4panel || exit

# Unzip if exists
if [ -f "panel.zip" ]; then
  unzip panel.zip
fi

echo "* Detecting panel directory..."

# Auto-detect correct folder
PANEL_DIR=$(find . -maxdepth 1 -type d ! -name '.' | head -n 1)

if [ -n "$PANEL_DIR" ]; then
  cd "$PANEL_DIR" || exit
fi

echo_message "* Installing Panel Files..."

npm install
npm run seed
npm run createUser

echo_message "* Starting Panel..."

node .
