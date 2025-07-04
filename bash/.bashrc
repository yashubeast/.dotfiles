# if not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/yasu/theme.sh

export EDITOR='nvim'

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias nv='nvim'
alias y='yazi'
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
alias backup='~/.config/yasu/backup.sh'
alias pwall='DIR="/mnt/d/yashu/discord pics/1 piktures/wallpapers";
  find "$DIR" -type f -print0 |
  xargs -0 -I{} printf "%s\t%s\n" "{}" "$(basename "{}")" |
  fzf --delimiter="\t" --with-nth=2 \
      --preview="feh --bg-scale {1}" \
      --bind="enter:execute(feh --bg-scale {1})+abort"'
alias vwall="sxiv -f -q -r -s f /mnt/d/yashu/discord\ pics/1\ piktures/wallpapers/*"

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
		tmux) nvim ~/.tmux.conf ;;
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
