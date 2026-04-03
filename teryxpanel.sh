#!/user/bin/bash
figlet STARTZ && figlet TERYX PANEL && git clone https://github.com/teryxlabs/v4panel && curl -sL https://deb.nodesource.com/setup_23.x | sudo bash - && apt-get install nodejs git && cd v4panel && apt install zip -y && unzip panel.zip && npm install && npm run seed && npm run createUser && node .
figlet STARTZ && figlet TERYX DAEMON && git clone https://github.com/dragonlabsdev/daemon && cd daemon && apt install zip -y && unzip daemon.zip && cd daemon && npm install && figlet CONFIGURE YOUR NODE CONFIGRATION AND PASTE IT IN TERMINAL AND TYPE 'node .' IN THE TERMINAL
