#!/bin/bash

WDIR="$(dirname "$(realpath "$0")")"
THEMES=($(find "$WDIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort))

SELECTED=$(printf "%s\n" "${THEMES[@]}" | rofi -dmenu -p "select theme")

# exit if nothing selected
[ -z "$SELECTED" ] && exit

IMAGE="$WDIR/$SELECTED/wallpaper.jpg"

# if [ ! -f "$IMAGE" ]; then
#     notify-send "error" "no wallpaper found in $SELECTED"
#     exit 1
# fi

# set active.sh
sed -i "2s|.*|source \"$WDIR/$SELECTED/theme.sh\"|" "$WDIR/active.sh"

# notify
notify-send "changing theme..." "applying $SELECTED"

# set wallpaper using feh
# feh --bg-fill "$IMAGE"

# restart awesomeWM
# awesome-client 'awesome.restart()'

notify-send "theme applied" "$SELECTED applied successfully"
