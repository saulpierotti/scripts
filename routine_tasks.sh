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

# stores a list of pkgs in my conda envs
echo "exporting conda envs..."
echo
NOW=$(date "+%Y-%m-%d")
mkdir $HOME/.pkg_history/conda/envs-$NOW
ENVS=$(conda env list | grep '^\w' | cut -d' ' -f1)
for env in $ENVS; do
    conda env export -n $env > $HOME/.pkg_history/conda/envs-$NOW/$env.yml
    echo "Exporting $env"
done
find $HOME/.pkg_history/conda/ -type d -mtime +30 -name 'envs-*' -exec rm -fr {} \;
echo

# update the remote github repo for the notebook, bioscripts and scripts
echo "syncing notebook..."
echo
cd /home/saul/notebook
git_update.sh
echo
echo
echo "syncing bioscripts..."
echo
cd /home/saul/bioscripts
/home/saul/.scripts/git_update.sh
echo
echo
echo "syncing .scripts..."
echo
cd /home/saul/.scripts
/home/saul/.scripts/git_update.sh
echo
echo
echo "syncing dotfiles..."
echo
cd /home/saul/.dotfiles
/home/saul/.scripts/git_update.sh
echo
echo

# end confirmation
echo "end of the scheduler reached"
