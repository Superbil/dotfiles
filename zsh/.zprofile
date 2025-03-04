#!/usr/bin/env zsh
# .zprofile
# Executes commands at login before zshrc.
#
export LANG=en_US.UTF-8

# TODO: check tmux in ssh mode, then don't add  --tmux center
export FZF_DEFAULT_OPTS='
--border
--multi
--header="(∩ ◕_▩ )⊃━☆ﾟExplosion！"
--layout=reverse
--prompt="(´・ω・`) "
'
# CTRL-T Paste the selected files and directories onto the command-line
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --border
  --layout=reverse
  --header '(∩ ◕_▩ )⊃━☆ﾟ Press CTRL-Y to copy command into clipboard'"
