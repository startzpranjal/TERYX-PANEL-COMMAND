#!/bin/bash

# Colors
C1='\033[38;5;117m'
C2='\033[38;5;159m'
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

clear

# Banner
echo -e "${C1}"
echo "  ███████╗████████╗ █████╗ ██████╗ ████████╗███████╗"
echo "  ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝╚══███╔╝"
echo "  ███████╗   ██║   ███████║██████╔╝   ██║     ███╔╝ "
echo "  ╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ███╔╝  "
echo "  ███████║   ██║   ██║  ██║██║  ██║   ██║   ███████╗"
echo "  ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝"
echo -e "${NC}"

echo -e "${C2}"
echo "████████╗███████╗██████╗ ██╗   ██╗██╗  ██╗    ██████╗  █████╗ ███████╗"
echo "╚══██╔══╝██╔════╝██╔══██╗╚██╗ ██╔╝╚██╗██╔╝    ██╔══██╗██╔══██╗██╔════╝"
echo "   ██║   █████╗  ██████╔╝ ╚████╔╝  ╚███╔╝     ██████╔╝███████║█████╗  "
echo "   ██║   ██╔══╝  ██╔══██╗  ╚██╔╝   ██╔██╗     ██╔═══╝ ██╔══██║██╔══╝  "
echo "   ██║   ███████╗██║  ██║   ██║   ██╔╝ ██╗    ██║     ██║  ██║███████╗"
echo "   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝╚══════╝"
echo -e "${NC}"

echo -e "${CYAN}=========== TERYX DAEMON INSTALLER ===========${NC}"
echo

# Root check
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[✖] Run as root.${NC}"
  exit 1
fi

echo -e "${GREEN}[*] Installing Dependencies...${NC}"
apt update -y
apt install -y git zip unzip curl nodejs npm

echo -e "${GREEN}[✔] Dependencies Installed${NC}"

echo -e "${GREEN}[*] Installing Daemon...${NC}"
git clone https://github.com/dragonlabsdev/daemon
cd daemon || exit

unzip daemon.zip
cd daemon || exit

npm install

echo -e "${GREEN}[✔] Installation Complete${NC}"
echo
