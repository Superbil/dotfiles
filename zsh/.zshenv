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
if [ -x $BREW ]; then
    COREUTILS_PATH="$($BREW --prefix coreutils)"
    if [ -x $COREUTILS_PATH ]; then
        export PATH=$COREUTILS_PATH/libexec/gnubin:$PATH
        export MANPATH=$COREUTILS_PATH/libexec/gnuman:$MANPATH
    fi
fi

# local script folder
[ -d ${HOME}/bin ] && PATH=${HOME}/bin:$PATH

# setup local env
if [[ -e $HOME/.zshenv-local ]]; then
    source $HOME/.zshenv-local
fi
