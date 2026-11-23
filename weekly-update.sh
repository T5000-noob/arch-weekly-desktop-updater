#!/bin/bash

DESKTOP_DIR=$(xdg-user-dir DESKTOP)
DESKTOP_ICON="$DESKTOP_DIR/Arch-Weekly-Update.desktop"
ENABLE_AUR_UPDATE=false

OFFICIAL=$(checkupdates 2>/dev/null | wc -l)

if [ "$ENABLE_AUR_UPDATE" = true ]; then
    if command -v paru >/dev/null; then
        AUR=$(paru -Qua 2>/dev/null | wc -l)
    elif command -v yay >/dev/null; then
        AUR=$(yay -Qua 2>/dev/null | wc -l)
    else
        AUR=0
    fi
else
    AUR=0
fi

UPDATES=$((OFFICIAL + AUR))

cat <<EOF > "$DESKTOP_ICON"
[Desktop Entry]
Version=1.0
Type=Application
Name=System Update ($UPDATES)
Comment=Click to run weekly system update
Exec=$HOME/.local/bin/run-weekly-update.sh
Icon=system-software-update
Terminal=false
Categories=System;
EOF

chmod +x "$DESKTOP_ICON"

notify-send "Weekly System Update Ready ($UPDATES)" \
    "Click the desktop icon to update official packages." -i system-software-update
