# reinitialize everithing
xrandr --output eDP-1 --primary --auto --scale 1x1
xrandr --output HDMI-1 --auto --rotate normal --left-of eDP-1

if [ $1 == "p" ]
then
	#set screen extended portrait
	xrandr --output HDMI-1 --rotate right
elif [ $1 == "m" ]
then
	res1=`xrandr|awk '/*/ {print $1}'|head -n1`
	res2=`xrandr|awk '/*/ {print $1}'|sed -n 2p`
	#set screen mirror
	xrandr --output HDMI-1 --auto
	xrandr --output eDP-1 --same-as HDMI-1 --auto --scale-from $res2
fi

redraw_screen.sh
