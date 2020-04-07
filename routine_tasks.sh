#!/bin/bash

echo "Routine task executor script"
echo
date
echo
echo

# sync with rclone the currently_working directory to Gdrive
# command can be obtained by running the task in rclone-browser and going to the job page while it is running
echo "syncing currently_working to Gdrive with rclone"
echo
/usr/bin/rclone --config /home/saul/.config/rclone/rclone.conf sync --delete-during --verbose --transfers 4 --checkers 8 --contimeout 60s --timeout 300s --retries 3 --low-level-retries 10 -v --stats 1s --stats-file-name-length 0 /home/saul/currently_working gdrive_bioinfo_remote:/
echo
echo

# update the remote github repo for the notebook, bioscripts and scripts
echo "syncing markdown_notebook..."
echo
cd /home/saul/markdown_notebook
git_update.sh
echo
echo
echo "syncing bioscripts..."
echo
cd /home/saul/bioscripts
git_update.sh
echo
echo
echo "syncing .scripts..."
echo
cd /home/saul/.scripts
git_update.sh
echo
echo

# end confirmation
echo "end of the scheduler reached"
