#!/usr/bin/env bash

TARGET=$HOME

_stow=$(which stow)

for arg in "$@"
do
    if [[ -d $arg ]]; then
        echo "Installing $arg"
        $_stow -t "$TARGET" $arg
    else
        echo "$ARG don't existed won't install"
    fi
done
