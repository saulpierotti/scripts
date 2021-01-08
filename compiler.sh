#!/bin/bash
# This script will compile or execute its argument. I have this script run via
# a vim shortcut to quickly compile or execute my files.

file="$1"
base="${file%.*}"
mimetype=$(file --mime-type -b "$file")

case $mimetype in
"text/x-shellscript")
    echo "Recognized filetype: shell"
    command="bash $file"
    ;;
"text/x-script.python")
    echo "Recognized filetype: python"
    command="python $file"
    ;;
"text/x-tex")
    echo "Recognized filetype: tex"
    command="lualatex -interaction=nonstopmode -synctex=1 $file"
    ;;
"text/plain") # includes markdown and many others
    case $file in
    *.md)
        echo "Recognized filetype: markdown"
        command="pandoc $file
         --citeproc
         -V colorlinks
         -V geometry:a4paper
         -V geometry:margin=1in
         -o $base.pdf"

        ;;
    *)
        echo "Recognized filetype: plain text"
        ;;
    esac
    ;;
*)
    echo "Unmanaged file type: $mimetype"
    ;;
esac

# execute the command
$command
