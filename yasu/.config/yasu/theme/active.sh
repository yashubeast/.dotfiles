source "/home/yasu/.dotfiles/yasu/.config/yasu/theme/default/theme.sh"
source "/home/yasu/.dotfiles/yasu/.config/yasu/theme/default/theme.sh"
export wallFile="joyboy.png"

################################################################################
# kitty config generation, only active when kittyGeneration=1
################################################################################

if [ "${kittyGeneration}" = "1" ]; then
    template="$HOME/.config/kitty/kitty.template.conf"
    out="$HOME/.dotfiles/kitty/.config/kitty/kitty.conf"

    # Substitute placeholders.
    sed -e "s|{{kittyFont}}|$kittyFont|g" \
        -e "s|{{kittyFontSize}}|$kittyFontSize|g" \
        -e "s|{{background}}|$background|g" \
        -e "s|{{kittyTransparency}}|$kittyTransparency|g" \
        "$template" > "$out"
fi

##############################################################################
# end of kitty config generation
##############################################################################
