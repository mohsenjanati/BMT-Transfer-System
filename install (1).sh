
#!/bin/bash

# ------------------------------
# BMT Transfer System Installer
# Author: @bmt112233
# ------------------------------

clear
echo -e "\e[36m🔐 Enter Installation Password:\e[0m"
read -s -p "Password: " password_input
echo ""

# Expected password
expected_password="bmt1022711"

if [[ "$password_input" != "$expected_password" ]]; then
  echo -e "\n\e[91m❌ Invalid password. Access denied.\e[0m"
  exit 1
fi

clear
echo -e "\e[33m⛔ DO NOT SHARE OR COPY THIS SCRIPT.\e[0m"
echo -e "\e[31m⚠️ هرگونه کپی‌برداری و استفاده غیرمجاز ممنوع است.\e[0m"
sleep 2
echo ""

# ------------------------------
# Create installation directory
# ------------------------------
INSTALL_DIR="/opt/bmt-transfer-system"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR" || exit 1

echo -e "\e[36m📥 Downloading core components...\e[0m"

# GitHub raw base path
GITHUB_RAW="https://raw.githubusercontent.com/mohsenjanati/BMT-Transfer-System/main"

FILES=(
  install.sh
  bmt_menu.sh
  soap_transfer.sh
  rest_transfer.sh
  swift_transfer.sh
  iso20022_transfer.sh
  blockchain_transfer.sh
  openbanking_transfer.sh
)

for file in "${FILES[@]}"; do
  echo "⬇️  Downloading $file..."
  curl -fsSLO "$GITHUB_RAW/$file"
done

# Set permissions
chmod +x *.sh

# Add alias
if ! grep -q "bmt_menu.sh" ~/.bashrc; then
  echo "alias bmt='bash $INSTALL_DIR/bmt_menu.sh'" >> ~/.bashrc
fi

# Reload bash config
source ~/.bashrc

# Log installation
{
  echo "BMT Transfer System Installed on $(date)"
  echo "User: $USER"
  echo "Machine: $(hostname)"
} > "$INSTALL_DIR/install.log"

# Final message
echo -e "\n✅ \e[32mInstallation Complete!\e[0m"
echo -e "📂 Installed at: $INSTALL_DIR"
echo -e "📌 Use \e[33mbmt\e[0m to launch the system."
echo -e "📝 Log saved in: $INSTALL_DIR/install.log"
