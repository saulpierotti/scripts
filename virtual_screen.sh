#!/bin/bash
# This script toggles the presence of a virtual screen on xrandr
# I use it for windows that I want the X server to render but not to show
# For example, zoom shares or obs studio recordings

RESOLUTION="1024x768"
CONKY_CONF="$HOME/.config/conky/conky.conf"
xrandr --addmode VIRTUAL1 $RESOLUTION

case $1 in
"on")
    echo "Activating virtual screen"
    xrandr --output VIRTUAL1 --mode $RESOLUTION --left-of eDP1
    sed -i 's/    xinerama_head = .,/    xinerama_head = 2,/' "$CONKY_CONF"
    ;;
"off")
    echo "Deactivating virtual screen"
    xrandr --output VIRTUAL1 --off
    sed -i 's/    xinerama_head = .,/    xinerama_head = 0,/' "$CONKY_CONF"
    ;;
*)
    echo "Option not recognized. This script takes 'on' or 'off' as an argument"
    ;;
esac

i3-msg restart
echo "Current configuration:"
xrandr --query
