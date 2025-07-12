#!/bin/bash

WDIR="$(dirname "$(realpath "$0")")"
source "$WDIR/active.sh"
THEMES=($(find "$WDIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort))
THEMES+=("change wallpaper")

SELECTED=$(printf "%s\n" "${THEMES[@]}" | rofi -dmenu -p "select theme")

# exit if nothing selected
[ -z "$SELECTED" ] && exit

if [ "$SELECTED" = "change wallpaper" ]; then
	files=($(find "$wallDir" -maxdepth 1 -type f -printf '%f\n' | sort))

	wallpaper=$(printf "%s\n" "${files[@]}" | rofi -dmenu -p "select wallpaper" \
		-on-selection-changed "feh --bg-fill '$wallDir{entry}'")

	if [ -z "$wallpaper" ]; then
		feh --bg-fill "$wallDir$wallFile"
		exit 0
	fi

	sed -i "3s|.*|export wallFile=\"$wallpaper\"|" "$WDIR/active.sh"
	feh --bg-fill "$wallDir$wallpaper"
	notify-send "wallpaper changed $wallpaper"
else
	# set active.sh
	sed -i "2s|.*|source \"$WDIR/$SELECTED/theme.sh\"|" "$WDIR/active.sh"
	bash "$WDIR/active.sh"
	notify-send "$SELECTED theme applied"
fi

# restart awesomeWM
# awesome-client 'awesome.restart()'
