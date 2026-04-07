#!/bin/bash
set -e

# =============================
# Colors
# =============================
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# =============================
# ASCII
# =============================
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

echo -e "${CYAN}$ascii_startz${NC}"
echo -e "${CYAN}$ascii_panel${NC}"

# =============================
# Root check
# =============================
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run as root.${NC}"
  exit 1
fi

# =============================
# 🔥 FIX dpkg error (IMPORTANT)
# =============================
echo -e "${GREEN}Fixing dpkg cross-device error...${NC}"
echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/02fix
apt-get clean
rm -rf /var/cache/apt/archives/*
apt-get update -y

# =============================
# Install dependencies
# =============================
echo -e "${GREEN}Installing dependencies...${NC}"
apt-get install -y curl git zip unzip ca-certificates software-properties-common

# =============================
# Install Node.js (LTS)
# =============================
echo -e "${GREEN}Installing Node.js LTS...${NC}"
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

# =============================
# Verify installs
# =============================
echo -e "${GREEN}Checking versions...${NC}"
node -v
npm -v

# =============================
# Clone repo
# =============================
echo -e "${GREEN}Cloning panel repo...${NC}"
rm -rf v4panel
git clone https://github.com/teryxlabs/v4panel
cd v4panel

# =============================
# Install panel
# =============================
echo -e "${GREEN}Installing panel dependencies...${NC}"
npm install

# =============================
# Setup panel
# =============================
echo -e "${GREEN}Running setup...${NC}"
npm run seed
npm run createUser

# =============================
# Start panel
# =============================
echo -e "${GREEN}Starting panel...${NC}"
node .

echo -e "${GREEN}Panel started successfully!${NC}"
