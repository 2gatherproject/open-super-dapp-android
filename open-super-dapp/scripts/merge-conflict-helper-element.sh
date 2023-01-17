#!/usr/bin/env bash
# Script to resolve many element merge conflicts in a desirable way. But must be confirmed afterward...
# NOTE! Assumes setup-local-repo.sh has been run previously
set -e

git merge --allow-unrelated-histories element-main
git checkout element-main app/src/main/java/im/
git checkout element-main app/src/test/java/im/
git checkout element-main library/
git checkout element-main matrix-sdk-android/
git checkout element-main vector-config/
git checkout element-main app/src/main/res/

echo "Helper has run"
echo "Check for unresolved merge conflicts, e.g. by searching for >>>>>, etc."
echo "Make sure to review and then commit changes"
