#!/bin/bash
# This script uses rsync to synchronise my local Google drive folder with the
# nfs filesystem on codon, and with iCloud

# towards codon nfs
rsync \
    -avPLh \
    -e "ssh -J ebi-gate" \
    /Users/saul/Google\ Drive/My\ Drive/ \
    codon-login:/nfs/research/birney/users/saul/laptop_backup \
    --exclude ".*"

# towards the local iCloud folder
rsync \
    -avPLh \
    /Users/saul/Google\ Drive/My\ Drive/ \
    /Users/saul/Library/Mobile\ Documents/com\~apple\~CloudDocs \
    --exclude ".*"
