#!/bin/bash
# synchronise all my important git repositories

commit_message=routine_tasks.sh
git_repos="
    $HOME/notebook
    $HOME/.dotfiles
    $HOME/.scripts
    $HOME/.bioscripts
    "

echo "Routine task executor script"

for folder in $git_repos; do
    echo "syncing $folder..."
    cd "$folder" || return
    git add -A
    git commit -m "$commit_message"
    # in this order so to leave origin as the push default
    git push backup-gitlab master
    git push backup-bitbucket master
    git push origin master
done

# end confirmation
echo "End of the scheduler reached"
