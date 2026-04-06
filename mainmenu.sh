#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check for figlet and install if missing
if ! command -v figlet &> /dev/null; then
    echo -e "${YELLOW}Installing dependencies...${NC}"
    apt-get update -y && apt-get install figlet -y &> /dev/null
fi

# Clear screen and show header once
clear
echo -e "${CYAN}"
figlet -f big "STARTZ"
echo -e "      MAIN MENU"
echo -e "${NC}"
echo -e "${YELLOW}=================================${NC}"

# Configure the menu prompt
PS3=$'\n'"Enter your choice: "

# Define the options
options=("Install Teryx Panel" "Install Teryx Daemon/Node" "Exit")

select opt in "${options[@]}"
do
    case $opt in
        "Install Teryx Panel")
            echo -e "\n${CYAN}Installing Teryx Panel...${NC}"
            bash -c "$(curl -sSL https://raw.githubusercontent.com/startzpranjal/TERYX-PANEL-COMMAND/refs/heads/main/teryxpanel.sh | bash)"
            echo -e "${GREEN}Task complete. Choose another option or Exit.${NC}"
            ;;
        "Install Teryx Daemon/Node")
            echo -e "\n${CYAN}Installing Teryx Daemon/Node...${NC}"
            bash -c "$(curl -sSL https://raw.githubusercontent.com/startzpranjal/TERYX-PANEL-COMMAND/refs/heads/main/teryxdaemon.sh | bash)"
            echo -e "${GREEN}Task complete. Choose another option or Exit.${NC}"
            ;;
        "Exit")
            echo -e "${RED}Exiting...${NC}"
            break
            ;;
        *) 
            echo -e "$Please pick 1, 2, or 3.${NC}"
            ;;
    esac
done
