#!/usr/bin/env bash

# Configure bash
set -e # Exit on error
# set -x # Enable for debugging


shopt -s dotglob nullglob

echo "Aligning element-main local branch with open-super-dapp-android project structure..."

SCRIPT=./open-super-dapp/scripts/align-element.sh
if [ -f "$SCRIPT" ]; 
then
    echo Detected $SCRIPT script. 
else 
    echo "$SCRIPT does not exist. Are you in the project root directory? Aborting."
    exit 1
fi

echo This script will align files and folders from element-android on the element-main branch to facilitate merging.
echo Please ensure you have committed or stashed your commits before continuing.
read -p "Continue? (y/N) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo Beginning alignment...
else
  echo Exiting...
  exit 2  
fi

# Stash changes just in case the user did not
echo Stashing any changes if user did not...
git add --all 
git stash

# Save current branch
START_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo Saved starting branch $START_BRANCH.

git checkout element-main

echo Stashing not ignored open-super-dapp files...
git add --all
git stash 

/bin/rm -rf .github .travis.yml fastlane Gemfile* towmcrier.toml
git mv vector app
git mv docs element
mkdir docs
git mv element docs/
git mv CONTRIBUTING.md AUTHORS.md CHANGES.md changelog.d LICENSE README.md docs/element/
mkdir -p scripts/element
git mv *.sh scripts/element/

git commit -am "Temporary commit to align files and folders facilitate merging"

echo Leaving git on initial branch $START_BRANCH...
git checkout $START_BRANCH

echo Done! element-android files and folders are now aligned and ready to be merged in.
