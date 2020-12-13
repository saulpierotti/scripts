#!/bin/bash
# This script creates an image preview of the file given as argument (usually a
# pdf) and it adds it to the file README.md
# Images are stored in the folder preview
# I use this to create previews for my reports in github repos
#
# If convert complains about missing permissions you need to edit
# /etc/ImageMagick-7/policy.xml and remove the uncommented line in the policy
# section. See the archwiki of ImageMagick for reference.

if [ -f "$1" ]; then
    if [ ! -d preview ]; then
        mkdir preview
    fi
    convert -density 150 "$1[0-9]" -quality 100 "preview/$(basename "$1" ".pdf").png"
    echo preview/$(basename "$1").png
    for file in $(ls -v preview); do
        convert -flatten "preview/$file" "preview/$file"
        echo "![preview](preview/$file)" >>README.md
    done

else
    echo "Input file $1 not found"
fi
