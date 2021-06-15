#!/bin/bash
# This script adds remotes to a git repository on Gitlab and Bitbucket with the
# same name as origin (which is assumed to be GitHub)

target=".git/config"
if [ -f "$target" ]; then
    origin=$(sed -n "/\[remote \"origin\"]/,/\[*\]/p" $target | head -n -1)
    if ! grep -q "\[remote \"backup-bitbucket\"\]" "$target"; then
        bitbucket=$(echo "${origin//git@github.com/git@bitbucket.org}" |
            sed "s/\[remote \"origin\"\]/\[remote \"backup-bitbucket\"\]/")
        echo "$bitbucket" >>"$target"
    else
        echo "Remote backup-bitbucket already present. Skipping."
    fi
    if ! grep -q "\[remote \"backup-gitlab\"\]" "$target"; then
        gitlab=$(echo "${origin//git@github.com/git@gitlab.com}" |
            sed "s/\[remote \"origin\"\]/\[remote \"backup-gitlab\"\]/")
        echo "$gitlab" >>"$target"
    else
        echo "Remote backup-gitlab already present. Skipping."
    fi
    if ! grep -q "\[remote \"all\"\]" "$target"; then
        all_url=$(grep "url = git@" "$target")
        echo "[remote \"all\"]" >>"$target"
        echo "$all_url" >>$target
    else
        echo "Remote all already present. Skipping."
    fi
    exit 0
else
    echo "Not in a git repository. Aborting."
    exit 1
fi
