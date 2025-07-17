#!/bin/bash

# رنگ‌ها
GREEN="\e[32m"
RED="\e[31m"
NC="\e[0m"

echo -e "${GREEN}🔐 BMT - Bank Money Transfer System Installer${NC}"
echo

# نصب ابزارهای مورد نیاز
echo -e "${GREEN}📦 Installing required packages...${NC}"
apt-get update -y
apt-get install -y curl unzip git whiptail

# ساخت دایرکتوری مقصد
INSTALL_DIR="/opt/bmt-transfer-system"
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# دریافت فایل ZIP پروژه
echo -e "${GREEN}⬇️ Downloading bmt.zip...${NC}"
curl -L -o bmt.zip https://github.com/mohsenjanati/BMT-Transfer-System/raw/main/bmt.zip

# بررسی موفقیت دانلود
if [ ! -f "bmt.zip" ]; then
  echo -e "${RED}❌ Failed to download bmt.zip. Aborting.${NC}"
  exit 1
fi

# اکسترکت فایل ZIP
unzip -o bmt.zip
chmod +x *.sh

# شورت‌کات در سیستم ایجاد کن
ln -sf $INSTALL_DIR/banking_transfer_money.sh /usr/local/bin/bmt

echo
echo -e "${GREEN}✅ Installation complete. Type 'bmt' to start the system.${NC}"
