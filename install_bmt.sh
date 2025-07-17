#!/bin/bash
clear
echo -e "\e[92m"
echo "🟩🟥 BMT Transfer System Installer 🟥🟩"
echo "Developer: Mohsenjanati"
echo "Telegram: @blackshoters"
echo "GitHub: github.com/Mohsenjanati"
echo "Repo: BMT-Transfer-System"
echo ""
echo "⚠️  Unauthorized financial use is prohibited."
echo "🔐 Legal Notice: This system is digitally signed."
echo ""
read -p "Enter installation password: " password
if [[ "$password" != "0698798" ]]; then
  echo "❌ Incorrect password!"
  exit 1
fi
echo "✅ Password accepted. Proceeding with installation..."

# Set firewall and DNS
ufw allow 21
ufw allow 443
ufw allow 80
ufw allow 8080
ufw --force enable
echo "nameserver 1.1.1.1" > /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# Install dependencies from local directory
dpkg -i ./dependencies/*.deb 2>/dev/null

# Make scripts executable
chmod +x ./scripts/*.sh

# Move main launcher
cp ./scripts/banking_transfer_money.sh /usr/local/bin/bmt
chmod +x /usr/local/bin/bmt

echo "✅ Installation complete. Run 'bmt' to launch."
