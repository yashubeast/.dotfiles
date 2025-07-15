source "/home/yasu/.dotfiles/yasu/.config/yasu/theme/default/theme.sh"
source "/home/yasu/.dotfiles/yasu/.config/yasu/theme/pink/theme.sh"
export wallFile="a_black_and_white_drawing_of_a_person_holding_a_stick.jpg"

################################################################################
# kitty config generation, only active when kittyGeneration=1
################################################################################

if [ "${kittyGeneration}" = "1" ]; then
    template="$HOME/.config/kitty/kitty.template.conf"
    out="$HOME/.dotfiles/kitty/.config/kitty/kitty.conf"

    # substitute placeholders.
    sed -e "s|{{kittyFont}}|$kittyFont|g" \
        -e "s|{{kittyFontSize}}|$kittyFontSize|g" \
        -e "s|{{background}}|$background|g" \
        -e "s|{{kittyTransparency}}|$kittyTransparency|g" \
        "$template" > "$out"
fi

##############################################################################
# end of kitty config generation
##############################################################################

################################################################################
# rofi config generation, only active when rofiGeneration=1
################################################################################

if [ "${rofiGeneration}" = "1" ]; then
    template="$HOME/.config/rofi/theme.template.rasi"
    out="$HOME/.dotfiles/rofi/.config/rofi/theme.rasi"

    # substitute placeholders.
    sed -e "s|{{rofiBackground}}|$rofiBackground|g" \
        -e "s|{{rofiPrimary}}|$rofiPrimary|g" \
        -e "s|{{rofiSecondary}}|$rofiSecondary|g" \
        -e "s|{{rofiDisabled}}|$rofiDisabled|g" \
        "$template" > "$out"
fi

##############################################################################
# end of rofi config generation
##############################################################################
