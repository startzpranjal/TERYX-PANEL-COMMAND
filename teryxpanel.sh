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

echo "* Installing Dependencies..."

apt update -y
apt install -y curl software-properties-common git zip unzip

# Node.js
curl -sL https://deb.nodesource.com/setup_23.x | bash -
apt install -y nodejs

echo_message "* Dependencies Installed"

echo "* Cloning and Installing Panel..."

git clone https://github.com/teryxlabs/v4panel
cd v4panel || exit

unzip panel.zip
cd panel || exit

npm install
npm run seed
npm run createUser

npm install -g pm2
pm2 start .

echo_message "* Panel Installed Successfully"
echo "* Panel is now running 🚀"
