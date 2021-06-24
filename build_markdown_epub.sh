#!/bin/bash
#
# Author: Saul Pierotti
# Last edit: June 24, 2021
# GitHub: github.com/saulpierotti
#
# Takes in input a markdown file and converts it to epub, embedding equations
# as images.
# Requires pandoc and gladtex.

original_dir=$(pwd)
md_file="$1"
basename=$(basename "$md_file" .md)
basedir=$(dirname "$md_file")
tmp_folder="/tmp/epub_compiler_gladtex"
htex_file="$tmp_folder/$basename.htex"
html_file="$tmp_folder/$basename.html"
epub_file="$basedir/$basename.epub"

if [ -d "$tmp_folder" ]; then
    rm -rf "$tmp_folder"
fi
mkdir "$tmp_folder"
pandoc -t html -o "$htex_file" "$md_file" --gladtex
gladtex -r 300 -v "$htex_file" -d "$tmp_folder"
pandoc -o "$epub_file" "$html_file" --resource-path="$tmp_folder"
