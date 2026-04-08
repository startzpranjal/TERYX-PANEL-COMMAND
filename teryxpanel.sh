#!/bin/bash

# Gradient (light blue → light green)
C1='\033[38;5;117m'
C2='\033[38;5;123m'
C3='\033[38;5;159m'
C4='\033[38;5;151m'
C5='\033[38;5;120m'
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

echo "[*] Fixing packages..."
apt clean
dpkg --configure -a
apt install -f -y

echo "[*] Installing dependencies..."
apt update
apt install -y curl git zip unzip

# Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt install -y nodejs

npm install -g pm2

# Install panel
rm -rf v4panel
git clone https://github.com/teryxlabs/v4panel
cd v4panel || exit

unzip -o panel.zip
npm install

# Seed database
npm run seed

# 🔥 FORCE CREATE USER (DIRECT DB METHOD)
echo "[*] Creating admin user (forced)..."

node <<EOF
const bcrypt = require('bcryptjs');
const fs = require('fs');

(async () => {
  const password = await bcrypt.hash("admin", 10);

  // adjust if DB path differs
  const dbFile = './database.sqlite';

  if (!fs.existsSync(dbFile)) {
    console.log("Database not found!");
    process.exit(1);
  }

  const sqlite3 = require('sqlite3').verbose();
  const db = new sqlite3.Database(dbFile);

  db.run(
    \`INSERT INTO users (username, email, password, isAdmin)
     VALUES ('admin','admin@startz.com','\${password}',1)\`,
    (err) => {
      if (err) {
        console.log("User may already exist:", err.message);
      } else {
        console.log("Admin user created!");
      }
      db.close();
    }
  );
})();
EOF

# Start panel
echo "[*] Starting panel..."
pm2 start npm --name teryx-panel -- run start
pm2 save

echo
echo -e "${C5}[✔] PANEL RUNNING${NC}"
echo -e "${C3}Login: admin@startz.com / admin${NC}"
echo -e "${C3}Logs: pm2 logs teryx-panel${NC}"
echo
