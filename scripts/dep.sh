#!/usr/bin/env bash

# Clones a GitHub repo into deps/{name} if it's not there already.
# Will update the repository each time and ensure the right commit is checked out.
# Args: GitHub user, repository name, checkout target.
# Usage (after copying to your scripts directory): scripts/dep.sh Olical aniseed vX.Y.Z

mkdir -p deps

if [ ! -d "deps/$2" ]; then
    git clone "https://github.com/$1/$2.git" "deps/$2"
fi

cd "deps/$2" && git fetch && git checkout "$3"

