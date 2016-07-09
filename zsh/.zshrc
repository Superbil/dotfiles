#!/usr/bin/env zsh
# Fix for tramp
[[ $TERM == "dumb" ]] && return

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
    nodejs # https://github.com/poying/zsh-nodejs-plugin
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
    vagrant
    # ibtool-gen, https://github.com/RudthMael/zsh-plugin-ibtool
    ibtool
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
            # If is ssh login, don't use emoji
            if [[ "$(uname -s)" == "Darwin" && -z "$SSH_TTY" ]]; then
                echo "👻 ";
            else
                echo "$"
            fi
        fi
    }
fi

# python setup
export PYTHONSTARTUP=$HOME/.pythonrc

# ignore history dupes
setopt hist_ignore_dups
# really ignore dupes
setopt hist_ignore_all_dups
# ignore dupes in history search
setopt hist_find_no_dups
# don't save dupes
setopt hist_save_no_dups
# if any command starts with whitespace, it will not be saved.
# it will still be displayed in the current session, though
setopt hist_ignore_space
# ignore `history' and `fc' commands
setopt hist_no_store

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

# Save key in keychain
# https://github.com/sorah/envchain
if [ -x $(which envchain) ]
then
    export `envchain homebrew env | grep GITHUB_API_TOKEN`
fi

# configure rvm
if [ -x $HOME/.rvm/scripts/rvm ]; then
    source $HOME/.rvm/scripts/rvm
fi

# Run on new shell
fortune_say() {
    local fortune=$(which fortune)
    local cowsay=$(which cowsay)
    [ ! -e $fortune ] && return

    if [ -e $cowsay ]; then
        # Random cow say
        if [ -d /usr/local/share/cows/ ]; then
            $fortune | $cowsay -f $(ls /usr/local/share/cows/ | shuf -n1)
        else
            $fortune | $cowsay -f small -pn
        fi
    else
        echo "" && $fortune && echo ""
    fi
}
# Don't use fortune_say inside emacs
if [[ -z "$INSIDE_EMACS" ]]; then
    fortune_say
fi

homebrew_upgrade() {
    if [ -n $SSL_CERT_FILE ]; then
        unset SSL_CERT_FILE
    fi
    brew update && brew upgrade
    brew cleanup
}
