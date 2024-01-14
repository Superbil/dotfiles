#!/usr/bin/env zsh

#
# Executes commands at login before zshrc.
#
if [[ -z "$LANG" ]]; then
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
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

# Disable oh-my-zsh auto update
DISABLE_AUTO_UPDATE="true"
HOMEBREW_NO_ENV_HINTS=1

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
