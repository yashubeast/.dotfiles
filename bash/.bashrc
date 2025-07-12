# if not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/yasu/theme/active.sh

# export XDG_DATA_DIRS="$HOME/.local/share/applications:/usr/share/applications:$HOME/.config/rofi/apps"
export EDITOR="nvim"
# export wallpaperDir="/mnt/d/yashu/discord pics/1 piktures/wallpapers/"

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nv='nvim'
alias y='yazi'
alias ls='lsd'
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

# setup stuff
alias ytheme='~/.config/yasu/theme/run.sh'
alias backup='~/.config/yasu/backup.sh'
alias pwall='DIR=$wallpaperDir;
  find "$DIR" -type f -print0 |
  xargs -0 -I{} printf "%s\t%s\n" "{}" "$(basename "{}")" |
  fzf --delimiter="\t" --with-nth=2 \
      --preview="feh --bg-scale {1}" \
      --bind="enter:execute(feh --bg-scale {})+abort"'
alias vwall="sxiv -f -q -r -s f $wallpaperDir*"

# git stuff
alias gs='git status'
alias gst='git stage'
alias ga='git add'
alias gr='git remote'
alias gc='git commit -m'
alias gca='git commit -am'
alias gp='git push'

# tmux stuff
alias tl='tmux ls'
alias tau='tmux attach -t uni'

# docker stuff
alias dp='docker ps'
alias dpa='docker ps -a'
alias dcr='docker container rm'
# volume
alias dv='docker volume'
alias dvl='docker volume ls'
alias dvr='docker volume rm'
alias dvp='docker volume prune'
# image
alias di='docker image'
alias dis='docker images'
alias dir='docker image rm'
alias dip='docker image prune'
# network
alias dn='docker network'
alias dnl='docker network ls'
alias dnr='docker network rm'
alias dnp='docker network prune'
# compose
alias du='docker compose up -d'
alias dd='docker compose down'

# boot stuff
alias kys='sudo systemctl poweroff'
alias kysr='sudo reboot'
alias hibernate='sudo systemctl hibernate'

# functions
pj() {
	case "$1" in
		# configs
		nvim) cd ~/.config/nvim ;;
		kitty) cd ~/.config/kitty ;;
		awm) cd ~/.config/awesome ;;
		yasu) cd ~/.config/yasu ;;
		theme) cd ~/.config/yasu/theme ;;
		# misc
		d) cd /mnt/d ;;
		obs) cd /mnt/d/yashu/apps/obsidian/obsidian-vault/ ;;
	esac
}

nve() {
	case "$1" in
		# configs
		bash) nvim ~/.bashrc ;;
		awm) nvim ~/.config/awesome/rc.lua ;;
		awmt) nvim ~/.config/awesome/core/theme.lua ;;
		kitty) nvim ~/.config/kitty/kitty.conf ;;
		kittyt) nvim ~/.config/kitty/kitty.template.conf ;;
		tmux) nvim ~/.tmux.conf ;;
		yazi) nvim ~/.config/yazi/yazi.toml ;;
		picom) nvim ~/.config/picom/picom.conf ;;
		kanata) nvim ~/.config/kanata/config.kbd ;;
		rofi) nvim ~/.config/rofi/config.rasi ;;

		# custom stuff
		ytheme) nvim ~/.config/yasu/theme/run.sh ;;
		ythemea) nvim ~/.config/yasu/theme/active.sh ;;
		theme) nvim ~/.config/yasu/theme/default/theme.sh ;;
		backup) nvim ~/.config/yasu/backup.sh ;;

		# misc
		ff) nvim ~/.config/fastfetch/config.jsonc ;;
		lsd) nvim ~/.config/lsd/config.yaml ;;
		discord) sudo nvim /opt/discord/resources/build_info.json ;;
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
