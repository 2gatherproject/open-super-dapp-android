#!/usr/bin/env bash
# Script to resolve many alpha wallet merge conflicts in a desirable way. But must be confirmed afterward...
# NOTE! Assumes setup-local-repo.sh has been run previously
set -e

git merge --allow-unrelated-histories alpha-wallet-main
git checkout alpha-wallet-main alpha-token-script/
git checkout alpha-wallet-main app/src/main/java/com/alphawallet
git checkout alpha-wallet-main app/src/test/java/com/alphawallet
git checkout alpha-wallet-main app/src/androidTest/java/com/alphawallet
git checkout alpha-wallet-main app/src/analytics/java/com/alphawallet

echo "Helper has run"
echo "Check for unresolved merge conflicts, e.g. by searching for >>>>>, etc."
echo "Make sure to review and then commit changes"
