#!/bin/bash

# Colors
C1='\033[38;5;117m'
C2='\033[38;5;159m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

clear

# Banner
echo -e "${C1}████████╗███████╗██████╗ ██╗   ██╗██╗  ██╗${NC}"
echo -e "${C2}╚══██╔══╝██╔════╝██╔══██╗╚██╗ ██╔╝╚██╗██╔╝${NC}"
echo -e "${C1}   ██║   █████╗  ██████╔╝ ╚████╔╝  ╚███╔╝ ${NC}"
echo -e "${C2}   ██║   ██╔══╝  ██╔══██╗  ╚██╔╝   ██╔██╗ ${NC}"
echo -e "${C1}   ██║   ███████╗██║  ██║   ██║   ██╔╝ ██╗${NC}"
echo -e "${C2}   ╚═╝   ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝${NC}"

echo -e "${CYAN}        TERYX DAEMON INSTALLER${NC}"
echo

# Root check
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Run as root!${NC}"
  exit 1
fi

# Fix packages
echo -e "${GREEN}[*] Fixing packages...${NC}"
apt clean
dpkg --configure -a
apt install -f -y

# Install dependencies
echo -e "${GREEN}[*] Installing dependencies...${NC}"
apt update
apt install -y git zip unzip curl nodejs npm ufw

# Install daemon
echo -e "${GREEN}[*] Installing daemon...${NC}"
rm -rf /opt/teryx-daemon
git clone https://github.com/dragonlabsdev/daemon /opt/teryx-daemon
cd /opt/teryx-daemon || exit

unzip -o daemon.zip
cd daemon || exit

npm install

echo -e "${GREEN}[✔] Installation complete${NC}"

# Config input
echo -e "${YELLOW}"
echo "Paste your config.json below"
echo "Press CTRL+D when done"
echo -e "${NC}"

cat > config.json

echo -e "${GREEN}[✔] Config saved${NC}"

# Optional firewall
read -p "Enter daemon port to open (or press Enter to skip): " PORT
if [ ! -z "$PORT" ]; then
  ufw allow $PORT
  echo -e "${GREEN}[✔] Port $PORT opened${NC}"
fi

echo
echo -e "${CYAN}To start daemon manually:${NC}"
echo -e "${GREEN}cd /opt/teryx-daemon/daemon${NC}"
echo -e "${GREEN}node .${NC}"
echo
echo -e "${YELLOW}Tip: Use screen or tmux to keep it running${NC}"
echo
