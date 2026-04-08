# ASCII Art
ascii_art="

RED='\033[0;31m'
NC='\033[0m'

echo -e "${RED}

███████╗████████╗ █████╗ ██████╗ ████████╗███████╗
██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝╚══███╔╝
███████╗   ██║   ███████║██████╔╝   ██║     ███╔╝ 
╚════██║   ██║   ██╔══██║██╔══██╗   ██║    ███╔╝  
███████║   ██║   ██║  ██║██║  ██║   ██║   ███████╗
╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝

              T E R Y X   P A N E L

${NC}"

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

git clone https://github.com/teryxlabs/v4panel && curl -sL https://deb.nodesource.com/setup_23.x | sudo bash - && apt-get install nodejs git && cd v4panel && apt install zip -y && unzip panel.zip && npm install && npm run seed && npm run createUser && node .

