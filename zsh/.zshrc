#!/usr/bin/env zsh
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gentoo"
COMPLETION_WAITING_DOTS="true"

base_plugins=(
    colorize
    copydir
    copyfile
    extract
    git
    git-flow-avh
    gnu-utils
    history
    svn
    sudo
    urltools
    z
)
if [[ -d $ZSH/custom/plugins/zsh-syntax-highlighting ]]; then
    base_plugins=($base_plugins zsh-syntax-highlighting)
fi

langs_plugins=(
    # ruby
    gem
    rake
    ruby
    rvm
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
    docker
)

if [[ "$(uname -s)" == "Darwin" ]]; then
    plugins=($base_plugins $langs_plugins $darwin_plugins)
else
    plugins=($base_plugins $langs_plugins)
fi

source $ZSH/oh-my-zsh.sh

# local script folder
[ -d $HOME/bin ] && PATH=$HOME/bin:$PATH

# setup prompt_char to a burger, yummy
# don't let it work inside emacs
if [[ -z "$INSIDE_EMACS" ]]; then
    function prompt_char {
        if [ $UID -eq 0 ]; then
            echo "#";
        else
            if [[ "$(uname -s)" == "Darwin" ]]; then
                echo "$(emoji-clock) ";
            else
                echo "$"
            fi
        fi
    }
fi

# TRAMP mode
# http://www.emacswiki.org/TrampMode
if [[ "$TERM" == "dumb" ]]; then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
  PS1='$ '
fi

## Emacs configure
EC_PATH=$(which emacsclient)
if [ -x $EC_PATH ]; then
    local EC_ARGS="${EC_PATH} -c"
    if [ -z $SSH_CLIENT ]; then
        export EDITOR="${EC_ARGS}"
    else
        export EDITOR="${EC_ARGS} -t"
    fi
fi
unset EC_PATH

# configure rvm
if [ -x $HOME/.rvm/scripts/rvm ]; then
    source $HOME/.rvm/scripts/rvm
fi

# python setup
export PYTHONSTARTUP=$HOME/.pythonrc

# HISTIGNOREDUPS prevents the current line from being saved in the history if it is the same as the previous one;
setopt histignoredups

# setup local zshrc
if [ -r $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
fi

# While had $HOME/perl5 eval it
# that can install cpan without sudo
# https://github.com/Homebrew/homebrew/wiki/Gems,-Eggs-and-Perl-Modules#perl-cpan-modules-without-sudo
if [[ -x $HOME/perl5/lib/perl5 ]]; then
    eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Run on new shell
local FORTUNE=$(which fortune)
if [ -e $FORTUNE ]; then
    echo ""
    fortune
    echo ""
fi
