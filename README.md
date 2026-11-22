# 🚀 Arch Weekly Desktop Updater

A lightweight, zero-background-overhead weekly update reminder and desktop launcher for **CachyOS, Arch Linux, and Arch-based distributions**.

## ✨ Key Features
- **Zero Background Overhead:** Wakes up once a week on your chosen day (or on your next boot if your PC was off).
- **Dynamic Desktop Shortcut:** Displays the combined count of Official (`pacman`) + AUR (`paru`/`yay`) updates.
- **Smart Shortcut Management:** Removes the icon when `0` updates remain, or updates the remaining count if closed mid-way.
- **Automated Monthly Cache Cleanup:** Runs `paccache -rk2`, `paccache -ruk0`, and AUR cache cleanup once per month.

## 📦 Installation
    git clone https://github.com
    cd arch-weekly-desktop-updater
    chmod +x install.sh uninstall.sh
    ./install.sh

## 🗑️ Uninstallation
    ./uninstall.sh
