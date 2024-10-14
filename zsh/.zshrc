#!/usr/bin/env zsh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# TRAMP mode
# https://www.emacswiki.org/emacs/TrampMode
if [[ "$TERM" == "dumb" ]]; then
    unset RPROMPT
    unset RPS1
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    # Inhibit loading of further config files
    unsetopt rcs
    if whence -w precmd >/dev/null; then
        unfunction precmd
    fi
    if whence -w preexec >/dev/null; then
        unfunction preexec
    fi
    # fix enabled some kind of paste support
    unset zle_bracketed_paste

    export LANG=en_US.UTF-8
    export PS1='$ '
    return
fi

# Disable oh-my-zsh auto update
export DISABLE_AUTO_UPDATE=TRUE
export HOMEBREW_NO_ENV_HINTS=TRUE

# eliminates duplicates in *paths
typeset -gU cdpath

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
    direnv
    extract
    fzf
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
    emacs
)

if [[ "$(uname -s)" == "Darwin" ]]; then
    plugins=($base_plugins $langs_plugins $darwin_plugins)
else
    plugins=($base_plugins $langs_plugins)
fi

source $ZSH/oh-my-zsh.sh

# Setup prompt_char to a ghost (in shell).
# don't let it work inside emacs
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

# history length
HISTSIZE=500000
SAVEHIST=$HISTSIZE
# Write to the history file immediately, not when the shell exits.
setopt inc_append_history
# Treat the '!' character specially during expansion.
setopt bang_hist
# Expire duplicate entries first when trimming history.
setopt hist_expire_dups_first
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
# # Don't execute immediately upon history expansion.
setopt hist_verify
# Remove superfluous blanks before recording entry.
setopt hist_reduce_blanks
# Share history between all sessions.
setopt share_history

# setup local zshrc
if [ -r $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
fi

# Aliases

# Useful helpers
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias df='df -h'            # Disk free, in gigabytes, not bytes
alias du='du -h -c'         # Calculate total disk usage for a folder
# alias svim='sudo vim'       # Run vim as super user

# Global aliases
alias -g C='| wc -l'
alias -g EH='|& head'
alias -g EL='|& less'
if (( $+commands[rg] )); then
    alias -g G='| rg'
else
    alias -g G='| egrep --color=auto'
fi
alias -g H='| head'
alias -g HL='|& head -20'
alias -g M='| more'
alias -g T='| tail'
alias -g XG='| xargs egrep'
alias -g X='| xargs'

# Only for MacOS
if [[ "$(uname -s)" == "Darwin" ]]; then
    # iCloud
    alias icloud='cd ~/Library/Mobile\ Documents/'

    # Wifi Airport tool
    alias airport=/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport
fi

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
    if [[ "$(uname -s)" == "Darwin" ]]; then
        ifconfig | grep "inet " | awk '{ print $2 }'
    else
        ip addr | grep "inet " | awk '{ print $2 }'
    fi
}

function fortune_say() {
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

function listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color ":$1"
    else
        echo "Usage: listening [pattern]"
    fi
}

function load_pyenv() {
    export PYENV_ROOT="${PYENV_ROOT:=$HOME/.pyenv}"
    # Only run when pyenv existed
    if [ -d $PYENV_ROOT/bin ]; then
        export PATH="$PYENV_ROOT/bin:$PATH"
        if command -v pyenv 1>/dev/null 2>&1; then
            eval "$(pyenv init -)"
        fi
    fi
}

function load_iterm2_shell() {
    if [ -e "$HOME/.iterm2_shell_integration.zsh" ]; then
        source "$HOME/.iterm2_shell_integration.zsh"
    else
        echo "No .iterm2_shell_integration.zsh to load"
    fi
}
