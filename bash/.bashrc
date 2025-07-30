# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias c='clear'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias v='nvim'
alias xclip='xclip -selection clipboard'
alias blue='bluetoothctl'
alias yxev="xev | grep --line-buffered \"keysym\" | awk '{print substr(\$7, 1, length(\$7)-2)}'"
alias ff='fastfetch'
alias mkcd='f() { mkdir -p "$1" && cd "$1"; }; f'

# setup stuff
alias vencord='sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"'
alias backup='~/.dotfiles/backup.sh'
alias historyls="history | awk '{\$1=\"\"; print \$0}' | awk '{print \$1}' | sort | uniq -c | sort -nr | head -10"

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
alias tk='tmux kill-session -t'
alias ta='tmux attach'
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
alias sc='sudo systemctl'
alias scu='systemctl --user'

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
		obs) cd $HOME/d/apps/obsidian/obsidian-vault/ ;;
	esac
}

nve() {
	case "$1" in
		# configs
		bash) nvim ~/.bashrc ;;
		bashp) nvim ~/.bash_profile ;;
		awm) nvim ~/.config/awesome/rc.lua ;;
		awmt) nvim ~/.config/awesome/core/theme.lua ;;
		kitty) nvim ~/.config/kitty/kitty.conf ;;
		kittyt) nvim ~/.config/kitty/kitty.template.conf ;;
		tmux) nvim ~/.config/tmux/tmux.conf ;;
		yazi) nvim ~/.config/yazi/yazi.toml ;;
		picom) nvim ~/.config/picom/picom.conf ;;
		kanata) nvim ~/.config/kanata/config.kbd ;;
		rofi) nvim ~/.config/rofi/config.rasi ;;
		mpv) nvim ~/.config/mpv/input.conf;;
		sxhkd) nvim ~/.config/sxhkd/sxhkdrc;;

		# yasu/theme
		themer) nvim ~/.config/yasu/theme/themer.sh ;;
		waller) nvim ~/.config/yasu/waller ;;
		themea) nvim ~/.config/yasu/theme/active.sh ;;
		themed) nvim ~/.config/yasu/theme/default/theme.sh ;;

		# custom stuff
		backup) nvim ~/.dotfiles/backup.sh ;;
		launcher) nvim ~/.config/yasu/launcher ;;
		filer) nvim ~/.config/yasu/filer ;;

		# misc
		ff) nvim ~/.config/fastfetch/config.jsonc ;;
		lsd) nvim ~/.config/lsd/config.yaml ;;
		discord) sudo nvim /opt/discord/resources/build_info.json ;;
		vencordm) nvim ~/.config/Vencord/themes/test.css ;;
		vencordt) nvim ~/.config/Vencord/themes/transparent.css ;;
	esac
}

# PS1='\[\e[0m\]\w\[\e[38;2;'"$rgb"'m\]> \[\e[0m\]'
get_rgb() {
    local hex=$(xrdb -query | awk '/\*color4:/ {print $2}')
    hex="${hex#"#"}"
    r=$((16#${hex:0:2}))
    g=$((16#${hex:2:2}))
    b=$((16#${hex:4:2}))
    echo "$r;$g;$b"
}
set_prompt() {
  if [[ -z "$DISPLAY" || $(tput colors) -lt 8 ]]; then
		PS1='\[\e[0m\]\w\[\e[38;2;'"$rgb"'m\]> \[\e[0m\]'
  else
    rgb=$(get_rgb)
    if [[ "$PWD" == "$HOME" ]]; then
      PS1="\[\e[38;2;${rgb}m\]❯ \[\e[0m\]"
    else
      PS1="\[\e[97m\]\w\[\e[38;2;${rgb}m\]❯ \[\e[0m\]"
    fi
  fi
}
PROMPT_COMMAND='set_prompt'

# zoxide
eval "$(zoxide init bash)"

# yazi auto-cd
function e() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

source ~/.cache/wal/colors-tty.sh
