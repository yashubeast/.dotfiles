#!/bin/bash

WDIR="$(dirname "$(realpath "$0")")"
source "$WDIR/active.sh"

files=($(find "$wallDir" -maxdepth 1 -type f -printf '%f\n' | sort))

wallpaper=$(
	printf "%s\n" "${files[@]}" | \
	rofi -dmenu -p "" \
	-theme-str '
		window {
			background-color: #00000000;
			border: 0;
		}
	' \
	-on-selection-changed "feh --bg-fill '$wallDir{entry}'")

if [ -z "$wallpaper" ]; then
	feh --bg-fill "$wallDir$wallFile"
	exit 0
fi

sed -i "3s|.*|export wallFile=\"$wallpaper\"|" "$WDIR/active.sh"
feh --bg-fill "$wallDir$wallpaper"
wal -i "$wallDir$wallpaper"
notify-send "walled: $wallpaper"
