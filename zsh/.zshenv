#!/usr/bin/env zsh
# .zshenv
# this file is always sourced. It often contains exported variables
# that should be available to other programs. For example, $PATH,
# $EDITOR, and $PAGER are often set in .zshenv. Also, you can set
# $ZDOTDIR in .zshenv to specify an alternative location for the rest of your zsh configuration.

# system-wide environment settings for zsh(1)
if [ -x "/usr/libexec/path_helper" ]; then
    eval "$(/usr/libexec/path_helper -s)"
fi

# setup brew path for Apple M CPU
if [[ -e "/opt/homebrew/bin/brew" && ! ${PATH} =~ "/opt/homebrew/bin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

_ADD_PATHS=(
    # yarn
    "${HOME}/.yarn/bin"
    "${HOME}/.local/bin"
    "${HOME}/bin"
    "${HOME}/.orbstack/bin"
)

# setup local env
if [[ -r $HOME/.zshenv-local ]]; then
    source $HOME/.zshenv-local
fi

for p in $_ADD_PATHS; do
    if [ -d $p ]; then
        export PATH=$p:$PATH
    fi
done
unset _ADD_PATHS

# Disable oh-my-zsh auto update
export DISABLE_AUTO_UPDATE=TRUE

export HOMEBREW_NO_ENV_HINTS=TRUE
