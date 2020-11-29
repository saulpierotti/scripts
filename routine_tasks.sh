#!/bin/bash

echo "Routine task executor script"
echo
date
echo
echo

# update the remote github repo for the notebook, bioscripts and scripts
echo "syncing notebook..."
echo
cd "/home/saul/notebook" || return
git_update.sh
echo
echo
echo "syncing .bioscripts..."
echo
cd "/home/saul/.bioscripts" || return

git_update.sh
echo
echo
echo "syncing .scripts..."
echo
cd "/home/saul/.scripts" || return
/home/saul/.scripts/git_update.sh
echo
echo
echo "syncing .dotfiles..."
echo
cd "/home/saul/.dotfiles" || return
git_update.sh
echo
echo

# end confirmation
echo "end of the scheduler reached"
