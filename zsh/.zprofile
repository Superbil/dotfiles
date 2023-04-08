#!/usr/bin/env zsh

#
# Executes commands at login before zshrc.
#
if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
    export LANGUAGE=en_US.UTF-8
fi

# system-wide environment settings for zsh(1)
if [ -x "/usr/libexec/path_helper" ]; then
    eval `/usr/libexec/path_helper -s`
fi

if (( $+commands[brew] )); then
    # I use emacs-mac
    EC_PATH=$(brew --prefix emacs-mac)/bin/emacsclient
    if [ -x $EC_PATH ]; then
        EC_ARGS="${EC_PATH} -c"
        if [ -z $SSH_CLIENT ]; then
            export EDITOR="${EC_ARGS}"
        else
            export EDITOR="${EC_ARGS} -t"
        fi
    fi
fi

# Go
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin/:$PATH"

# eliminates duplicates in *paths
typeset -gU cdpath fpath path

# Some custom path for local
ADD_PATHS=(
    /Applications/Postgres.app/Contents/Versions/9.3/bin
    # yarn
    '$HOME/.yarn/bin'
)

for p in $ADD_PATHS; do
    if [ -d $p ]; then
        PATH=$p:$PATH
    fi
done
