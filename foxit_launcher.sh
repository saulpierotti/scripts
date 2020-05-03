#!/bin/sh
# Just opens the argument with foxitreader
# Needed because foxit scrambles the input when called from zathura

file=$1
/usr/bin/foxitreader "$file" &> /dev/null
