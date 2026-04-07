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

echo "* Cloning Repository..."

git clone https://github.com/teryxlabs/v4panel 
cd v4panel

# Node.js
echo 'Installing Depenciencies'
curl -sL https://deb.nodesource.com/setup_23.x | sudo bash -
apt-get install nodejs git

echo_message "* Dependencies Installed"

echo "* Installing Important things..."

apt install zip -y && unzip panel.zip
npm install && npm run seed && npm run createUser

echo "STARTING PANEL..."

npm install && npm run seed && npm run createUser

echo "PANEL STARTED"
node .
