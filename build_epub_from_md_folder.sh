#!/bin/bash
#
# Author: Saul Pierotti
# Last edit: June 18, 2021
# GitHub: github.com/saulpierotti
#
# Takes in input a folder containing (possibly in subfolders) markdown files
# It compiles them to a single epub file.
# Pandoc headers are replaced by vanilla markdown titles, and if this is done
# all the section titles are changed to a sub-lebel title.
# It does not do this for the file given as second argument.

compile_dir="$1"
title_file="$2"
tmp_file="/tmp/pandoc_epub_source.md"
out_file="${compile_dir}.epub"

if [ ! -d "$compile_dir" ]; then
    echo "Give the folder to be compiled as argument."
    echo "Folder $compile_dir not found."
    exit 1
fi
if [ ! -f "$title_file" ]; then
    echo "No title file specified, aborting."
    exit 1
fi
if [ -f "$out_file" ]; then
    echo "Output file $out_file is already existing. Aborting."
    exit 1
fi

md_files=$(find "$(pwd)/$compile_dir" -name "*.md" | grep -v "$title_file")

echo "Using $title_file as title file"
echo "Found the following markdown files in folder $compile_dir:"
echo "$md_files"

cat "$title_file" >"$tmp_file"

for md_file in $md_files; do
    printf "\n" >>"$tmp_file"
    awk '{if ($0~/^#/){print "#"$0} else {print $0}}' "$md_file" |
        awk '
            BEGIN{is_first_time=1}
            {
                if ($0~/^%/) {
                    if (is_first_time){
                        gsub("%","#",$0);
                        is_first_time=0;
                        print $0
                    }
                }
                else {print $0}
            }' >>"$tmp_file"
done

echo "Saving output to $out_file"
pandoc -o "$out_file" "$tmp_file"
