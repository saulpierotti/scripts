#!/bin/bash
# Adds mirror remotes to the current git repository, based on its GitHub origin:
#   backup-gitlab  git@gitlab.com:saulpierotti/<repo>.git
#   zellerlab      git@github.com:zellerlab/<repo>.git (unless that is origin)
#   all            push URLs for origin and the mirrors above
# Safe to re-run: existing remotes are kept and missing URLs are added to all.

set -euo pipefail

die() {
    echo "$*. Aborting." >&2
    exit 1
}

add_remote() {
    local name=$1 url=$2 existing
    if existing=$(git remote get-url "$name" 2>/dev/null); then
        if [ "$existing" = "$url" ]; then
            echo "Remote $name already present. Skipping."
        else
            echo "Warning: remote $name points to $existing, not $url. Leaving it unchanged." >&2
        fi
    else
        git remote add "$name" "$url"
        echo "Added remote $name: $url"
    fi
}

add_to_all() {
    local url=$1 urls
    urls=$(git config --get-all remote.all.url || true)
    if grep -Fxq -- "$url" <<<"$urls"; then
        echo "Remote all already has $url. Skipping."
    else
        git config --add remote.all.url "$url"
        echo "Added to remote all: $url"
    fi
}

git rev-parse --git-dir >/dev/null 2>&1 || die "Not in a git repository"
origin=$(git remote get-url origin 2>/dev/null) || die "No origin remote"

github_url='^(git@github\.com:|ssh://git@github\.com/|https://github\.com/)([^/]+)/([^/]+)$'
stripped=${origin%/}
stripped=${stripped%.git}
[[ $stripped =~ $github_url ]] || die "Origin is not a GitHub repository: $origin"
owner=${BASH_REMATCH[2]}
repo=${BASH_REMATCH[3]}

case "$owner" in
saulpierotti | zellerlab) ;;
*) die "Unexpected origin owner: $owner" ;;
esac

add_remote backup-gitlab "git@gitlab.com:saulpierotti/$repo.git"
if [ "$owner" != "zellerlab" ]; then
    add_remote zellerlab "git@github.com:zellerlab/$repo.git"
fi

for name in origin backup-gitlab zellerlab; do
    if url=$(git remote get-url "$name" 2>/dev/null); then
        add_to_all "$url"
    fi
done
