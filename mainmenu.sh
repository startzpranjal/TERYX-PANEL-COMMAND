#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

draw_menu() {
    echo -e "${CYAN}"
    figlet -f big "STARTZ MAIN MENU"
    echo -e "${NC}"

    echo -e "${YELLOW}=================================${NC}"
    echo -e "${GREEN}1.${NC} Install Teryx Panel"
    echo -e "${GREEN}2.${NC} Install Teryx Daemon/Node"
    echo -e "${RED}0.${NC} Exit"
    echo -e "${YELLOW}=================================${NC}"
}

clear
draw_menu

while true; do
    echo -ne "Enter your choice: "
    read choice

    case "$choice" in
        1)
            echo -e "${CYAN}Installing Teryx Panel...${NC}"
            bash -c "$(curl -sSL https://raw.githubusercontent.com/startzpranjal/TERYX-PANEL-COMMAND/refs/heads/main/teryxpanel.sh)"
            echo
            draw_menu
            ;;
        2)
            echo -e "${CYAN}Installing Teryx Daemon/Node...${NC}"
            bash -c "$(curl -sSL https://raw.githubusercontent.com/startzpranjal/TERYX-PANEL-COMMAND/refs/heads/main/teryxdaemon.sh)"
            echo
            draw_menu
            ;;
        0)
            echo -e "${RED}Exiting...${NC}"
            exit 0
            ;;
        *)
            # do nothing, just re-prompt without redraw
            ;;
    esac
done
