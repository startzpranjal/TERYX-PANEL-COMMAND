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

# Install deps
echo -e "${GREEN}[*] Installing dependencies...${NC}"
apt update
apt install -y git zip unzip curl nodejs npm ufw

# Install PM2
npm install -g pm2

echo -e "${GREEN}[*] Cloning daemon...${NC}"
rm -rf /opt/teryx-daemon
git clone https://github.com/dragonlabsdev/daemon /opt/teryx-daemon
cd /opt/teryx-daemon || exit

unzip -o daemon.zip
cd daemon || exit

npm install

echo -e "${GREEN}[✔] Installation Complete${NC}"

# Config input
echo -e "${YELLOW}"
echo "Paste your node configuration below."
echo "Press CTRL+D when finished."
echo -e "${NC}"

cat > config.json

echo -e "${GREEN}[✔] Configuration saved${NC}"

# Optional port open
read -p "Enter daemon port (or press Enter to skip): " PORT
if [ ! -z "$PORT" ]; then
  ufw allow $PORT
  echo -e "${GREEN}[✔] Port $PORT opened${NC}"
fi

# Start daemon
echo -e "${GREEN}[*] Starting daemon with PM2...${NC}"
pm2 start index.js --name teryx-daemon
pm2 save

# Enable startup
pm2 startup | bash

echo
echo -e "${GREEN}[✔] DAEMON RUNNING${NC}"
echo -e "${CYAN}Logs: pm2 logs teryx-daemon${NC}"
echo
