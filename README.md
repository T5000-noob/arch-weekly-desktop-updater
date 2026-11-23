# 🚀 Arch Weekly Desktop Updater

A lightweight, zero-background-overhead weekly update reminder and desktop launcher for **CachyOS, Arch Linux, and Arch-based distributions**.

## ✨ Key Features
- **Zero Background Overhead:** Wakes up once a week on your chosen day.
- **Dynamic Desktop Shortcut:** ~~Displays combined updates.~~ Now defaults to **Official (`pacman`) packages only** (`ENABLE_AUR_UPDATE=false`) for stability, with optional AUR support (`ENABLE_AUR_UPDATE=true`) available.
- **Smart Shortcut Management:** Automatically manages shortcut icons based on update status.
- **Automated Monthly Cache Cleanup:** Regularly cleans package caches.

## 📦 Installation
    git clone https://github.com/T5000-noob/arch-weekly-desktop-updater.git
    cd arch-weekly-desktop-updater
    chmod +x install.sh uninstall.sh
    ./install.sh

## 🗑️ Uninstallation
    ./uninstall.sh
    
