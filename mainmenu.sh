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
    # Use read -r to handle input correctly
    read -r choice

    # Remove any accidental leading/trailing whitespace
    choice=$(echo "$choice" | xargs)

    case "$choice" in
        1)
            echo -e "${CYAN}Installing Teryx Panel...${NC}"
            bash -c "$(curl -sSL https://githubusercontent.com)"
            echo -e "${GREEN}Press enter to return to menu...${NC}"
            read -r
            ;;
        2)
            echo -e "${CYAN}Installing Teryx Daemon/Node...${NC}"
            bash -c "$(curl -sSL https://githubusercontent.com)"
            echo -e "${GREEN}Press enter to return to menu...${NC}"
            read -r
            ;;
        0)
            echo -e "${RED}Exiting...${NC}"
            exit 0
            ;;
        "") 
            # If the user just presses Enter, redraw the menu without error
            continue 
            ;;
        *)
            echo -e "${RED}Invalid option!${NC}"
            sleep 2
            ;;
    esac
done
# NO PIPE HERE
