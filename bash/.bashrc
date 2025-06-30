# if not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/yasu/theme.sh

export EDITOR='nvim'

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ff="fastfetch --logo small \
	--structure 'title:os:packages:shell:de:wm:theme:icons:terminal' \
	--os-format '{name}' \
	--packages-format '{2}' \
	--shell-format '{3}' \
	--wm-format '{2}' \
	--terminal-format '{2}' \
	--color-keys '$cprimary' \
	--color-title '$cprimary' \
	--logo-color-1 '$cprimary' \
	--logo-color-2 '$cprimary' \
	--logo-color-3 '$cprimary' \
	--logo-color-4 '$cprimary' \
	--logo-color-5 '$cprimary' \
	--logo-color-6 '$cprimary' \
	"
alias nv='nvim'
alias y='yazi'

alias backup='~/.config/yasu/backup.sh'
alias pwall='DIR="/mnt/d/yashu/discord pics/1 piktures/wallpapers";
  find "$DIR" -type f -print0 |
  xargs -0 -I{} printf "%s\t%s\n" "{}" "$(basename "{}")" |
  fzf --delimiter="\t" --with-nth=2 \
      --preview="feh --bg-scale {1}" \
      --bind="enter:execute(feh --bg-scale {1})+abort"'
alias vwall="sxiv -f -q -r -s f /mnt/d/yashu/discord\ pics/1\ piktures/wallpapers/*"

alias kys='sudo systemctl poweroff'
alias kysr='sudo reboot'
alias hibernate='sudo systemctl hibernate'

# functions
pj() {
	case "$1" in
		d) cd /mnt/d ;;
		nvim) cd ~/.config/nvim ;;
		obs) cd /mnt/d/yashu/apps/obsidian/obsidian-vault/ ;;
		awm) cd ~/.config/awesome ;;
		awmt) cd ~/.config/awesome/theme ;;
	esac
}

nve() {
	case "$1" in
		bash) nvim ~/.bashrc ;;
		theme) nvim ~/.config/yasu/theme.sh ;;
		backup) nvim ~/.config/yasu/backup.sh ;;
		awm) nvim ~/.config/awesome/rc.lua ;;
		awmt) nvim ~/.config/awesome/theme/theme.lua ;;
		kitty) nvim ~/.config/kitty/kitty.conf ;;
		yazi) nvim ~/.config/yazi/yazi.toml ;;
		picom) nvim ~/.config/picom/picom.conf ;;
		kanata) nvim ~/.config/kanata/config.kbd ;;
		ff) nvim ~/.config/fastfetch/config.jsonc ;;
	esac
}

hex_to_rgb() {
    hex="${1#"#"}"
    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))
    echo "$r;$g;$b"
}
rgb=$(hex_to_rgb "$cprimary")

# prompt
# PS1='\[\e[0m\]\w\[\e[38;2;'"$rgb"'m\]> \[\e[0m\]'
PROMPT_COMMAND='
  if [[ "$PWD" == "$HOME" ]]; then
    PS1="\[\e[38;2;'$rgb'm\]~> \[\e[0m\]"
  else
    PS1="\[\e[97m\]\w\[\e[38;2;'$rgb'm\]> \[\e[0m\]"
  fi
'
