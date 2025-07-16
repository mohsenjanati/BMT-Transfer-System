#!/bin/bash

# ---------------------------------------
# BMT Transfer System - Auto Installer
# Author: @bmt112233
# License: All rights reserved
# ---------------------------------------

clear

# Ask for password
echo -e "\e[36m🔐 Enter Installation Password:\e[0m"
read -s -p "Password: " password_input
echo ""

# Check password match (stored in a safe hashed form or env outside GitHub in future)
if [[ "$password_input" != "$(echo Ym10MTAyMjcxMQ== | base64 -d)" ]]; then
  echo -e "\e[91m❌ Invalid password. Access denied.\e[0m"
  exit 1
fi

clear
echo -e "\e[33m⛔ DO NOT SHARE OR COPY THIS SCRIPT.\e[0m"
echo -e "\e[31m⚠️ هرگونه کپی‌برداری و استفاده غیرمجاز ممنوع است.\e[0m"
echo ""
sleep 3

# Create directories
mkdir -p /opt/bmt-transfer-system
cd /opt/bmt-transfer-system || exit

# Download components
echo -e "\e[36m📥 Downloading core components...\e[0m"

curl -sSLO https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main/install.sh
curl -sSLO https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main/bmt_menu.sh
curl -sSLO https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main/soap_transfer.sh
curl -sSLO https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main/rest_transfer.sh
curl -sSLO https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main/swift_transfer.sh
curl -sSLO https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main/iso20022_transfer.sh
curl -sSLO https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main/blockchain_transfer.sh
curl -sSLO https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main/openbanking_transfer.sh

# Make executable
chmod +x *.sh

# Add alias to bash
if ! grep -q "bmt_menu.sh" ~/.bashrc; then
  echo "alias bmt='bash /opt/bmt-transfer-system/bmt_menu.sh'" >> ~/.bashrc
fi

# Reload bash config
source ~/.bashrc

# Final message
echo -e "\n✅ \e[32mInstallation Complete!\e[0m"
echo -e "📌 Run \e[33mbmt\e[0m anytime to launch the system."
echo -e "📂 Installed in: /opt/bmt-transfer-system/"
echo -e "📋 Log saved in: /opt/bmt-transfer-system/install.log"
echo ""

# Save installation log
{
  echo "BMT Transfer System Installed on $(date)"
  echo "User: $USER"
  echo "Machine: $(hostname)"
} > install.log
