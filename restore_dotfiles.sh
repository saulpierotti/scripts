#!/bin/bash
# Substitute all the dotfiles in the system to the ones saved in .dotifiles
# This is useful for recreating my system configuration

dotfiles_root="$HOME/.dotfiles"
# include hidden files in globbing
shopt -s dotglob

explore() {
    for element in "$1"/*; do
        if [ -f "$element" ]; then
            echo "$element"
        elif [ -d "$element" ]; then
            explore "$element"
        fi
    done
}

explore "$dotfiles_root"
