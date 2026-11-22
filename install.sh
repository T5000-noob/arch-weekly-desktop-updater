#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=========================================="
echo "  Arch Weekly Desktop Updater Installer"
echo "=========================================="

echo "[1/4] Installing required dependencies..."
sudo pacman -S --needed --noconfirm pacman-contrib libnotify xdg-user-dirs

echo ""
echo "[2/4] Select the day of the week for your update reminder:"
echo "  1) Monday    (월요일)"
echo "  2) Tuesday   (화요일)"
echo "  3) Wednesday (수요일 - Recommended)"
echo "  4) Thursday  (목요일)"
echo "  5) Friday    (금요일)"
echo "  6) Saturday  (토요일)"
echo "  7) Sunday    (일요일)"
read -p "Enter number [1-7, default: 3]: " DAY_CHOICE

case "$DAY_CHOICE" in
    1) DAY="Mon" ;;
    2) DAY="Tue" ;;
    4) DAY="Thu" ;;
    5) DAY="Fri" ;;
    6) DAY="Sat" ;;
    7) DAY="Sun" ;;
    *) DAY="Wed" ;;
esac

echo "[3/4] Installing scripts to ~/.local/bin..."
mkdir -p ~/.local/bin ~/.config/systemd/user
cp "$SCRIPT_DIR/weekly-update.sh" "$SCRIPT_DIR/run-weekly-update.sh" ~/.local/bin/
chmod +x ~/.local/bin/weekly-update.sh ~/.local/bin/run-weekly-update.sh

echo "[4/4] Setting up systemd user timer ($DAY)..."
cat << SERVICE_EOF > ~/.config/systemd/user/weekly-update.service
[Unit]
Description=Weekly System Update Desktop Notification

[Service]
Type=oneshot
ExecStart=%h/.local/bin/weekly-update.sh
SERVICE_EOF

cat << TIMER_EOF > ~/.config/systemd/user/weekly-update.timer
[Unit]
Description=Run Weekly System Update on first boot every $DAY

[Timer]
OnCalendar=$DAY *-*-* 00:00:00
Persistent=true

[Install]
WantedBy=timers.target
TIMER_EOF

systemctl --user daemon-reload
systemctl --user enable --now weekly-update.timer

echo ""
echo "✅ Installation complete! Scheduled for every $DAY (Persistent=true)."
echo "💡 Run ~/.local/bin/weekly-update.sh to test it right now."
