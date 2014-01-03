#!/usr/bin/env zsh
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gentoo"

COMPLETION_WAITING_DOTS="true"

base_plugins=(
    colorize
    common-aliases
    copydir
    copyfile
    git
    git-flow-avh
    gnu-utils
    history
    svn
    urltools
    z
)

langs_plugins=(
    # ruby
    gem
    rake
    ruby
    vagrant
    # python
    pip
    pyenv
    pylint
    python
    # javascript
    node
    npm
)

darwin_plugins=(
    # homebrew
    brew
    # show time at prompt_char
    emoji-clock
    # Forklift.app
    forklift
    # useful for OS X
    osx
    # cocoapods
    pod
    # quickly to open project
    xcode
)

if [[ "$(uname -s)" == "Darwin" ]]; then
    plugins=($base_plugins $langs_plugins $darwin_plugins)
else
    plugins=($base_plugins $langs_plugins)
fi

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
        if [ $UID -eq 0 ]; then echo "#"; else echo "$(emoji-clock) "; fi
    }
fi

function wopen {
    open ${PWD##*/}.xcworkspace
} # open Xcode workspace

autoload zmvq
