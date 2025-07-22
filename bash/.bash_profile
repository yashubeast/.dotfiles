# ~/.bash_profile

export PATH="$HOME/.config/yasu:$PATH"
export EDITOR="nvim"
export WALLDIR="/mnt/d/shit/pix/walls/"
export LAUNCHER="$HOME/.local/share/applications:/usr/share/applications:$HOME/.config/yasu/.desktop"
export FILER="$HOME/.dotfiles:$HOME/d/docs:$(xdg-user-dir DOWNLOAD)"
export VE="$HOME/.dotfiles"

[[ -f ~/.bashrc ]] && . ~/.bashrc
