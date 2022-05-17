#!/usr/bin/env zsh
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

if [[ -z "$INSIDE_EMACS" ]]; then
    ZSH_THEME=gentoo
else
    ZSH_THEME=imajes
fi
COMPLETION_WAITING_DOTS="true"

base_plugins=(
    colorize
    extract
    git
    gitfast
    git-flow-avh
    gnu-utils
    history
    sudo
    urltools
    z
)

for custom_plugin in $ZSH/custom/plugins/* ; do
    if [ $(basename $custom_plugin) != "example" ]; then
        base_plugins=($base_plugins $(basename $custom_plugin))
    fi
done

langs_plugins=(
    asdf
    # ruby
    gem
    # python
    pip
    pylint
    python
    # javascript
    yarn
)

darwin_plugins=(
    # homebrew
    brew
    # show time at prompt_char
    emoji-clock
    # useful for OS X
    macos
    # cocoapods
    pod
    # quickly to open project
    xcode
    # docker
    docker
    docker-compose
    # ibtool-gen, https://github.com/RudthMael/zsh-plugin-ibtool
    ibtool
    fzf
)

if [[ "$(uname -s)" == "Darwin" ]]; then
    plugins=($base_plugins $langs_plugins $darwin_plugins)
else
    plugins=($base_plugins $langs_plugins)
fi

source $ZSH/oh-my-zsh.sh

# Setup prompt_char to a ghost (in shell).
# don't let it work inside emacs
# Sometime, change PS1 style to emoji-clock to show less
# e.g. PS1='$(emoji-clock) '
if [[ -z "$INSIDE_EMACS" ]]; then
    function prompt_char {
        if [ $UID -eq 0 ]; then
            echo "#";
        else
            # If is ssh login, don't use emoji
            if [[ "$(uname -s)" == "Darwin" && -z "$SSH_TTY" ]]; then
                echo "👻";
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

# Aliases

# Useful helpers
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias df='df -h'            # Disk free, in gigabytes, not bytes
alias du='du -h -c'         # Calculate total disk usage for a folder
alias svim='sudo vim'       # Run vim as super user

# Global aliases
alias -g C='| wc -l'
alias -g EH='|& head'
alias -g EL='|& less'
alias -g G='| egrep --color=auto'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g M='| more'
alias -g T='| tail'
alias -g XG='| xargs egrep'
alias -g X='| xargs'

if (( $+commands[brew] )); then
    # Emacs on mac
    alias brew-emacs='open `brew --prefix emacs-mac`/Emacs.app'
    alias brew-emacs-debug='${brew-emacs} --args --debug-init'

    # Homebrew
    alias bout='brew outdated'
    alias bin='brew install'
    alias brm='brew uninstall'
    alias bls='brew list'
    alias bsr='brew search'
    alias binf='brew info'
    alias bdr='brew doctor'
fi

# Only for MacOS
if [[ "$(uname -s)" == "Darwin" ]]; then
    # iCloud
    alias icloud='cd ~/Library/Mobile\ Documents/'

    # Wifi Airport tool
    alias airport=/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport
fi

# local script folder
[ -d ${HOME}/bin ] && PATH=${HOME}/bin:$PATH

# find ip
function myip() {
    # dig +short opendns.com @resolver1.opendns.com
    curl -4 ifconfig.co # force use ipv4
    # curl ifconfig.me
}

function exip () {
    # gather external ip address
    echo -n "Current External IP: "
    myip
}

function ips () {
    # determine local IP address
    ifconfig | grep "inet " | awk '{ print $2 }'
}

# gitignore.io
function gi() { curl -sL http://www.gitignore.io/api/$@ ;}

# Run on new shell
function _fortune_say() {
    [ ! -e $NO_COWSAY ] && return

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

function ytdl-audio () {
    mpv --no-video --ytdl-format=bestaudio $@
}

function asdf-upgradVersion () {
    rm -f ~/.asdf/shims/* && asdf reshim
}

# Don't use fortune_say inside emacs
if [[ -z "$INSIDE_EMACS" ]]; then
    _fortune_say
else
    # This will show at emacs with term-mode
    echo "Note: <C-c C-j> to line mode, <C-c C-k> to char mode"
fi
