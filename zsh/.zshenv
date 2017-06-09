# TRAMP mode
# http://www.emacswiki.org/TrampMode
if [[ "$TERM" == "dumb" ]]; then
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
    return
fi

# Always use UTF-8
export LANG=en_US.UTF-8

# coreutils
BREW=/usr/local/bin/brew
if [ -x $BREW ] && [ -x "$($BREW --prefix coreutils)" ]; then
    export PATH="$($BREW --prefix coreutils)/libexec/gnubin:$PATH"
    export MANPATH="$($BREW --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

# setup local env
if [[ -e $HOME/.zshenv-local ]]; then
    source $HOME/.zshenv-local
fi
