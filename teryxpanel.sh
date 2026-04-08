#!/bin/bash

# Gradient (light blue → light green)
C1='\033[38;5;117m'
C2='\033[38;5;123m'
C3='\033[38;5;159m'
C4='\033[38;5;151m'
C5='\033[38;5;120m'
NC='\033[0m'

clear

# Banner
echo -e "${C1}███████╗████████╗ █████╗ ██████╗ ████████╗███████╗"
echo -e "${C2}██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝╚══███╔╝"
echo -e "${C3}███████╗   ██║   ███████║██████╔╝   ██║     ███╔╝"
echo -e "${C4}╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ███╔╝"
echo -e "${C5}███████║   ██║   ██║  ██║██║  ██║   ██║   ███████╗"
echo -e "${C1}╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝"

echo
echo -e "${C3}          T E R Y X   P A N E L${NC}"
echo

# Root check
if [ "$EUID" -ne 0 ]; then
  echo "Run this script as root!"
  exit 1
fi

echo "[*] Fixing broken packages..."
apt clean
dpkg --configure -a
apt install -f -y

echo "[*] Installing dependencies..."
apt update
apt install -y curl software-properties-common git zip unzip

# Install Node.js
echo "[*] Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

# Install PM2
npm install -g pm2

echo "[*] Cloning panel..."
rm -rf v4panel
git clone https://github.com/teryxlabs/v4panel
cd v4panel || exit

echo "[*] Extracting panel..."
unzip -o panel.zip

echo "[*] Installing packages..."
npm install

echo "[*] Seeding database..."
npm run seed

echo "[*] Creating admin user..."

# AUTO USER INPUT
printf "admin@startz.com\nadmin\nadmin\nadmin\n" | npm run createUser

echo "[*] Starting panel with PM2..."
pm2 start npm --name teryx-panel -- run start
pm2 save

echo
echo -e "${C5}[✔] PANEL INSTALLED & RUNNING!${NC}"
echo -e "${C3}Login:${NC} admin@startz.com / admin"
echo -e "${C3}Logs:${NC} pm2 logs teryx-panel"
cd v4panel
