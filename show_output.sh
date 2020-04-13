#!/bin/sh
# A general handler for opening a file's intended output.
# I find this useful especially running from vim.
file=$1
path="${file%\\*}"
base="${file%.*}"

if [ -f $base.pdf ]
then
	zathura $base.pdf &
fi
