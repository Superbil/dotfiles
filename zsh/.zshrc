#!/usr/bin/env zsh
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="gentoo"
# if [[ -z "$INSIDE_EMACS" ]]; then
#     ZSH_THEME="bira"
# else
#     ZSH_THEME="gentoo"
# fi

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

alias iq="ipython qtconsole &"
# fix over write app in "open With..." menu
alias fixow='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'
alias ec=$EDITOR


# alias of homebrew
alias b='brew'
alias be='brew edit'
alias bs='brew search'
alias bi='brew install --use-llvm'
alias bin='brew info'
alias bui='brew uninstall'
alias bh='brew home'

# caff always use yes to send mail
alias caff='caff -m yes'

if [[ -e $HOME/.zshrc-superbil ]]; then
    source $HOME/.zshrc-superbil
fi

if [[ "$(uname -s)" =~ "(NetBSD|Darwin)" ]]; then
    # On NetBSD and OS X, test if "gls" (GNU ls) is installed (this one supports colors);
    # otherwise, leave ls as is, because NetBSD's ls doesn't support -G
    gls --color -d . &>/dev/null 2>&1 && alias ls='gls --color=tty'
else
    ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'
fi

plugins=(
    brew
    git
    git-flow
    gnu-utils
    history
    mercurial
    osx
    pip
    python
    rake
    ruby
    svn
    urltools
    vagrant
)

# Create a list of directories to add to the path
local pathdirs
pathdirs=(
    /usr/local/bin              # homebrew
    /usr/local/sbin             # homebrew
    /usr/local/opt/ruby/bin     # homebrew's ruby
    $HOME/bin
    # $HOME/.rvm/bin              # RVM
    /usr/local/share/npm/bin    # NPM
)

# Add directories which exist to the path
for dir ($pathdirs) {
    if [[ -d $dir ]]; then
        path=($dir $path)
    fi
}

source $ZSH/oh-my-zsh.sh

# Set Manpath for homebrew
manpath=(/usr/share/man /usr/local/share/man $manpath)

# # python brew
# [[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"

# python path
export PYTHONPATH="/usr/local/lib/python2.7/site-packages"

## Emacs configure
EC_ARGS="emacsclient -c"
if [[ -z $SSH_CLIENT ]]; then
    export EDITOR="$EC_ARGS"
else
    export EDITOR="$EC_ARGS -t"
fi

# setup prompt_char to a burger, yummy
# don't let it work inside emacs
if [[ -z "$INSIDE_EMACS" ]]; then
    function prompt_char {
    if [ $UID -eq 0 ]; then echo "#"; else echo "🍔 "; fi
    }
fi

autoload zmvq
