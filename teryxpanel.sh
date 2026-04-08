#!/bin/bash

# Gradient colors
C1='\033[38;5;196m'  # red
C2='\033[38;5;202m'
C3='\033[38;5;208m'
C4='\033[38;5;214m'
C5='\033[38;5;220m'
NC='\033[0m'

clear

echo -e "${C1}███████╗████████╗ █████╗ ██████╗ ████████╗███████╗"
echo -e "${C2}██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝╚══███╔╝"
echo -e "${C3}███████╗   ██║   ███████║██████╔╝   ██║     ███╔╝ "
echo -e "${C4}╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ███╔╝  "
echo -e "${C5}███████║   ██║   ██║  ██║██║  ██║   ██║   ███████╗"
echo -e "${C1}╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝"

echo
echo -e "${C3}          T E R Y X   P A N E L${NC}"
echo

# Clear the screen
clear
# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script as root.${NC}"
  exit 1
fi

echo -e "${CYAN}$ascii_art${NC}"


echo "* Installing Dependencies"

# Update package list and install dependencies
sudo apt update
sudo apt install -y curl software-properties-common
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install nodejs -y 
sudo apt install git -y

echo_message "* Installed Dependencies"

echo "* panel owner hopingboyz"

# Create directory, clone repository, and install files

echo "Installing the panel..."

#!/bin/bash

# Colors
C1='\033[38;5;196m'
C2='\033[38;5;202m'
C3='\033[38;5;208m'
C4='\033[38;5;214m'
C5='\033[38;5;220m'
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
  echo "Run as root!"
  exit 1
fi

echo "[*] Installing dependencies..."

apt update
apt install -y curl software-properties-common git zip unzip

# Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

echo "[*] Cloning panel..."
git clone https://github.com/teryxlabs/v4panel
cd v4panel || exit

echo "[*] Extracting..."
unzip panel.zip

echo "[*] Installing npm packages..."
npm install

echo "[*] Seeding..."
npm run seed

echo "[*] Creating user..."
npm run createUser

echo "[*] Starting panel..."
node .

