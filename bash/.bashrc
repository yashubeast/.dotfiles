# if not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR="nvim"
# export wallDir="/mnt/d/yashu/shit/pix/walls/"
# export XDG_DATA_DIRS="$HOME/.local/share/applications:/usr/share/applications:$HOME/.config/rofi/apps"
# export wallpaperDir="/mnt/d/yashu/discord pics/1 piktures/wallpapers/"

source ~/.config/yasu/theme/active.sh

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nv='nvim'
alias e='yazi'
alias ff="fastfetch --logo small \
	--structure 'title:os:packages:shell:de:wm:theme:icons:terminal' \
	--os-format '{name}' \
	--packages-format '{2}' \
	--shell-format '{3}' \
	--wm-format '{2}' \
	--terminal-format '{2}' \
	--color-keys '$primary' \
	--color-title '$primary' \
	--logo-color-1 '$primary' \
	--logo-color-2 '$primary' \
	--logo-color-3 '$primary' \
	--logo-color-4 '$primary' \
	--logo-color-5 '$primary' \
	--logo-color-6 '$primary' \
	"

# setup stuff
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias mprev='mpv --loop $(find . -type f -iregex ".*\.\(png\|jpe?g\|gif\|webp\|mp4\|mkv\|webm\|mov\)$" | sort)'
alias backup='~/.dotfiles/backup.sh'

# git stuff
alias gs='git status'
alias gst='git stage'
alias ga='git add'
alias gr='git remote'
alias gc='git commit -m'
alias gca='git commit -am'
alias gp='git push'

# tmux stuff
alias tls='tmux ls'
alias tau='tmux attach -t uni'

# docker stuff
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dcr='docker container rm'
# volume
alias dv='docker volume'
alias dvs='docker volume ls'
alias dvr='docker volume rm'
alias dvp='docker volume prune'
# image
alias di='docker image'
alias dis='docker images'
alias dir='docker image rm'
alias dip='docker image prune'
# network
alias dn='docker network'
alias dns='docker network ls'
alias dnr='docker network rm'
alias dnp='docker network prune'
# compose
alias du='docker compose up -d'
alias dd='docker compose down'

# boot stuff
alias kys='sudo systemctl poweroff'
alias kysr='sudo reboot'
alias hibernate='sudo systemctl hibernate'

# sudo shit
alias pacman='sudo pacman'
alias sysctl='sudo systemctl'

# functions
pj() {
	case "$1" in
		# configs
		nvim) cd ~/.config/nvim ;;
		kitty) cd ~/.config/kitty ;;
		awm) cd ~/.config/awesome ;;
		yasu) cd ~/.config/yasu ;;
		theme) cd ~/.config/yasu/theme ;;
		rofi) cd ~/.config/rofi ;;
		vencord) cd ~/.config/Vencord;;
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
		mpv) nvim ~/.config/mpv/input.conf;;

		# yasu/theme
		themer) nvim ~/.config/yasu/theme/run.sh ;;
		themew) nvim ~/.config/yasu/theme/waller.sh ;;
		themea) nvim ~/.config/yasu/theme/active.sh ;;
		themed) nvim ~/.config/yasu/theme/default/theme.sh ;;

		# custom stuff
		backup) nvim ~/.dotfiles/backup.sh ;;
		launcher) nvim ~/.config/rofi/scripts/launcher.sh;;

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
rgb=$(hex_to_rgb "$primary")

# prompt
# PS1='\[\e[0m\]\w\[\e[38;2;'"$rgb"'m\]> \[\e[0m\]'
PROMPT_COMMAND='
  if [[ "$PWD" == "$HOME" ]]; then
    PS1="\[\e[38;2;'$rgb'm\]~> \[\e[0m\]"
  else
    PS1="\[\e[97m\]\w\[\e[38;2;'$rgb'm\]> \[\e[0m\]"
  fi
'
