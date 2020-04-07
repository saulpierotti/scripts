#!/bin/bash
#keeps the screen from locking until next reebot

i=0
while true; do
	let "i++"
	xscreensaver-command -deactivate
	printf "Awake signal sent "$i" times"
	sleep 600
done
