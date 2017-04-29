#!/usr/bin/env bash

TARGET=$HOME
STOW=$(which stow)

for ARG in $*
do
    if [[ -d $ARG ]]; then
        echo "Installing $ARG"
        stow -t $TARGET $ARG
    else
        echo "$ARG don't existed won't install"
    fi
done
