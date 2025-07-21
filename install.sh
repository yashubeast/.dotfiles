#!/bin/bash
set -e

read -p "install PACMAN packages ? [y/N] " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
	sudo pacman -S --needed - < repo.pkgs
else
	echo "PACMAN install skipped by user"
fi

read -p "install AUR packages ? [y/N] " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
	if ! command -v yay &>/dev/null; then
		read -p "yay not found, install yay from AUR now? [y/N] " ans
		if [[ "$ans" =~ ^[Yy]$ ]]; then
			git clone https://aur.archlinux.org/yay.git /tmp/yay
			(cd /tmp/yay && makepkg -si)
			yay -S --needed - < aur.pkgs
		else
			echo "AUR install skipped, yay is required"
		fi
	else
		yay -S --needed - < aur.pkgs
	fi
fi

read -p "auto-mounts via fstab ? [y/N] " mount_ans
if [[ "$mount_ans" =~ ^[Yy]$ ]]; then
	lsblk -f
	echo "enter the UUID (or device path) of the drive to auto-mount:"
	read -p "UUID: " uuid
	read -p "mount point (e.g. /mnt/data): " mount_point
	sudo mkdir -p "$mount_point"
	read -p "filesystem type (e.g ntfs-3g, ext4): " fs_type
	echo "UUID=$uuid $mount_point $fs_type defaults,noatime,uid=1000,gid=1000,umask=022 0 0" | sudo tee -a /etc/fstab
	echo "drive added to /etc/fstab"
fi
