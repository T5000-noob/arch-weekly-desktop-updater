#!/bin/bash

DESKTOP_DIR=$(xdg-user-dir DESKTOP)
DESKTOP_ICON="$DESKTOP_DIR/Arch-Weekly-Update.desktop"
ENABLE_AUR_UPDATE=false

if command -v paru >/dev/null; then
    AUR_UPDATE_CMD="paru -Sua"
    AUR_CLEAN_CMD="paru -Sc --noconfirm"
elif command -v yay >/dev/null; then
    AUR_UPDATE_CMD="yay -Sua"
    AUR_CLEAN_CMD="yay -Sc --noconfirm"
else
    AUR_UPDATE_CMD="true"
    AUR_CLEAN_CMD="true"
fi

if [ "$ENABLE_AUR_UPDATE" = true ]; then
    UPDATE_PIPELINE="sudo pacman -Syu && $AUR_UPDATE_CMD"
else
    UPDATE_PIPELINE="sudo pacman -Syu"
fi

INNER_CMD='
    echo "=== Starting Weekly System Update ==="
    if '"$UPDATE_PIPELINE"'; then
        STAMP_FILE="$HOME/.local/state/last-paccache-month"
        THIS_MONTH=$(date +%Y-%m)
        if [ "$(cat "$STAMP_FILE" 2>/dev/null)" != "$THIS_MONTH" ]; then
            echo ""
            echo "=== Running Monthly Package Cache Cleanup ==="
            sudo paccache -rk2
            sudo paccache -ruk0
            '"$AUR_CLEAN_CMD"'
            mkdir -p "$HOME/.local/state"
            echo "$THIS_MONTH" > "$STAMP_FILE"
        fi
        echo ""
        echo "All tasks completed! Press Enter to close this window."
    else
        echo ""
        echo "Update was interrupted or failed. Press Enter to close this window."
    fi
    read
'

if command -v konsole >/dev/null; then
    konsole --title "Weekly System Update" -e bash -c "$INNER_CMD"
elif command -v kitty >/dev/null; then
    kitty --title "Weekly System Update" bash -c "$INNER_CMD"
elif command -v alacritty >/dev/null; then
    alacritty --title "Weekly System Update" -e bash -c "$INNER_CMD"
elif command -v gnome-terminal >/dev/null; then
    gnome-terminal --title="Weekly System Update" -- bash -c "$INNER_CMD"
elif command -v xfce4-terminal >/dev/null; then
    xfce4-terminal --title="Weekly System Update" -x bash -c "$INNER_CMD"
else
    x-terminal-emulator -e bash -c "$INNER_CMD"
fi

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
REMAINING=$((OFFICIAL + AUR))

if [ "$REMAINING" -eq 0 ]; then
    rm -f "$DESKTOP_ICON"
else
    if [ -f "$DESKTOP_ICON" ]; then
        sed -i "s/^Name=.*/Name=System Update ($REMAINING)/" "$DESKTOP_ICON"
    fi
fi
