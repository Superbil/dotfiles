# TRAMP mode
# http://www.emacswiki.org/TrampMode
if [[ "$TERM" == "dumb" ]]; then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  PS1='$ '
  return
fi

# setup local env
if [[ -e $HOME/.zshenv-local ]]; then
    source $HOME/.zshenv-local
fi
