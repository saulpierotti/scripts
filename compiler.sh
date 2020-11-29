#!/bin/bash
# This script will compile or run another finishing operation on a document. I
# have this script run via vim.

# set variables for the operation
file="$1"
base="${file%.*}"
filename="${base##*/}"

if [ "${file: -3}" == ".md" ]; then
    echo "Compiling md file to pdf..."
    command="pandoc $file
    --citeproc
    -V colorlinks
    -V geometry:a4paper
    -V geometry:margin=1in
    -o $base.pdf"
elif [ "${file: -4}" == ".tex" ]; then
    if [ -d "metafiles" ]; then
        command="pdflatex -output-directory=metafiles $file;mv
        metafiles/$filename.pdf $base.pdf; mv metafiles/$filename.bcf
        $base.bcf"
    elif [ ! -d "metafiles" ]; then
        echo "Compiling tex file to pdf..."
        command="pdflatex -interaction=nonstopmode -synctex=1 $file"
    fi
elif [ "${file: -2}" == ".R" ]; then
    echo "Executing R script..."
    command="Rscript $file"
elif [ "${file: -3}" == ".py" ]; then
    echo "Executing python script..."
    command="python $file"
else
    echo "Filetype not recognized: I do not know what to do"
fi

$command
