#!/bin/bash

WDIR="$(dirname "$(realpath "$0")")"
# source "$WDIR/active.sh"
THEMES=($(find "$WDIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort))

SELECTED=$(printf "%s\n" "${THEMES[@]}" | rofi -dmenu -p "select theme")

# exit if nothing selected
[ -z "$SELECTED" ] && exit

# set active.sh
sed -i "2s|.*|source \"$WDIR/$SELECTED/theme.sh\"|" "$WDIR/active.sh"
bash "$WDIR/active.sh" >/dev/null 2>&1
notify-send "$SELECTED theme applied"
