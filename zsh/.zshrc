#!/usr/bin/env zsh
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gentoo"

COMPLETION_WAITING_DOTS="true"

plugins=(
    autojump
    brew
    git
    git-flow
    gnu-utils
    history
    mercurial
    node
    npm
    osx
    pip
    python
    rake
    ruby
    svn
    urltools
    vagrant
)

source $ZSH/oh-my-zsh.sh

# setup alias to eshell
if [[ -d $HOME/.eshell ]]; then
    alias | sed -E "s/^([^=]+)='*([^']+)'*$/alias \1 \2 \$*/g; s/'\\\''/'/g;" | sort | uniq > ~/.eshell/alias
fi

# Set Manpath for homebrew
manpath=(/usr/share/man /usr/local/share/man $manpath)

if [[ "$(uname -s)" =~ "(NetBSD|Darwin)" ]]; then
    # On NetBSD and OS X, test if "gls" (GNU ls) is installed (this one supports colors);
    # otherwise, leave ls as is, because NetBSD's ls doesn't support -G
    gls --color -d . &>/dev/null 2>&1 && alias ls='gls --color=tty'
else
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

# setup prompt_char to a burger, yummy
# don't let it work inside emacs
if [[ -z "$INSIDE_EMACS" ]]; then
    function prompt_char {
        if [ $UID -eq 0 ]; then echo "#"; else echo "🍔 "; fi
    }
fi

autoload zmvq
