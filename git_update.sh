#!/bin/bash
# Add all the files, commit and push to upstreams

git add -A
git commit -m "$1"
git push
