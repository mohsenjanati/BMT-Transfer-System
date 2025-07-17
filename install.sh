#!/bin/bash

INSTALL_DIR="/opt/bmt-transfer-system"

echo "📦 در حال نصب BMT در $INSTALL_DIR ..."
mkdir -p "$INSTALL_DIR"

echo "📥 دریافت فایل بایگانی bmt.zip ..."
curl -L -o /tmp/bmt.zip "https://github.com/mohsenjanati/BMT-Transfer-System/raw/main/bmt.zip"

echo "🧯 استخراج فایل‌ها..."
unzip -o /tmp/bmt.zip -d "$INSTALL_DIR"

echo "🔐 دادن دسترسی اجرایی..."
chmod +x $INSTALL_DIR/*.sh

echo "🔗 ساخت دستور global به نام bmt ..."
ln -sf "$INSTALL_DIR/banking_transfer_money.sh" /usr/local/bin/bmt

echo "🧹 پاکسازی فایل zip موقت"
rm -f /tmp/bmt.zip

echo "✅ نصب با موفقیت انجام شد!"
echo "▶ اکنون با تایپ دستور زیر اجرا کن:  bmt"
