#!/bin/bash
# Takes in a argument a file
# Moves it to the folder ~/.dotfiles/path/to/file replicating the original path of the file
# Creates all the needed folder along the way
# Puts an absolute symlink to the moved file in the original location

if [ "$(whoami)" = "root" ]; then
    USER_HOME="$(eval echo ~${SUDO_USER})"
else
    USER_HOME="$HOME"
fi

dotfiles_repo_folder="$USER_HOME/.dotfiles"

if [ ! -d "$dotfiles_repo_folder" ]; then
    echo $dotfiles_repo_folder does not exist! Aborting...
    exit 0
fi

if [ -h "$1" ]; then
    echo $1 is a symlink! Aborting...
    exit 0
fi

original_file_fullpath=$(realpath "$1") # get the full path

mode=file
if [ ! -f "$original_file_fullpath" ]; then
    mode=directory
    original_file_fullpath=${original_file_fullpath%/} # strip the trailing / if present
    if [ ! -d "$original_file_fullpath" ]; then
        echo $original_file_fullpath not found! Aborting...
        exit 0
    fi
fi
echo The target provided is a $mode

if [ $mode == "directory" ]; then
    echo Since the target is a $mode, I am checking and consolidating any symlink inside it
    dir="$original_file_fullpath"
    for file in "$dir"/*; do
	echo $file
        if [ -h "$file" ]; then
	    echo Consolidating symlink $file
            symlink_consolidate.sh "$file"
        fi
    done
fi

if [ ! -w "$original_file_fullpath" ]; then
    echo Insufficient permissions! Run as sudo. Aborting...
    exit 0
fi

echo Processing the file:
echo $original_file_fullpath

new_file_fullpath="$dotfiles_repo_folder$original_file_fullpath"
new_file_dirname=$(dirname "$new_file_fullpath")

echo Final path where to place it:
echo $new_file_fullpath
echo Its base directory is:
echo $new_file_dirname

if [ ! -d "$new_file_dirname" ]; then
    echo $new_file_dirname does not exists. Creating directories...
    mkdir -p "$new_file_dirname"
else
    echo $new_file_dirname already exists. No need to create directories.
fi

if [ ! -d "$new_file_dirname" ]; then
    echo Error: cannot find $new_file_dirname but I think that I created it! Aborting...
    exit 0
fi

echo "Moving $original_file_fullpath to $new_file_dirname"
mv "$original_file_fullpath" "$new_file_dirname"

if [ ! -f "$new_file_fullpath" ] && [ ! -d "$new_file_fullpath" ]; then
    echo Error: cannot find the new $mode $new_file_fullpath! Aborting...
    exit 0
fi

echo Symlinking $new_file_fullpath to $original_file_fullpath
ln -s "$new_file_fullpath" "$original_file_fullpath"

