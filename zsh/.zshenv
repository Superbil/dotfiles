#!/usr/bin/env zsh
# .zshenv
# this file is always sourced. It often contains exported variables
# that should be available to other programs. For example, $PATH,
# $EDITOR, and $PAGER are often set in .zshenv. Also, you can set
# $ZDOTDIR in .zshenv to specify an alternative location for the rest of your zsh configuration.

# TRAMP mode
# https://www.emacswiki.org/emacs/TrampMode
if [[ "$TERM" == "dumb" ]]; then
    unset zle_bracketed_paste
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    if whence -w precmd >/dev/null; then
        unfunction precmd
    fi
    if whence -w preexec >/dev/null; then
        unfunction preexec
    fi
    PS1='$ '
    # auto load local shell-env
    if [[ -r $HOME/.emacs.d/shellenv ]]; then
        source $HOME/.emacs.d/shellenv
    fi
    return
fi

# system-wide environment settings for zsh(1)
if [ -x "/usr/libexec/path_helper" ]; then
    eval "$(/usr/libexec/path_helper -s)"
fi

# setup brew path for Apple M CPU
if [ -e "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

_ADD_PATHS=(
    # yarn
    "$HOME/.yarn/bin"
    # go
    "$GOPATH"
    "${HOME}/bin"
)

# setup local env
if [[ -r $HOME/.zshenv-local ]]; then
    source $HOME/.zshenv-local
fi

for p in $_ADD_PATHS; do
    if [ -d $p ]; then
        PATH=$p:$PATH
    fi
    unset _ADD_PATHS
done
