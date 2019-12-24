nitrogen --head=0 --set-scaled --random
nitrogen --head=1 --set-scaled --random
killall polybar
exec .config/polybar/launch.sh
