#!/bin/bash

# ---------------------------------------
# BMT Transfer System - Secure Installer
# Version: 2025-07-17_01-22-17
# Author: @bmt112233
# ---------------------------------------

clear
echo -e "\e[36m🔐 Enter BMT Installation Password:\e[0m"
read -s -p "Password: " password_input
echo ""

# Validate password (base64 encoded)
expected_hash="NjEwZTg5Y2M1M2NiMjlhZTcyMTAyYjA2OTExMDYyY2E="  # base64 of 'bmt1022711'
if [[ "$(echo -n "$password_input" | base64)" != "$expected_hash" ]]; then
  echo -e "\e[91m❌ Invalid password. Access denied.\e[0m"
  exit 1
fi

clear
echo -e "\e[33m🚀 Starting Installation of BMT Transfer System...\e[0m"

# Install dependencies
echo -e "\e[36m📦 Installing dependencies (curl, bash, net-tools)...\e[0m"
sudo apt update -y && sudo apt install -y curl bash net-tools &> /dev/null

# Create working directory
mkdir -p /opt/bmt-transfer-system
cd /opt/bmt-transfer-system || exit

# Download all core components
echo -e "\e[36m📥 Downloading BMT components...\e[0m"

urls=(
  "install.sh"
  "bmt_menu.sh"
  "soap_transfer.sh"
  "rest_transfer.sh"
  "swift_transfer.sh"
  "iso20022_transfer.sh"
  "blockchain_transfer.sh"
  "openbanking_transfer.sh"
)

for file in "${urls[@]}"; do
  curl -sSLO "https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main/$file"
done

chmod +x *.sh

# Add alias
if ! grep -q "bmt_menu.sh" ~/.bashrc; then
  echo "alias bmt='bash /opt/bmt-transfer-system/bmt_menu.sh'" >> ~/.bashrc
fi

source ~/.bashrc

# Save install log
{
  echo "BMT Installed on $(date)"
  echo "User: $USER"
  echo "Hostname: $(hostname)"
} > /opt/bmt-transfer-system/install.log

echo ""
echo -e "✅ \e[32mInstallation Complete!\e[0m"
echo -e "📂 Files installed in: /opt/bmt-transfer-system/"
echo -e "📋 Log: /opt/bmt-transfer-system/install.log"
echo -e "🚀 Run \e[33mbmt\e[0m to start the system now!"
