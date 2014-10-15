## Emacs configure
local ec_path=/usr/local/bin/emacsclient
if [[ -x $ec_path ]]; then
    local EC_ARGS="${ec_path} -c"
    if [[ -z $SSH_CLIENT ]]; then
        export EDITOR="${EC_ARGS}"
    else
        export EDITOR="${EC_ARGS} -t"
    fi
fi

# python setup
export PYTHONSTARTUP=$HOME/.pythonrc

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Create a list of directories to add to the path
local pathdirs
pathdirs=(
    /usr/local/bin              # homebrew
    /usr/local/sbin             # homebrew
    $HOME/.rvm/bin              # RVM
    $HOME/bin
)

# Add directories which exist to the path
for dir ($pathdirs) {
    if [[ -d $dir ]]; then
        path=($dir $path)
    fi
}

# setup TERM to 256 color
export TERM=xterm-256color

# Useful helpers
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias df='df -h'            # Disk free, in gigabytes, not bytes
alias du='du -h -c'         # Calculate total disk usage for a folder
alias svim='sudo vim'       # Run vim as super user

# setup local env
if [[ -e $HOME/.zshenv-superbil ]]; then
    source $HOME/.zshenv-superbil
fi
