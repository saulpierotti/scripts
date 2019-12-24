#!/bin/bash

# mountdev: easily mount mass storage devices.
# commands: '-m', '-u'

# Exclude the following /dev/sd* device(s):
# syntax example: "abc", to exclude drives a,b, and c.
# use "-" to show everything.
exclude="a"

# function to list attached mass storage devices, excluding some:
devices() {
	ls -1 /dev/sd[!$exclude]? 2>/dev/null
}
echo "Available devices:"
if devices 1; then
	devices | while read line; do
		dev=${line: -2}
		mount="udisksctl mount -b /dev/sd$dev"
		unmount="udisksctl unmount -b /dev/sd$dev"
		if [[ $1 = -m ]]; then
			$mount
		elif [[ $1 = -u ]]; then
			$unmount
		else
			echo "You have to specify -m to mount and -u to unmount all the remobvable devices, you have inserted \"$1\""
		break
		fi
	done
else
	echo "There are no removable devices"
fi
