#!/usr/bin/env zsh
# .zprofile
# Executes commands at login before zshrc.
#
if [[ -z "$LANG" ]]; then
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
fi

export FZF_DEFAULT_OPTS='
--border
--multi
--header="(∩ ◕_▩ )⊃━☆ﾟExplosion！"
--layout=reverse
--prompt="(´・ω・`) "
'
