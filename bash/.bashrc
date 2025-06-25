# if not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR='nvim'

# theme
# source ~/.config/yasu/theme.sh

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ff='fastfetch'
alias nv='nvim'

alias backup='~/.config/yasu/backup.sh'

alias kys='sudo systemctl poweroff'
alias kysr='sudo reboot'
alias hibernate='sudo systemctl hibernate'

# functions
pj() {
	case "$1" in
		d) cd /mnt/d ;;
		nvim) cd ~/.config/nvim ;;
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
		picom) nvim ~/.config/picom/picom.conf ;;
		kanata) nvim ~/.config/kanata/config.kbd ;;
	esac
}

# prompt
PS1='\[\e[0m\]\w\[\e[38;2;23;148;212m\]> \[\e[0m\]'
