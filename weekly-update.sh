#!/bin/bash

DESKTOP_DIR=$(xdg-user-dir DESKTOP)
DESKTOP_ICON="$DESKTOP_DIR/Arch-Weekly-Update.desktop"

OFFICIAL=$(checkupdates 2>/dev/null | wc -l)
if command -v paru >/dev/null; then
    AUR=$(paru -Qua 2>/dev/null | wc -l)
elif command -v yay >/dev/null; then
    AUR=$(yay -Qua 2>/dev/null | wc -l)
else
    AUR=0
fi
UPDATES=$((OFFICIAL + AUR))

if find /usr/share/icons -name "cachy-update_updates-available-blue-cb*" 2>/dev/null | grep -q .; then
    ICON_NAME="cachy-update_updates-available-blue-cb"
else
    ICON_NAME="system-software-update"
fi

cat << DESKTOP_EOF > "$DESKTOP_ICON"
[Desktop Entry]
Version=1.0
Type=Application
Name=System Update ($UPDATES)
Comment=Click to run weekly system update
Exec=$HOME/.local/bin/run-weekly-update.sh
Icon=$ICON_NAME
Terminal=false
Categories=System;
DESKTOP_EOF

chmod +x "$DESKTOP_ICON"

notify-send "Weekly System Update ($UPDATES)" "A desktop shortcut has been created." -i "$ICON_NAME"
