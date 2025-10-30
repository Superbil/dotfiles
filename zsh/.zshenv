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
if [[ -e "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Ensure PATH is unique (removes duplicates)
typeset -gU path

_prepend_paths_in_order() {
    setopt localoptions noksharrays

    local -a paths=("$@")
    local dir_idx dir
    for (( dir_idx=${#paths[@]}; dir_idx >= 1; dir_idx-- )); do
        dir=${paths[dir_idx]}
        [[ -d "$dir" ]] || continue
        path=("$dir" ${path:#$dir})
    done
}

_ADD_PATHS=(
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    # yarn
    "${HOME}/.yarn/bin"
    "${HOME}/.local/bin"
    "${HOME}/.orbstack/bin"
    "${HOME}/bin"
)

# setup local env
if [[ -r $HOME/.zshenv-local ]]; then
    source $HOME/.zshenv-local
fi

# Persist path priority for later reuse (e.g., in .zshrc)
typeset -ga ZSH_PATH_PRIORITY=("${_ADD_PATHS[@]}")

_prepend_paths_in_order "${ZSH_PATH_PRIORITY[@]}"
export PATH
unset _ADD_PATHS

# Disable oh-my-zsh auto update
export DISABLE_AUTO_UPDATE=TRUE
zstyle ':omz:update' mode disabled

export HOMEBREW_NO_ENV_HINTS=TRUE
