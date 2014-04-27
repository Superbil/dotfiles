#!/usr/bin/env bash

Target=$HOME
STOW=stow

for arg in $*
do
    if [[ -d $arg ]]; then
        echo "Installing $arg"
        stow -t $Target $arg
    else
        echo "$arg don't existed won't install"
    fi
done
