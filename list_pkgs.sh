#!/bin/bash

if [ "$(whoami)" = "root" ]; then
    USER_HOME="$(eval echo ~"${SUDO_USER}")"
else
    USER_HOME="$HOME"
fi

MY_PATH="$USER_HOME/installed_packages"
DOT_REPO="$USER_HOME/.dotfiles"
OFF="$MY_PATH/pkglist_official.txt"
AUR="$MY_PATH/pkglist_arch_user_repository.txt"
FLATPAK="$MY_PATH/pkglist_flatpak.txt"
SNAP="$MY_PATH/pkglist_snap.txt"

echo "Saving list of installed packages..."
pacman -Qqen >"$OFF"
pacman -Qqem >"$AUR"
flatpak list >"$FLATPAK"
snap list >"$SNAP"

echo "Syncing to GitHub..."
cd "$DOT_REPO" || return
git add -A
git commit -m "list_pkgs.sh automated commit"
git push backup-gitlab master
git push backup-bitbucket master
git push origin master
