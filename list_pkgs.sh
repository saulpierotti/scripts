#!/bin/bash

if [ "$(whoami)" = "root" ]; then
    USER_HOME="$(eval echo ~"${SUDO_USER}")"
else
    USER_HOME="$HOME"
fi

MY_PATH=$USER_HOME/.pkg_history

OFF=$MY_PATH/pacman/pkglist_official.txt
AUR=$MY_PATH/aur/pkglist_arch_user_repository.txt

echo "Saving list of installed packages..."
pacman -Qqen >"$OFF"
pacman -Qqem >"$AUR"

echo "Syncing to GitHub..."
routine_tasks.sh
