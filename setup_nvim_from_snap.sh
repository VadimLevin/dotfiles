#!/usr/bin/env zsh

NVIM_START_PATH=$(realpath $(dirname "$0")/start_nvim_from_snap.sh)

for alt (vi vim vimdiff); do
    echo "Setting alternative to '$alt'..."
    update-alternatives --install /usr/bin/$alt $alt $NVIM_START_PATH 110
    update-alternatives --set $alt $NVIM_START_PATH
done

