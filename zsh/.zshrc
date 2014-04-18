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
)

if [[ "$(uname -s)" == "Darwin" ]]; then
    plugins=($base_plugins $langs_plugins $darwin_plugins)
else
    plugins=($base_plugins $langs_plugins)
fi

source $ZSH/oh-my-zsh.sh

# Set Manpath for homebrew
manpath=(/usr/share/man /usr/local/share/man $manpath)

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

# while had $HOME/perl5/lib/perl5 eval it
# that can install cpan without sudo
if [[ -d $HOME/perl5/lib/perl5 ]]; then
    eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
fi

autoload zmvq
