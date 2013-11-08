# Create a list of directories to add to the path
local pathdirs
pathdirs=(
    /usr/local/bin              # homebrew
    /usr/local/sbin             # homebrew
    /usr/local/opt/ruby/bin     # homebrew's ruby
    /usr/local/share/npm/bin    # NPM
    $PYENV_ROOT/bin
    $HOME/bin
)

# Add directories which exist to the path
for dir ($pathdirs) {
    if [[ -d $dir ]]; then
        path=($dir $path)
    fi
}

## Emacs configure
if [[ -x '/usr/local/bin/emacsclient' ]]; then
    EC_ARGS="/usr/local/bin/emacsclient -c"
    if [[ -z $SSH_CLIENT ]]; then
        export EDITOR="$EC_ARGS"
    else
        export EDITOR="$EC_ARGS -t"
    fi
fi

# python setup
export PYTHONSTARTUP="~/.pythonrc"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

# setup local env
if [[ -e $HOME/.zshenv-superbil ]]; then
    source $HOME/.zshenv-superbil
fi
