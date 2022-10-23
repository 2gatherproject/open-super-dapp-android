#!/usr/bin/env bash
# Script to prepare a local repo for development, adding connection to upstream element and alpha wallet repos.
# Also assumes that element-android and alpha-wallet-android tags do not clash
set -e

echo Preparing open-super-dapp-android repo for development...

SCRIPT=./open-super-dapp/scripts/setup-local-repo.sh
if [ -f "$SCRIPT" ]; 
then
  echo Detected $SCRIPT script. 
else 
  echo "$SCRIPT does not exist. Are you in the project root directory? Aborting."
  exit 1
fi

if [ -z "$1" ]; 
  then 
    echo Must provide element-android version and alpha-wallet-android version
    exit 2
fi  

if [ -z "$2" ]; 
  then 
    echo Must provide alpha-wallet-android version
    exit 3
fi  

echo This script will add remote connections to the element-android and alpha-wallet-android
echo and will reset the state of the element-main and alpha-wallet-main branches as needed.
echo Please ensure you have committed or stashed your commits before continuing.
read -p "Continue? (y/N) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo Beginning setup...
else
  echo Exiting...
  exit 4      
fi

# Save current branch
START_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo Saved starting branch $START_BRANCH.

# Stash changes just in case the user did not
echo Stashing any changes if user did not...
git add --all 
git stash

echo Setting git config merge.renameLimit 999999 for this repo to assist in matching renaming...
git config merge.renameLimit 999999

if git remote -v |  awk '{print $1}' | grep -q element-android
then  
  echo Found element-android git remote
else
  git remote add element-android https://github.com/vector-im/element-android
  echo Added element-android git remote
fi

echo Fetching changes and tags from element-android remote...
git fetch --tags element-android

if git remote -v |  awk '{print $1}' | grep -q alpha-wallet-android
then  
  echo Found alpha-wallet-android git remote
else
  git remote add alpha-wallet-android https://github.com/AlphaWallet/alpha-wallet-android
  echo Added alpha-wallet-android git remote
fi

echo Fetching changes and tags from alpha-wallet-android remote...
git fetch --tags alpha-wallet-android

ELEMENT_VERSION_EXISTS=$(git ls-remote element-android refs/tags/$1)
if [ -z "$ELEMENT_VERSION_EXISTS" ];
  then
    echo No such element-android tag $1. Exiting.
    exit 5
fi  

ALPHA_VERSION_EXISTS=$(git ls-remote alpha-wallet-android refs/tags/$2)
if [ -z "$ALPHA_VERSION_EXISTS" ];
  then
    echo No such alpha-wallet-android tag $2. Exiting.
    exit 6
fi    

if git branch | grep -q element-main
then
  echo element-main reference branch exists. Removing...
  git checkout main
  git branch -D element-main
fi  

echo Checking out element-android $1 as element-main...
git checkout tags/$1 -b element-main

echo Aligning element-main branch...
/bin/rm -rf .github .travis.yml fastlane Gemfile* towncrier.toml
git mv vector/* app/
rm -rf vector
git mv docs element
mkdir docs
git mv element docs/
git mv CONTRIBUTING.md AUTHORS.md CHANGES.md changelog.d LICENSE README.md docs/element/
mkdir -p scripts/element
git mv *.sh scripts/element/
git commit -am "Temporary commit to align element-main files and folders facilitate merging"
echo Done aligning element-android files and folders are now aligned and ready to be merged in.

# ---------------- 

if git branch | grep -q alpha-wallet-main
then
  echo alpha-wallet-main reference branch exists. Removing...
  git checkout main
  git branch -D alpha-wallet-main
fi  

echo Checking out alpha-wallet-android $2 as alpha-wallet-main...
git checkout tags/$2 -b alpha-wallet-main

echo Aligning alpha-wallet-main branch...
/bin/rm -rf .editorconfig Gemfile* .gitpod* fastlane .travis.yml .bundle dmz util contracts gradle* build.gradle package* settings.gradle BUILD.md gulpfile.js .github
git mv lib alpha-token-script
git mv docs alpha-wallet
mkdir docs
git mv alpha-wallet docs/
git mv scripts alpha-wallet
mkdir scripts
git mv alpha-wallet scripts/
git mv *.sh scripts/alpha-wallet/
git mv .all-contributorsrc LICENSE README.md docs/alpha-wallet/
git commit -am "Temporary commit to align alpha-wallet-main files and folders facilitate merging"

echo Leaving git on initial branch $START_BRANCH...
git checkout $START_BRANCH

echo Done! Your repo is now ready for development.
echo You can now merge element-main from element version $1 and alpha-wallet-main from version $2 into your development WIP branch
echo and resolve changes, etc. to upgrade open-super-dapp to new versions of its upstream repos.

