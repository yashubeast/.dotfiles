#!/bin/bash
set -e

sudo pacman -S --needed - < repo.pkgs

# check for yay, prompt install if missing
if ! command -v yay &>/dev/null; then
    read -p "yay not found, install yay from AUR now? [y/N] " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
        git clone https://aur.archlinux.org/yay.git /tmp/yay
        (cd /tmp/yay && makepkg -si)
    else
        echo "AUR install skipped, yay is required"
        exit 1
    fi
fi

yay -S --needed - < aur.pkgs
