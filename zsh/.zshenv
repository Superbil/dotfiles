#!/usr/bin/env zsh

# Disable oh-my-zsh auto update
DISABLE_AUTO_UPDATE="true"

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

# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# python setup
export PYTHONSTARTUP=$HOME/.pythonrc

export HOMEBREW_NO_ENV_HINTS=1

# setup local env
if [[ -r $HOME/.zshenv-local ]]; then
    source $HOME/.zshenv-local
fi
