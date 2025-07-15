#!/usr/bin/env bash
#
# rofi‑launcher with:
#   – drun‑only list
#   – prefix commands:  y <q> → YouTube search | g <q> → Google search
#   – terminal wrapping when .desktop has Terminal=true

#################################### paths ####################################
desktop_dirs=(
	"$HOME/.local/share/applications"
	"/usr/share/applications"
	# "/var/lib/flatpak/exports/share/applications"
)

################################## app list ###################################
apps=$(
	for dir in "${desktop_dirs[@]}"; do
		grep -h '^Name=' "$dir"/*.desktop 2>/dev/null
	done | cut -d= -f2 | sort -u
)

################################ dmenu prompt #################################
choice=$(printf '%s\n' "$apps" | rofi -dmenu -i -p "")

[ -z "$choice" ] && exit 0

############################## desktop lookup #################################
desktop=$(
	for dir in "${desktop_dirs[@]}"; do
		grep -ril -- "^Name=$choice$" "$dir" 2>/dev/null
	done | head -n1
)

url_encode() {
    local out='' c hex
    for (( i=0; i<${#1}; i++ )); do
        c=${1:i:1}
        case "$c" in
            [a-zA-Z0-9.~_-]) out+="$c" ;;
            ' ')             out+='+'  ;;
            *)  printf -v hex '%02X' "'$c"
                out+="%$hex" ;;
        esac
    done
    printf '%s' "$out"
}
open_query_url() {
    prefix="$1"
    template="$2"
    query="${choice#$prefix }"
    encoded=$(url_encode "$query")
    xdg-open "$(printf "$template" "$encoded")" >/dev/null 2>&1 &
}

case "$desktop" in
  "") # non-app execution
		case "$choice" in

			# start of configuration

			y\ *) open_query_url "y" "https://youtube.com/results?search_query=%s";;
			g\ *) open_query_url "g" "https://www.google.com/search?q=%s";;
			az\ *) open_query_url "az" "https://www.amazon.com/s/?field-keywords=%s";;
			aur\ *) open_query_url "aur" "https://aur.archlinux.org/packages?K=%s";;
			*) echo -n "$choice" | xclip -selection clipboard && notify-send "$choice";;

			# end of configuration

		esac
		exit
		;;
	*) # .desktop found -> launch application
    terminal=$(grep -m1 '^Terminal=' "$desktop" | cut -d= -f2)
    cmd=$(grep -m1 '^Exec=' "$desktop" | cut -d= -f2 |
          sed 's/ *%[fFuUdDnNickvm]//g' | xargs)

    case "$terminal" in
      true)
        setsid kitty -e "$cmd" >/dev/null 2>&1 &
        ;;
      *)
        setsid "$cmd" >/dev/null 2>&1 &
        ;;
    esac
    ;;
esac
