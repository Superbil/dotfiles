#!/usr/bin/env zsh
# .zprofile
# Executes commands at login before zshrc.
#
if [[ -z "$LANG" ]]; then
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
fi

# Some custom path for local
ADD_PATHS=(
    # yarn
    '$HOME/.yarn/bin'
    # go
    '$GOPATH'
    "${HOME}/bin"
)

# Disable oh-my-zsh auto update
DISABLE_AUTO_UPDATE=TRUE
HOMEBREW_NO_ENV_HINTS=TRUE

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
