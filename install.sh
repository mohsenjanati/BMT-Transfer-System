#!/bin/bash

echo "🔐 Enter installation password:"
read -s input_password

expected_password="bmt1022711"

if [[ "$input_password" != "$expected_password" ]]; then
  echo "❌ Incorrect password. Installation aborted."
  exit 1
fi

echo "✅ Password accepted. Starting installation..."

# Update system & install dependencies
sudo apt update && sudo apt install -y curl unzip git dialog net-tools lsb-release

# Create working directory
mkdir -p ~/bmt_system && cd ~/bmt_system

# Download latest project from GitHub
curl -LJO https://github.com/mohsenjanati/BMT-Transfer-System/archive/refs/heads/main.zip
unzip -o main.zip && mv BMT-Transfer-System-main bmt && cd bmt

# Make scripts executable
chmod +x *.sh

# Register the main command
sudo ln -sf "$PWD/bmt.sh" /usr/local/bin/bmt

echo "🎉 Installation complete! Type 'bmt' to start the banking transaction system."
