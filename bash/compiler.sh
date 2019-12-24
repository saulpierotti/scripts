#!/bin/sh
# This script will compile or run another finishing operation on a document. I
# have this script run via vim.

# set variables for the operation
file="$1"
base="${file%.*}"
filename="${base##*/}"

reset
if [ ${file: -3} == ".md" ]
then
	echo "Compiling md file to pdf..."
	pandoc --filter pandoc-citeproc -V geometry:margin=1in  $file -o $base.pdf
elif [ ${file: -4} == ".tex" ]
then
	if [ -d "metafiles" ]
	then
		pdflatex -output-directory=metafiles $file
		mv metafiles/$filename.pdf $base.pdf
		mv metafiles/$filename.bcf $base.bcf

	elif [ ! -d "metafiles" ]
	then
		echo "Compiling tex file to pdf..."
		pdflatex $file
	fi
elif [ ${file: -2} == ".R" ]
then
	echo "Executing R script..."
	Rscript $file
elif [ ${file: -3} == ".py" ]
then
	echo "Executing python script..."
	python $file
else
	echo "Filetype not recognized: I do not know what to do"
fi
