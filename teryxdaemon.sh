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

# ASCII Art (TERYX DAEMON)
ascii_daemon="

████████╗███████╗██████╗ ██╗   ██╗██╗  ██╗    ██████╗  █████╗ ███████╗
╚══██╔══╝██╔════╝██╔══██╗╚██╗ ██╔╝╚██╗██╔╝    ██╔══██╗██╔══██╗██╔════╝
   ██║   █████╗  ██████╔╝ ╚████╔╝  ╚███╔╝     ██████╔╝███████║█████╗  
   ██║   ██╔══╝  ██╔══██╗  ╚██╔╝   ██╔██╗     ██╔═══╝ ██╔══██║██╔══╝  
   ██║   ███████╗██║  ██║   ██║   ██╔╝ ██╗    ██║     ██║  ██║███████╗
   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝╚══════╝

"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo_message() {
  echo -e "${GREEN}$1${NC}"
}

clear

# Root check
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Run as root.${NC}"
  exit 1
fi

# Show banners
echo -e "${CYAN}$ascii_startz${NC}"
echo -e "${CYAN}$ascii_daemon${NC}"

echo "* Installing Dependencies..."
apt update -y
apt install -y git zip unzip curl nodejs npm

echo_message "* Dependencies Installed"

echo "* Installing Daemon..."
git clone https://github.com/dragonlabsdev/daemon
cd daemon || exit

unzip daemon.zip
cd daemon || exit

npm install

echo_message "* Installation Complete"

# 🔥 Config input section
echo -e "${YELLOW}"
echo "Paste your node configuration below."
echo "When done, press CTRL+D"
echo -e "${NC}"

cat > config.json

echo_message "* Configuration Saved"

# 🔥 Auto start
echo_message "* Starting Daemon..."
node .
