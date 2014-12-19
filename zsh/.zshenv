
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Useful helpers
alias ping='ping -c 5'      # Pings with 5 packets, not unlimited
alias df='df -h'            # Disk free, in gigabytes, not bytes
alias du='du -h -c'         # Calculate total disk usage for a folder
alias svim='sudo vim'       # Run vim as super user

# setup local env
if [[ -e $HOME/.zshenv-local ]]; then
    source $HOME/.zshenv-local
fi
