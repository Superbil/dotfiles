#!/usr/bin/env zsh

#
# Executes commands at login before zshrc.
#
if [[ -z "$LANG" ]]; then
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
fi

# system-wide environment settings for zsh(1)
if [ -x "/usr/libexec/path_helper" ]; then
    eval `/usr/libexec/path_helper -s`
fi

# setup brew path for Apple M CPU
if [ -e "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# eliminates duplicates in *paths
typeset -gU cdpath fpath path

# Some custom path for local
ADD_PATHS=(
    /Applications/Postgres.app/Contents/Versions/9.3/bin
    # yarn
    '$HOME/.yarn/bin'
    # go
    '$GOPATH'
)

for p in $ADD_PATHS; do
    if [ -d $p ]; then
        PATH=$p:$PATH
    fi
done

if (( $+commands[fzf] )); then
    export FZF_DEFAULT_OPTS='
--border
--multi
--header="(∩ ◕_▩ )⊃━☆ﾟExplosion！"
--layout=reverse
--prompt="(´・ω・`) "
'
    export FZF_DEFAULT_OPTS='--multi --layout=reverse'
fi
