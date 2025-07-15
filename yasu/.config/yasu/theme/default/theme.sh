export terminal="kitty"
export editor=$EDITOR
# export wallDir="/mnt/d/yashu/shit/pix/walls/"

export font="JetBrains Mono"
export fontNerd="JetBrainsMono Nerd Font"
export fontNerdPropo="JetBrainsMono Nerd Font Propo"
export fontSize=12
export transparent=true
export transparency=70

# colors
export white="#ffffff"
export black="#000000"
export gray="#808080"
export red="#ff0000"
export pink="#ffc0cb"
export yellow="#ffff00"
export cyan="#00ffff"
export azure="#f0ffff"
export lime="#00FF00"

# variable colors
export disabled="#707880"
export background="$black"
export alert="$red"
export primary="$pink"
export secondary="$azure"

# awesome window manager
export awmFont=$fontNerdPropo
export awmFontSize=12
# wibar
export wibarBorderWidth=1
export wibarBorderFocus=$primary
export wibarBorderNormal=$black

export wibarBackground=$primary
export wibarForeground=$black
export wibartransparency=00
export wibarGap=8 # gap from screen sides
export wibarGapBool=true # enable "floating" wibar
export wibarWidgetGap=12 # gap between widgets
export wibarWorkspaceGap=2 # gap between workspace buttons
export wibarHeight=28
export wibarCharging="$lime"

# nvim
export nvimFont=$fontNerd
export obsidian_path='/mnt/d/yashu/apps/obsidian/obsidian-vault/'

# kitty
export kittyGeneration=1 # boolean to generate kitty conf or not
export kittyTransparency=$(awk "BEGIN { print $transparency / 100 }")
export kittyFont=$fontNerd
export kittyFontSize=14

# rofi
export rofiGeneration=1 # boolean to generate rofi conf or not
export rofiBackground=$background$transparency
export rofiPrimary=$primary
export rofiSecondary=$secondary
export rofiDisabled=$disabled
