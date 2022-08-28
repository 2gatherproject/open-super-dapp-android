#!/usr/bin/env bash

# Configure bash
set -e # Exit on error
# set -x # Enable for debugging


shopt -s dotglob nullglob

echo "Aligning alpha-wallet-main local branch with open-super-dapp-android project structure..."

SCRIPT=./open-super-dapp/scripts/align-alpha-wallet.sh
if [ -f "$SCRIPT" ]; 
then
    echo Detected $SCRIPT script. 
else 
    echo "$SCRIPT does not exist. Are you in the project root directory? Aborting."
    exit 1
fi

echo This script will align files and folders from alpha-wallet-android on the alpha-wallet-main branch to facilitate merging.
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

git checkout alpha-wallet-main

echo Stashing not ignored open-super-dapp files...
git add --all
git stash

/bin/rm -rf .editorconfig Gemfile* .gitpod* fastlane .travis.yml .bundle dmz util contracts gradle* build.gradle package* settings.gradle
git mv lib alpha-token-script
git mv docs alpha-wallet
mkdir docs
git mv alpha-wallet docs/
git mv scripts alpha-wallet
mkdir scripts
git mv alpha-wallet scripts/
git mv *.sh scripts/alpha-wallet/
git mv .all-contributorsrc LICENSE README.md docs/alpha-wallet/

git commit -am "Temporary commit to align files and folders facilitate merging"

echo Leaving git on initial branch $START_BRANCH...
git checkout $START_BRANCH

echo Done! alpha-wallet-android files and folders are now aligned and ready to be merged in.
