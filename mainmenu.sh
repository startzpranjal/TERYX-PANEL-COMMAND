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

draw_menu() {
    clear
    echo -e "${CYAN}"
    figlet -f big "STARTZ"
    echo -e "      MAIN MENU"
    echo -e "${NC}"
    echo -e "${YELLOW}=================================${NC}"
    echo -e "${GREEN}1.${NC} Install Teryx Panel"
    echo -e "${GREEN}2.${NC} Install Teryx Daemon/Node"
    echo -e "${RED}0.${NC} Exit"
    echo -e "${YELLOW}=================================${NC}"
}

while true; do
    draw_menu
    echo -ne "\nEnter your choice: "
    read choice

    case "$choice" in
        1)
            echo -e "${CYAN}Installing Teryx Panel...${NC}"
            bash -c "$(curl -sSL https://raw.githubusercontent.com/startzpranjal/TERYX-PANEL-COMMAND/refs/heads/main/teryxpanel.sh)"
            echo -e "${GREEN}Press enter to return to menu...${NC}"
            read
            ;;
        2)
            echo -e "${CYAN}Installing Teryx Daemon/Node...${NC}"
            bash -c "$(curl -sSL https://raw.githubusercontent.com/startzpranjal/TERYX-PANEL-COMMAND/refs/heads/main/teryxdaemon.sh)"
            echo -e "${GREEN}Press enter to return to menu...${NC}"
            read
            ;;
        0)
            echo -e "${RED}Exiting...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option!${NC}"
            sleep 1
            ;;
    esac
done
