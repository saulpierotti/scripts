#!/bin/bash
link="$1"

if [ ! -h "$link" ]; then
    echo $link is not a symlink. Aborting...
    exit 0
fi

file="$(readlink "$link")"

rm "$link"
mv "$file" "$link"
