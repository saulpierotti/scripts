#!/bin/bash
# replace a symlink with the real file (and remove the original position of tht
# file)

for link in "$@"; do
    if [ ! -h "$link" ]; then
        echo "$link is not a symlink. Aborting..."
        exit 0
    fi
    
    file="$(readlink "$link")"
    
    rm "$link"
    mv "$file" "$link"
done
