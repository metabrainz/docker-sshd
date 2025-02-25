#!/usr/bin/env bash

set -e -o pipefail -u

SCRIPT_NAME=$(basename "$0")

HELP=$(cat <<EOH
Usage: $SCRIPT_NAME

Create and push a Git tag on 'master' branch.
EOH
)

if [ $# -eq 1 ] && echo "$1" | grep -Eqx -- '-*h(elp)?'
then
  echo "$HELP"
  exit
elif [ $# -gt 0 ]
then
  echo >&2 "$SCRIPT_NAME: too many arguments"
  echo >&2 "$HELP"
  exit 64
fi

cd "$(dirname "${BASH_SOURCE[0]}")"

if ! (git diff --quiet && git diff --cached --quiet)
then
  echo >&2 "$SCRIPT_NAME: Git working tree has local changes"
  echo >&2
  echo >&2 "Your local changes might be missing from 'master' branch."
  echo >&2 "Please clean your Git working tree before tagging 'master'."
  exit 70
fi

git checkout master
git pull --ff-only

today_version_prefix="v-$(date +%Y-%m-%d)"
today_versions_count=$(git tag -l "${today_version_prefix}*" | grep --count '^.\+$' || true)
tag="${today_version_prefix}.${today_versions_count}"

if git tag --points-at HEAD | grep --quiet '^.\+$'
then
  message=$(git log -1 --pretty=%s)
else
  message='Trigger new build from the same files'
fi

set -x
git tag "$tag" -m "$message"
git push origin "$tag"

# vi: set et sts=2 sw=2 ts=2 :
