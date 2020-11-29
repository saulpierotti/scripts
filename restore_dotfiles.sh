#!/bin/bash
# Substitute all the dotfiles in the system to the ones saved in .dotifiles
# This is useful for recreating my system configuration

if [ "$(whoami)" = "root" ]; then
    USER_HOME="$(eval echo "~${SUDO_USER}")"
else
    USER_HOME="$HOME"
fi

dotfiles_root="$USER_HOME/.dotfiles/root"

# include hidden files in globbing
shopt -s dotglob

explore() {
    for element in "$1"/*; do
        if [[ "$element" == "$dotfiles_root"/*.old ]]; then
            echo "Skipping: $element"
        elif [ -f "$element" ]; then
            process "$element"
        elif [ -d "$element" ]; then
            explore "$element"
        fi
    done
}

process() {
    FILE_IN_REPO="$1"
    # remove the prefix $dotfiles_root
    FILE_IN_SYSTEM="${1/#$dotfiles_root/}"
    echo "Linking $FILE_IN_REPO to $FILE_IN_SYSTEM"
    ln -sf "$FILE_IN_REPO" "$FILE_IN_SYSTEM"
}

explore "$dotfiles_root"
shopt -u dotglob
