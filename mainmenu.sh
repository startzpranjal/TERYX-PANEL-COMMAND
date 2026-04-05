#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

while true; do
    clear

    # Title with figlet
    echo -e "${CYAN}"
    figlet -f slant "STARTZ MAIN MENU"
    echo -e "${NC}"

    echo -e "${YELLOW}=================================${NC}"
    echo -e "${GREEN}1.${NC} Install Teryx Panel"
    echo -e "${GREEN}2.${NC} Install Teryx Daemon/Node"
    echo -e "${RED}0.${NC} Exit"
    echo -e "${YELLOW}=================================${NC}"

    read -p "Enter your choice: " choice

    case $choice in
        1)
            echo -e "${CYAN}Installing Teryx Panel...${NC}"
            curl -sSL https://raw.githubusercontent.com/startzpranjal/TERYX-PANEL-COMMAND/refs/heads/main/teryxpanel.sh | bash
            read -p "Press Enter to return to menu..."
            ;;
        2)
            echo -e "${CYAN}Installing Teryx Daemon/Node...${NC}"
            curl -sSL https://raw.githubusercontent.com/startzpranjal/TERYX-PANEL-COMMAND/refs/heads/main/teryxdaemon.sh | bash
            read -p "Press Enter to return to menu..."
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

