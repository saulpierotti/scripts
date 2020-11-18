#!/bin/bash
# Takes in a argument a file
# Moves it to the folder ~/.dotfiles/path/to/file replicating the original path of the file
# Creates all the needed folder along the way
# Puts an absolute symlink to the moved file in the original location
# DO NOT USE PATHS WITH WHITESPACES

if [ "$(whoami)" = "root" ]; then
    USER_HOME="$(eval echo ~${SUDO_USER})"
else
    USER_HOME="$HOME"
fi

dotfiles_repo_folder="$USER_HOME/.dotfiles"

if [ ! -d "$dotfiles_repo_folder" ]; then
    echo "$dotfiles_repo_folder does not exist! Aborting..."
    exit 0
fi

if [ -h "$1" ]; then
    echo "$1 is a symlink! Aborting..."
    exit 0
fi

original_file_fullpath="$(realpath $1)" # get the full path

if `echo "$original_file_fullpath"|grep -q ' '`; then
    echo "$original_file_fullpath contains whitespaces! Aborting..."
    exit 0
fi

if `echo "$dotfiles_repo_folder"|grep -q ' '`; then
    echo "$dotfiles_repo_folder contains whitespaces! Aborting..."
    exit 0
fi

if [ ! -f "$original_file_fullpath" ]; then
    echo "$original_file_fullpath not found! Aborting..."
    exit 0
fi

if [ ! -w "$original_file_fullpath" ]; then
    echo "Insufficient permissions! Run as sudo. Aborting..."
    exit 0
fi

echo "Processing the file:"
echo "$original_file_fullpath"

new_file_location="$dotfiles_repo_folder$original_file_fullpath"
echo "Final path where to place it:"
echo "$new_file_location"

# create missing folders in destination
path_to_file="${original_file_fullpath%/*}"
folders_in_path="$(echo $path_to_file|tr '/' ' ')"
array=($folders_in_path)
folder_to_test=$dotfiles_repo_folder
for element in "${array[@]}"
do
    folder_to_test=$folder_to_test/$element
    if [ ! -d "$folder_to_test" ]; then
        echo Creating missing folder $folder_to_test
        mkdir $folder_to_test
    else
        echo "The folder $folder_to_test exist already"
    fi
done

destination_path="$dotfiles_repo_folder$path_to_file"
if [ ! -d $destination_path ]; then
    echo "Error: cannot find $destination_path! Aborting..."
    exit 0
fi

echo "Moving $original_file_fullpath to $new_file_location"
mv $original_file_fullpath $new_file_location

if [ ! -f $new_file_location ]; then
    echo "Error: cannot find $new_file_location! Aborting..."
    exit 0
fi

echo "Symlinking $new_file_location to $original_file_fullpath"
ln -s $new_file_location $original_file_fullpath
