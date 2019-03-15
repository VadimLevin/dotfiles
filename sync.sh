#!/bin/bash

sync_dotfiles_folder_with_home() {
  rsync --exclude ".git/" \
        --exclude "README.md" \
        --exclude "sync.sh" \
        -avh . ~;
}

check_if_on_master() {
  echo "Checking current branch..."
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  if [ "$BRANCH" != "master" ]
  then
    echo -e "Not on master. Aborting...\n"
    exit 0
  else
    echo "Current branch is master"
  fi
}

check_uncommited_changes() {
  local TREAT_AS_ERROR=$1
  echo "Checking uncommitted changes..."
  local UNCOMMITTED_CHANGES=$(git status --porcelain)
  if [ "$UNCOMMITTED_CHANGES" ]
  then
    if [ "$TREAT_AS_ERROR" ]
    then
      echo -e "Index contains uncommitted changes. Aborting...\n"
      exit 0
    else
      echo "Warning! Index contains uncommitted changes."
    fi
  else
    echo "Working directory is clean"
  fi
}

sync_with_remote() {
  check_uncommited_changes true
  git pull origin
}

check_sync_with_remote() {
  echo "Checking if master is up to date with remote..."
  git fetch
  LOCAL_HASH=$(git rev-parse HEAD)
  REMOTE_HASH=$(git rev-parse master@{upstream})
  BASE_HASH=$(git merge-base @ master@{upstream})
  if [ "$LOCAL_HASH" == "$REMOTE_HASH" ]
  then
    echo "Master is up to date with origin/master"
  elif [ "$REMOTE_HASH" == "$BASE_HASH" ]
  then
    echo "Remote branch is outdated. Please push local changes!"
    echo -e "Aborting...\n"
    exit 0
  elif [ "$LOCAL_HASH" == "$BASE_HASH" ]
  then
    echo -e "Current branch is outdated. Trying to sync..."
    sync_with_remote
  else
    echo -e "FATAL ERROR! Repository is diverged!\n"
    exit 0
  fi
}

main() {
  check_if_on_master
  check_sync_with_remote
  check_uncommited_changes
  if [ "$1" == "--force" -o "$1" == "-f" ]
  then
    echo "Force sync"
    sync_dotfiles_folder_with_home
  else
    echo "WHOA! Some of your home directory files may be overwritten."
    read -p "Are you sure? (y/n) " -n 1;
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      sync_dotfiles_folder_with_home
    else
      echo "Dotfiles sync is canceled!"
    fi
  fi
}

(cd "$(dirname "${BASH_SOURCE}")" && main)

