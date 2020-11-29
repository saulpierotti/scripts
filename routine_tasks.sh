#!/bin/bash
# synchronise all my important git repositories

commit_message=routine_tasks.sh
git_repos="
    $HOME/notebook
    $HOME/.dotfiles
    $HOME/.bioscripts
    $HOME/.scripts
    "

echo "Routine task executor script"

for folder in $git_repos; do
    echo "syncing $folder..."
    cd "$folder" || return
    git_update.sh "$commit_message"
done

# end confirmation
echo "End of the scheduler reached"
