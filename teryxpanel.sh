#!/user/bin/bash
figlet STARTZ && figlet TERYX PANEL && git clone https://github.com/teryxlabs/v4panel && curl -sL https://deb.nodesource.com/setup_23.x | sudo bash - && apt-get install nodejs git && cd v4panel && apt install zip -y && unzip panel.zip && npm install && npm run seed && npm run createUser && node .
