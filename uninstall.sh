#!/bin/bash

echo "Uninstalling Arch Weekly Desktop Updater..."

systemctl --user disable --now weekly-update.timer 2>/dev/null
rm -f ~/.config/systemd/user/weekly-update.service
rm -f ~/.config/systemd/user/weekly-update.timer
systemctl --user daemon-reload

rm -f ~/.local/bin/weekly-update.sh
rm -f ~/.local/bin/run-weekly-update.sh
rm -f ~/.local/state/last-paccache-month

DESKTOP_DIR=$(xdg-user-dir DESKTOP)
rm -f "$DESKTOP_DIR/Arch-Weekly-Update.desktop"

echo "✅ Uninstallation complete! All files and timers have been removed."
