#!/usr/bin/env bash

# this is for the UI theme
for dir in $HOME/.var/app/*/
do
    confdir="${dir}config/gtk-3.0"
    mkdir -p $confdir
    cp $HOME/.config/gtk-3.0/settings.ini $confdir/settings.ini
done

# this is for the cursor theme
# if not working copy /usr/share/icons to ~/.icons and run again
flatpak_apps=$(flatpak list|cut -f 2)
for app in $flatpak_apps; do
    flatpak --user override $app --filesystem=/home/$USER/.icons/:ro
done
